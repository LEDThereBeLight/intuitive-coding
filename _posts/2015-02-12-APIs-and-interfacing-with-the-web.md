---
layout: post
title: "What is an API?"
subtitle: "Integrating the internet into our app"
section: app-building
comments: true
---

### In progress section

You've been warned.

### Pulling GIFs from the web

It's finally time to extend our app to pull in images from the web, rather than just showing the GIFs we hardcoded into the page. We'll add a search bar for the user to choose a category of picture which will be fetched from the Giphy API and shown on the page.

### So... what's an API?

API stands for **application program interface**. The key word here is **interface**, which you'll see again and again in programming. An interface is an abstract concept meaning a set of rules for how to use something. When writing programs, we typically *implement* the program one way under the hood, and then provide an *interface* for users to interact with our program. Separating the implementation from the interface is important because as long as we don't change the way the user interacts with our program, we can change its implementation whenever we want (to make it more efficient or fix bugs).

Many larger websites provide an API, which is a way for coders to interact with the site and pull information without having to manually browse through the pages of the website. We can write a program to access the API using the set of rules the website defines, and they will send back to us the information we're asking for.

If you've ever seen a Twitter feed embedded into a website, for example, it's probably accessing tweets using the Twitter API and just displaying them on the page.

### Changing our view

Let's change our view to add an HTML `input` for our search bar and get rid of the three buttons we were using to display pictures. We'll also add a "more please!" button that we'll use to trigger a search.

{% highlight haskell %}
view : Model -> Html Message
view model = div
  [ pageStyling ]
  [
    h1 [ headingStyling ] [ text model.title ],
    input [] [],
    br [] [],
    br [] [],
    button [ buttonStyling ] [ text "more please!" ],
    br [] [],
    br [] [],
    img [ imageStyling, src model.picture ] []
  ]
{% endhighlight %}

An `input` element, by default, is just a text box that we can type in. We'll style it first, and then add functionality.

{% highlight haskell %}
inputStyling =
    style
        [
          ( "padding-top", "16px" ),
          ( "padding-bottom", "6px" ),
          ( "width", "188px" ),
          ( "outline", "none" ),
          ( "color", "#000" ),
          ( "font-size", "16px" ),
          ( "font-weight", "400" ),
          ( "border", "none" ),
          ( "border-bottom", "2px solid #99ddff" )
        ]

view model = div
  {- ... -}
  input [ inputStyling ] [],
  {- ... -}
  ]
{% endhighlight %}

You can look up what any of these CSS styles do using any online CSS reference sites.

### A new model

We can type in our textbox now, but we're not saving the text anywhere, so it doesn't really do much good. If we want to keep track of the text in the textbox, we need to add it to the model.

Let's add a new String field in our model that we'll use to keep track of the words in the search box.

{% highlight haskell %}
type alias Model =
    {
      title : String,
      picture : String,
      searchText : String
    }
{% endhighlight %}

We'll then change the `value` HTML attribute of the input element to use the model's `searchText`. Remember, HTML attributes go in the input to the function.

{% highlight haskell %}
view model = div
  {- ... -}
  input [ inputStyling, value model.searchText ] [],
  {- ... -}
  ]
{% endhighlight %}

We can also add a "placeholder", an HTML attribute that only shows up if there's no text present in the box.

{% highlight haskell %}
view model = div
  {- ... -}
  input [
          inputStyling,
          value model.searchText,
          placeholder "search"
        ]
        [],
  {- ... -}
  ]
{% endhighlight %}

We're going to want to update the model so that the searchText changes whenever anything is typed into the box. Let's go ahead and just print the model to the screen so we can test it easily first.

{% highlight haskell %}
view model = div
  {- ... -}
  input [
          inputStyling,
          value model.searchText,
          placeholder "search"
        ]
        [],
  text model.searchText,
  {- ... -}
  ]
{% endhighlight %}

Now we need to create a new message that we'll trigger when the text changes.

type Message
    = SearchTextChanged String

We're parameterizing the message with a String type because we're going to need to pass the new text to our update function whenever it's called. If we didn't have this, we would know that the text changed, but not what it changed *to*.

The HTML language has a builtin **event attribute** called "[onInput](https://developer.mozilla.org/en-US/docs/Mozilla/Tech/XUL/Attribute/oninput)" that triggers on an input element whenever its text is changed. Elm accordingly has a matching Event function to match this attribute.

We've already imported the Elm Html.Events module for when we used the "onClick" attribute with our old buttons. We'll use the "onInput" event the same way and trigger a new message whenever the text changes.

{% highlight haskell %}
view model = div
  {- ... -}
  input [
          inputStyling,
          value model.searchText,
          placeholder "search",
          onInput SearchTextChanged
        ]
        [],
  {- ... -}
  ]
{% endhighlight %}

Now we have to change our update function to get rid of the old button messages and handle our new SearchTextChanged message.

{% highlight haskell %}
update message model =
    case message of
        SearchTextChanged newText ->
            { model | searchText = newText }
{% endhighlight %}

Whenever the onInput message fires, it always provides the new, complete text inside the input box as a parameter to the message. We can capture this as a variable in our case statement's pattern matching and then set the model's searchText to this new text.

Now you should be able to type into the input box and see the model's searchText change on the screen.

### Upgrading our beginnerApp

It's time to add the functionality we need to pull in GIFs from the internet for use in our app. This is pretty complicated the first few times you see it, so don't be intimidated. *No one* understands it the first time through. As you work with it a few times, you'll start to see how everything fits together.

Elm's `beginnerApp` function doesn't allow us to interface with the web. We'll have to upgrade our program from a [`beginnerApp`](http://package.elm-lang.org/packages/elm-lang/html/2.0.0/Html#beginnerProgram) to a full-fledged [`program`](http://package.elm-lang.org/packages/elm-lang/html/2.0.0/Html#program).

`Html.program` still takes a Record as an input, but the Record has different fields from the model, view, and update we used for our `beginnerApp`.

Instead, `Html.program`'s Record input requires four fields:

  * init, a function to start our program off. This is used to create the default page before any user interaction
  * update, our normal `update` function extended to allow commands
  * subscriptions, a function that allows our program to "listen" to external input
  * our normal `view` function

Let's change our `main` function to use this new function, and then walk through how we can update the rest of our program to make everything fit together.

{% highlight haskell %}
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
{% endhighlight %}

### init

We'll start by explaining the `init` field in the program's input Record.

If you look at the type definition on `Html.program`'s documentation page, `init` is looking for a Tuple made of a Model and a Command capable of producing Messages. Here's what that looks like.

{% highlight haskell %}
init : ( Model, Cmd Message )
{% endhighlight %}

`Cmd` is a new type built into Elm that we haven't talked about before, short for "command". Remember that commands are a type of word in programming used to ask the computer to *do* something, whereas functions are used to *ask for* something. So `init` is telling us it is looking for a Cmd, which it will run automatically whenever we start our program.

In this case, Cmd is a parameterized type. It's capable of producing a Message when it runs, so the two types are linked together. We have to supply the Cmd type with a Message input whenever we use it.

Let's define the `init` function.

{% highlight haskell %}
init :  ( Model, Cmd Message )
init = ( Model "" "" "", Cmd.none )
{% endhighlight %}

The three sets of `""` mean that `init` will initialize our model to an empty topic, picture, and searchText. It's just another way of saying this:

{% highlight haskell %}
-- Remember:
-- type alias Model =
--    { topic : String,
--      picture : String,
--      searchText : String }

init = ( { topic = "", picture = "", searchText = "" }, Cmd.none )
{% endhighlight %}

`none` is just a function in the Cmd module (imported in Elm by default) which runs *no command* and doesn't trigger any messages. It's a way of doing nothing when something is expecting a Cmd to be passed to it.

### Subscriptions

Let's talk about the `subscriptions` field. Subscriptions let us listen for changes from anything that we don't directly control within our app. We just *subscribe* to the events we're interested in. We might have a subscription for the time, which updates every second. Or we might have a subscription to a Twitter account that triggers whenever there's a new Tweet from that profile. In our case, we don't need any subscriptions. We only need to make a change when the user submits a new search term, which is handled within our app.

Just like the `Cmd` module has a `Cmd.none` function to represent *no* command, the `Sub` module has a `Sub.none` function to represent *no* subscription.

So we can declare our subscriptions function like this:

{% highlight haskell %}
subscriptions : Model -> Sub Message
subscriptions model = Sub.none
{% endhighlight %}

`Html.program` is set up to accept a *function* from Model to Subscription in its input Record, not just a Subscription *value*. That's why we need to set up our `subscriptions` function like this: to get the types to match up.

### Updating the `update`

Now that we're using `Html.program`, we need to change our `update` function from

{% highlight haskell %}
update : Message -> Model -> Model
{% endhighlight %}

to

{% highlight haskell %}
update : Message -> Model -> ( Model, Cmd Message )
{% endhighlight %}

In other words, whenever the `update` function runs, it will also always run a Cmd in addition to providing an updated model.

Let's get the types to match up by updating what happens when we receive a SearchTextChanged message.

{% highlight haskell %}
update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        SearchTextChanged newText ->
            ( { model | searchText = newText }, Cmd.none )
{% endhighlight %}

The program should run now. But it doesn't do anything when we click the search button. We'll handle that next.

### Fetching new pictures

When we click the "more please!" button, we want to trigger a new message that will get a picture from the internet. Let's add our message first, and then handle the functionality.

We'll make a new message called `AskedForNewPic`.

{% highlight haskell %}
type Message
    = SearchTextChanged String
    | AskedForNewPic
{% endhighlight %}

We'll also add a way to trigger this message in our view.

{% highlight haskell %}
view : Model -> Html Message
view model = div
  [ pageStyling ]
  [
    h1 [ headingStyling ] [ text model.title ],
    input [] [],
    br [] [],
    br [] [],
    button [ buttonStyling, onClick AskedForNewPic ] [ text "more please!" ],
    br [] [],
    br [] [],
    img [ imageStyling, src model.picture ] []
  ]
{% endhighlight %}

Now we need to handle it in the update function.

{% highlight haskell %}
update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        SearchTextChanged newText ->
            ( { model | searchText = newText }, Cmd.none )

        AskedForNewPic ->
            ( { model | topic = model.searchText }, getRandomGif model.searchText )
{% endhighlight %}

We're updating the model's topic and running a not-yet-defined function `getRandomGif`, which we'll pass the model's searchText as an input. This function will need to ask Giphy's API for a picture, and we'll take the response and display it on the page.

Before we define the getRandomGif function, let's talk more about APIs.

### HTTP requests

We won't explain how HTTP requests work because there are already lots of good places online that talk about them. [marksheet.io](http://marksheet.io/internet.html) should get you started. We're going to make a function that will request an image from giphy.com using [Giphy's API](http://api.giphy.com/).

### The Giphy API

Online APIs all tend to work the same way. You request information from an **endpoint**, which is just a specific URL, like `http://api.giphy.com/v1/gifs/search?q=funny+cat`.

Typically, APIs require users to have a **public key**, which identifies you as a specific user. It's "public" because it acts kind of like your username for a website. It's not confidential, it's just a way of identifying you. Most sites require signing up with an account to use their API to prevent spammers from hitting their web servers and costing them money. Fortunately, Giphy provides a test public key for anyone to use without signing up for an account, which you can find on its [Github page](https://github.com/Giphy/GiphyAPI).

The public access key is

dc6zaTOxFJmzC
{: .quote}

We'll use this in a moment.

### The Random endpoint

In Giphy's API documentation, there's a section that mentions a [random endpoint](https://github.com/Giphy/GiphyAPI#random-endpoint) that returns a single random GIF by topic. We can use that to fetch a random picture for use in our app. Basically what we're going to do is send a **request** to that endpoint, and the Giphy server will send us back a **response** with the information we want. Then we can **parse** the information, which just means to convert the raw text in the response into a useable format, so that we can display the image on our page.

The easiest way to understand the big picture here is to make some test requests to the endpoint so you can see what the response data looks like.

### Postman

You can make requests to API endpoints using your computer terminal, but it's kind of a pain. [Postman](https://www.getpostman.com/) is an app that simplifies the process for us. Go ahead and download it and we'll walk through how to use it.

When you open up Postman, you'll see something like this.

![postman](/images/postman.png)

Let's use Postman to make a request from the Giphy API at the Random endpoint. The address for the Random endpoint, which you can find on the Github API page, is:

http://api.giphy.com/v1/gifs/random
{: .quote}

The docs also have an example request URL, as in

http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=american+psycho
{: .quote}

Let's see what happens when we make a request to *just* the endpoint, without any of the junk at the end of the URL.

Enter the endpoint into Postman, set the request type to "GET", and click "Send".
`http://api.giphy.com/v1/gifs/random`
{: .info}
![no parameters](images/postman-request-no-params.png)

When you click send, you'll get a *response* that looks something like this:

![401](images/postman-401.png)

The response is in [JSON](https://developer.mozilla.org/en-US/docs/Glossary/JSON) format, which is a data format modeled off of Javascript's object notation. JSON is an alternative to XML, if you've ever worked with that.

See the "status: 401"? Anytime someone makes a request to a web server, the server sends back a **status code** that says whether the request passed or failed.

You've undoubtedly seen status code 404 before.

![404](http://www.emarketeers.com/e-insight/wp-content/uploads/2011/06/Error404-Google.png)

There are a few different categories of status codes to be aware of. You don't need to know the individual status codes - you can always [google them](https://en.wikipedia.org/wiki/List_of_HTTP_status_codes) - but knowing the categories is very helpful.

<div class="table">
  <table>
    <tr>
      <th>100 series</th>
      <td><code>100</code><br/>
      <code>102</code>
      </td>
      <td><code>Continue</code><br><code>Processing</code></td>
      <td>1XX codes are rarely used and not worth knowing. They're just included here so you don't wonder about them.</td>
    </tr>
    <tr>
      <th>200 series</th>
      <td><code>200</code><br/><code>204</code></td>
      <td><Code>OK</code><br/><code>No Content</code></td>
      <td>2XX codes mean the request was handled successfully. If there's information at that web address, you'll receive it in the response.</td>
    </tr>
    <tr>
      <th>300 series</th>
      <td>
      <code>301</code>
      </td>
      <td><code>Moved Permanently</code></td>
      <td>3XX codes mean the address you're requesting has changed, and you should go to a new address instead. Your browser automatically follows these redirects.</td>
    </tr>
    <tr>
      <th>400 series</th>
      <td><code>401</code><br/><code>404</code></td><td><code>Unauthorized</code><br/><code>Not Found</code></td>
      <td>4XX codes mean there was a problem with your request. Either you're not logged in, or the page wasn't found on the server.</td>
    </tr>
    <tr>
      <th>500 series</th>
      <td><code>500</code><br/><br/><code>503</code></td>
      <td><code>Internal Server Error</code><br/><code>Service Unavailable</code></td>
      <td>5XX codes mean your request was fine, but there was an error on the server - either it's down for maintenance, or something unexpected happened.</td>
    </tr>
  </table>
</div>

In our case, we get a 401 status with the error code "invalid_api_key". That's because Giphy's server requires every request to use an API key, so let's add one.

### URL Parameters

There are three ways that I know of to send information to a web server in a request.

1. In the request **body**
  * A body is just a string of characters that is passed to the web server along with the request. In order to include a body, we have to make a `POST` request. Whenever we submit forms online, we're usually making a `POST` request with a body attached. `GET` requests, like typing in the URL into your browser, do not have bodies.
2. In the request **headers**
  * Headers are just a set of key/value pairs of text that are sent by the browser along with your request. Your browser typically hides them from you because most people don't care to see them. **Cookies**, for example, are just text strings that our browser sends along with our requests
3. As a URL **parameter** in a **query string**
  * Parameters are just another word for inputs. Whenever we make a request, we can add parameters to our request that the web server can handle.
  * We add parameters to requests by adding a query string to the end of the URL, which is literally just a `?` symbol followed by the parameter names and values.

Giphy's API is set up to look for URL parameters in the form of a query string.

For example, in the URL

http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=american+psycho
{: .quote}

The text `?api_key=dc6zaTOxFJmzC&tag=american+psycho` is a query string. The query string contains two parameters, separated by the `&` symbol.


<div class="table">
  <table>
    <tr>
      <th>Names</th>
      <th>Values</th>
    </tr>
    <tr>
      <td>
        api_key
        <br/>
        tag
      </td>
      <td>
        dc6zaTOxFJmzC
        <br/>
        american+psycho
      </td>
    </tr>
  </table>
</div>

The web server at Giphy is programmed to look for these names and handle the values assigned to them with the `=` sign.

If it handles them successfully, it will return the information we request - otherwise, it will send back an error code.

### Sending a request with parameters

Let's go ahead and add a query string with some parameters to our URL and make a new request using Postman.

We'll use the same example URL we just talked about:

http://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag=american+psycho
{: .quote}

Now, the response looks different.

![response with parameters](images/response-with-parameters.png)

We get back a bunch of information, more than we want. We'll need to write code to **parse** the response, or pull out the image URL from it so that we can display it on our page.

The only piece of information we need is the `image_url`, which is nested in the JSON response like this:

<ul class="files">
  <li>
    <i class="fa fa-folder-o"></i>
    data
    <ul>
      <li>
        <i class="fa fa-file-code-o"></i>
        image_url
      </li>
    </ul>
  </li>
</ul>

We need a way to access the nested information, and we can do that with Elm **decoders**.

### Parsing with decoders

There's a whole module named [Json.Decode](http://package.elm-lang.org/packages/elm-lang/core/latest/Json-Decode) made for decoding text data in the JSON format and putting it into structures that we can use in our code.

We need to import the `Json.Decode` module first at the top of our file.

{% highlight haskell %}
import Json.Decode as Decode
{% endhighlight %}

With this `import` statement, we're adding in one more concept. In addition to being able to expose modules to be used without any module prefix, we can also choose to use a module prefix, but with a different name. In this case, we're going to use Json.Decode functions `as` Decode, so we can write `Decode.function` instead of `Json.Decode.function`. This is standard practice in Elm development.

We could spend all day talking about JSON decoders (and we probably will at some point), but for now, we'll just use the simple [`Json.Decode.at` function](http://package.elm-lang.org/packages/elm-lang/core/latest/Json-Decode#at) to pull out the information.

If you need to use decoders for more complicated tasks, the best introduction to Elm decoders I've found is at [egghead.io](https://egghead.io/lessons/elm-decode-a-list-of-numbers-from-a-json-string-in-elm).

The type signature for `at` looks like this:

{% highlight haskell %}
Json.Decode.at : List String -> Decoder a -> Decoder a
{% endhighlight %}

It takes in a List of Strings that represent the location of our data, and a Decoder of any type, and gives back a new decoder of that same type. We'll then **use** this new decoder in our code on the response to pull out our `image_url`.

Let's make a decoder with the `Json.Decode.at` function.

{% highlight haskell %}
-- decodeGifUrl is a decoder that gives back a String
decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string
{% endhighlight %}

Here we're giving `Decode.at` a list of Strings to search "inside" for our data, and a String Decoder through Decode.string.

### GETting the image

Now that we have a Decoder that we can use to get the image URL from the JSON response, let's make a function that will fetch the image from Giphy.

Making a request from a web server is an action, so we'll need to make a command.

{% highlight haskell %}
getRandomGif : String -> Cmd Message
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag="
                ++ topic
    in
        Http.send NewGifReceived (Http.get url decodeGifUrl)
{% endhighlight %}

`getRandomGif` is a function that takes a String (a topic) and gives back a Cmd. Here we're using `++`, a function that joins two Strings together, and a `let in` statement, which lets us declare a variable and use it in our function. We're declaring the `url` variable and using it in the `in` section.

`Http` is a module that makes requests to web servers. We need to import it into our code.

{% highlight haskell %}
import Http
{% endhighlight %}

[`Http.send`](http://package.elm-lang.org/packages/elm-lang/http/1.0.0/Http#send) is a function that takes a Message to run when it's done as its first input and an Http Request as its second input.

We also need to add this new Message type.

{% highlight haskell %}
type Message
    = AskedForNewPic
    | SearchTextChanged String
    | NewGifReceived (Result Http.Error String)
{% endhighlight %}

In this case, `NewGifReceived` is *parameterized* with a Result, which can either fail (in which case we get an Http.Error type), or succeed, in which case we get a String that contains the GIF URL.

We also need to handle the new Message in the `update` function.

{% highlight haskell %}
update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        SearchTextChanged newText ->
            ( { model | searchText = newText }, Cmd.none )

        AskedForNewPic ->
            if String.length model.searchText < 1 then
                ( model, getRandomGif model.topic )
            else
                ( { model
                    | searchText = ""
                    , topic = model.searchText
                  }
                , getRandomGif model.searchText
                )

        NewGifReceived (Ok newImageUrl) ->
            ( Model model.topic newImageUrl "", Cmd.none )

        NewGifReceived (Err _ ) ->
            ( model, Cmd.none )
{% endhighlight %}

We also added a user experience fix to reset the search bar whenever a search is made.

Here's the final code:

{% highlight haskell %}
module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Decode


main =
    Html.program
        { init = searchFor "cats"
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


type alias Model =
    { topic : String
    , gifUrl : String
    , searchText : String
    }


init : String -> ( Model, Cmd Message )
init = ( Model "" "" "", getRandomGif topic )


type Message
    = AskedForNewPic
    | SearchTextChanged String
    | NewGifReceived (Result Http.Error String)


update : Message -> Model -> ( Model, Cmd Message )
update message model =
    case message of
        SearchTextChanged newText ->
            ( { model | searchText = newText }, Cmd.none )

        AskedForNewPic ->
            if String.length model.searchText < 1 then
                ( model, getRandomGif model.topic )
            else
                ( { model
                    | searchText = ""
                    , topic = model.searchText
                  }
                , getRandomGif model.searchText
                )

        NewGifReceived (Ok newImageUrl) ->
            ( Model model.topic newImageUrl "", Cmd.none )

        NewGifReceived (Err _ ) ->
            ( model, Cmd.none )


view : Model -> Html Message
view model =
    div [ pageStyle ]
        [ h2 [ titleStyle ]
            [ text model.topic ]
        , input
            [ inputStyle
            , value model.searchText
            , onInput SearchTextChanged
            , placeholder "search"
            ]
            []
        , br [] []
        , br [] []
        , button [ buttonStyle, onClick AskedForNewPic ]
            [ text "more please!" ]
        , br [] []
        , br [] []
        , img [ imgStyle, src model.gifUrl ] []
        ]


subscriptions : Model -> Sub Message
subscriptions model =
    Sub.none


getRandomGif : String -> Cmd Message
getRandomGif topic =
    let
        url =
            "https://api.giphy.com/v1/gifs/random?api_key=dc6zaTOxFJmzC&tag="
                ++ topic
    in
        Http.send NewGifReceived (Http.get url decodeGifUrl)


decodeGifUrl : Decode.Decoder String
decodeGifUrl =
    Decode.at [ "data", "image_url" ] Decode.string



-- Styles


pageStyle =
    style [ ( "text-align", "center" ) ]


inputStyle =
    style
        [ ( "padding-top", "16px" )
        , ( "padding-bottom", "6px" )
        , ( "width", "188px" )
        , ( "outline", "none" )
        , ( "color", "#000" )
        , ( "font-size", "16px" )
        , ( "font-weight", "400" )
        , ( "border", "none" )
        , ( "border-bottom", "2px solid #99ddff" )
        ]


titleStyle =
    style [ ( "font-size", "2em" ), ( "color", "#333" ) ]


buttonStyle =
    style
        [ ( "padding", "10px" )
        , ( "background-color", "#99ddff" )
        , ( "border-radius", "2px" )
        , ( "border", "1px solid #99ddff" )
        , ( "color", "white" )
        , ( "font-size", "1.5em" )
        , ( "cursor", "pointer" )
        ]


imgStyle =
    style
        [ ( "border-radius", "2px" )
        , ( "box-shadow"
          , "0 2px 4px rgba(0,0,0,0.12), 0 2px 3px rgba(0,0,0,0.24)"
          )
        ]
{% endhighlight %}
