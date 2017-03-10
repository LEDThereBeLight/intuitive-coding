---
layout: post
title: "Refactoring Round Two"
subtitle: "...and a bunch of new ideas"
section: app-building
comments: true
---

### Keeping track of things with *state*

Our simple program works great, but there are some things we can clean up and in the process teach ourselves some things we're going to need to know. Let's go top to bottom and refactor. We'll start with the model.

### Refactoring the model

{% highlight haskell %}
model = ("cats", "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif")
{% endhighlight %}

Our model is extremely simple, just a Tuple of two Strings. We have to use `Tuple.first` and `Tuple.second` to access each part, which isn't very descriptive or easy to read. It's also not very flexible - the Tuple module doesn't have a `third` function, so we wouldn't have a good way to access any additional parts if we wanted to expand our model.

We're going to convert it into a Record, which is the goto data structure for containing multiple pieces that have specific, labeled parts.

So first, what's a data structure?

A **data structure** is just a way of organizing data in a computer. An Integer is not a data structure, because it just holds a single value. A List *is* a data structure, one that lets us group multiple elements of the same type. A Tuple is a data structure which lets us group elements of different types. And stepping up the complexity a bit, we come to a Record.

A **Record** is a data structure that allows us to group elements of different types as a series of pairs (names and values). You can think of it like a row in a table.

![excel table](http://content.gcflearnfree.org/topics/236/table_record_new_bottom.png)

Each row in the table can be viewed as a Record, which is essentially just a bunch of cells with a name (the column header) and a value (the text in the cell).

Let's convert our model from a Tuple into a Record. Just like Lists use square brackets `[ ]` and Tuples use parentheses `( )`, Records have their own symbol: curly braces `{ }`. Inside the curly braces, we list out the pairs of names and values separated by `=` signs.

Let's change our model into a Record:

{% highlight haskell %}
model = { title = "cats",
          picture = "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif" }
{% endhighlight %}

Now we can access each element of the record by its name instead of a nameless Tuple function. Let's update the sections of the view that referenced our old Tuple model and replace it with our new and improved Record model.

Remember the `.` symbol that we use with modules and functions? It means "look inside". Well, with records, we want to *look inside* the record for a specific name, and pull out that value. So we can write,

{% highlight haskell %}
view model = Html.div
  [ pageStyling ]
  [
    Html.h1 [ headingStyling ] [ Html.text model.title ],
    {- ...rest of Html functions... -}
    Html.img [ imageStyling, Html.Attributes.src model.picture ] []
  ]
{% endhighlight %}

Easier to read, right? Now we don't have to look up how the model is defined every time we want to see what we're showing - we can just read `model.title` and know we're accessing the title part of the model.

If you run the code, it won't compile yet. We need to change every part of our program that referenced the old model, which includes the update function.

{% highlight haskell %}
update message model =
       if message == "asked for cats" then      { title = "cats",
            picture = "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif" }
  else if message == "asked for dogs" then      { title = "dogs",
            picture = "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif" }
  else if message == "asked for ice cream" then { title = "ice cream",
            picture = "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif" }
  else model
{% endhighlight %}

### Pulling the images into functions

It's kind of a pain to see the image location URL everywhere we use the model. If we wanted to use a different image instead, we'd have to update the URL everywhere. Let's make functions for each of the image locations to make our code a little cleaner.

{% highlight haskell %}
catPicture = "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif"
dogPicture = "https://media.giphy.com/media/oJWx7MtpR2qdi/giphy.gif"
iceCreamPicture = "https://media.giphy.com/media/QjagU0ONoQwCc/giphy.gif"
{% endhighlight %}

Go ahead and replace the URLs with the new functions in our code.

{% highlight haskell %}
update message model =
       if message == "asked for cats" then      { title = "cats",
            picture = catPicture }
  else if message == "asked for dogs" then      { title = "dogs",
            picture = dogPicture }
  else if message == "asked for ice cream" then { title = "ice cream",
            picture = iceCreamPicture }
  else model
{% endhighlight %}

### Case statements

Our update function works, but it's a little crude. We can do two things to clean it up. The first is by using a **case statement** instead of multiple "if statements."

Case statements look something like this:

{% highlight haskell %}
case {- expression -} of
  firstPattern  -> firstOutput
  secondPattern -> secondOutput
  thirdPattern  -> thirdOutput
{% endhighlight %}

Replacing the "if statements" with "case statements" in our update function will look like this:

{% highlight haskell %}
update message model =
  case message of
    "asked for cats"      -> { title = "cats",
                               picture = catPicture }

    "asked for dogs"      -> { title = "dogs",
                               picture = dogPicture }

    "asked for ice cream" -> { title = "ice cream",
                               picture = iceCreamPicture }

    _                     -> model
{% endhighlight %}

A case statement is Elm's way of **pattern matching**, which is a way to write programs that react to inputs based on what they "look like." Every type of value has its own pattern which can be matched. Note that we use a skinny arrow `->`, not an `=` sign, to say what the function's output should be if the `message` matches the pattern on the left.

Go ahead and refresh the page. What happens?

![case statement missing patterns](/images/case-branches-error.png/)

Using a case statement instead of if statements isn't just for aesthetics. It takes advantage of Elm's modern features to make our code more reliable. Whenever Elm sees a case statement, it makes sure we account for every possible "pattern". That is, we can't forget to write code for a pattern that our code is capable of producing, because Elm will tell us we're forgetting something when we try to compile.

Case statements pattern match based on types of values. Even though we only *use* three different message Strings in our program, the type of our message is a String, which could potentially be any sequence of letters. So we have to guard against accidentally adding another message later on and forgetting to handle it in the update function.

We can fix our code with one more line.

{% highlight haskell %}
update message model =
  case message of
    "asked for cats"      -> { title = "cats",
                               picture = catPicture }

    "asked for dogs"      -> { title = "dogs",
                               picture = dogPicture }

    "asked for ice cream" -> { title = "ice cream",
                               picture = iceCreamPicture }

    _                     -> model
{% endhighlight %}

The `_` is a wildcard in Elm. This line is basically saying, "if you see a message of any pattern besides the ones I mentioned above, just give back the old model." It doesn't match *an absence* of a message, it matches *any* message. Note that adding this line really just hides the issue - we could still add more types of messages and forget to handle them in the update function since we now have a "catchall" that matches any pattern. We'll fix that issue soon.

### Creating new types

Right now, we're simply using Strings for our messages. This works fine, and makes intuitive sense (messages are words), but there's a better alternative.

Remember how the Bool type has two options, True and False? Here's the definition of Bool. We'll explain what each part means.

{% highlight haskell %}
type Bool = True | False
{% endhighlight %}

The `type` at the beginning tells Elm that we're defining a new type, not just a normal function. The name of our new type goes next: `Bool`. Types are always capitalized to make them distinct from variable names. What we're saying here is that Bool can be one of two things, `True` or `False`. True and False are called **value constructors**, because we can use them to build Bool values. It takes some time to come to terms with the idea, but there's nothing weird going on here - constructors are values just like any other variable or function is, and they can be passed into functions as inputs.

That `|` symbol is literally just a separator between the two constructors. It's read as "or", so the entire statement can be read out loud as,

Bool is a type that can have the values of either True or False.
{: .quote}

We create types for values that don't fit nicely into Elm's predefined types. Here, we only have three different messages in our program, so it's a perfect place for a new type. Let's define a new type called Message as follows:

{% highlight haskell %}
type Message = AskedForCats | AskedForDogs | AskedForIceCream
{% endhighlight %}

This is saying,

The Message type can have one of three values: AskedForCats, AskedForDogs, or AskedForIceCream.
{: .quote}

Now that we've changed our messages, we need to update all of the code that reference them: the `update` and `view` functions.

Here's the new `update`:

{% highlight haskell %}
update message model =
  case message of
    AskedForCats     -> { title = "cats",
                          picture = catPicture }

    AskedForDogs     -> { title = "dogs",
                          picture = dogPicture }

    AskedForIceCream -> { title = "ice cream",
                          picture = iceCreamPicture }
{% endhighlight %}

We can get rid of the `_ -> model` line at the end because the message can *never* be anything but one of the three values we created when we built the Message type - there's nothing to guard against anymore.

The `view` also needs updated to use our new messages:

{% highlight haskell %}
view model = Html.div
  [ pageStyling ]
  [
    Html.h1 [ headingStyling ] [ Html.text model.title ],
    Html.button [ buttonStyling, Html.Events.onClick AskedForCats ] [ Html.text "cats" ],
    Html.button [ buttonStyling, Html.Events.onClick AskedForDogs ] [ Html.text "dogs" ],
    Html.button [ buttonStyling, Html.Events.onClick AskedForIceCream ] [ Html.text "ice cream" ],
    Html.br [] [],
    Html.br [] [],
    Html.img [ imageStyling, Html.Attributes.src model.picture ] []
  ]
{% endhighlight %}

Compile the code and it should run.

### Record update

Our code is looking a lot better, but the `update` function is still bothering me.

{% highlight haskell %}
update message model =
  case message of
    AskedForCats     -> { title = "cats",
                          picture = catsPicture }

    AskedForDogs     -> { title = "dogs",
                          picture = dogsPicture }

    AskedForIceCream -> { title = "ice cream",
                          picture = iceCreamPicture }
{% endhighlight %}

See how in the output of each pattern it looks like we're creating a brand new Record? We're essentially just wanting to give back an updated model, but we're not referencing the old model at all. Even though Elm never changes existing values, it would look clearer to people reading our code if we mentioned the fact that we're essentially just trying to update the existing model with new values.

We can accomplish this with **record updates**. Record updates uses the `.` symbol to look inside the original Record and "update" it. Remember that nothing really ever gets overwritten, so when we say "update" we really mean creating a new record where the parts that are the same as before are reused.

{% highlight haskell %}
update message model =
  case message of
    AskedForCats     -> { model | title = "cats",
                                  picture = catsPicture }

    AskedForDogs     -> { model | title = "dogs",
                                  picture = dogsPicture }

    AskedForIceCream -> { model | title = "ice cream",
                                  picture = iceCreamPicture }
{% endhighlight %}

Great! Things are really starting to look better. Note that we have to mention the `model` again on the right side of the `|` sign (pronounced "where").

Here's how we would read one of these lines aloud:

When the message matches AskedForIceCream, return an updated model where the title is "ice cream" and the picture is iceCreamPicture.
{: .quote}

### Exposing

Right now, everytime we call a function, we're labeling it at the beginning with the name of the module it comes from. That's all well and good - it makes it clear exactly where the function we're using is coming from - but as we get more comfortable with what functions are from each module, it can look a little wordy.

We can fix that by **exposing** modules' functions in our code.

For example, we can change this:

{% highlight haskell %}
view model = Html.div
  [ pageStyling ]
  [
    Html.h1 [ headingStyling ] [ Html.text "cats" ],
    Html.button [ buttonStyling, Html.Events.onClick AskedForCats ] [ Html.text "cats" ],
    Html.button [ buttonStyling, Html.Events.onClick AskedForDogs ] [ Html.text "dogs" ],
    Html.button [ buttonStyling, Html.Events.onClick AskedForIceCream ] [ Html.text "ice cream" ],
    Html.img [ imageStyling, Html.Attributes.src model.picture ] []
  ]
{% endhighlight %}

...into this:

{% highlight haskell %}
view model = div
  [ pageStyling ]
  [
    h1 [ headingStyling ] [ text "cats" ],
    button [ buttonStyling, onClick AskedForCats ] [ text "cats" ],
    button [ buttonStyling, onClick AskedForDogs ] [ text "dogs" ],
    button [ buttonStyling, onClick AskedForIceCream ] [ text "ice cream" ],
    img [ imageStyling, src model.picture ] []
  ]
{% endhighlight %}

To let us use of functions without writing out the module name first, we need to update the import lines at the top of our code to "expose" certain functions. Here's what we've got right now:

{% highlight haskell %}
import Html
import Html.Attributes
import Html.Events
{% endhighlight %}

We can either import every function that we use individually, like this:

{% highlight haskell %}
import Html exposing (text, div, h1, br, button, img)
import Html.Attributes exposing (src)
import Html.Events exposing (onClick)
{% endhighlight %}

Or if we're lazy, we can just expose *everything* inside the module.

{% highlight haskell %}
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
{% endhighlight %}

The `(..)` looks a little weird the first time you see it. It's basically just supposed to represent an ellipsis in parentheses (...). The reason there are two dots is that typically, in programming languages, `...` is used to mean "up to but not including", meaning the last element is excluded. `..` includes everything, including the last element. So basically it's just saying, "expose everything in the module." This will give us access to every function defined in the module (lower cased words), and every type defined in the module (uppercase words).

One more point. In larger applications, exposing everything usually isn't a good idea because you can run into naming conflicts - what happens if two functions from different modules have the same name? But with small programs like this, it's usually easier to just expose everything and not have to worry about updating your `import` statements every time you use a new function.

Here's the final code we end up with.

{% highlight haskell %}
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)

main = Html.beginnerProgram { model = model,
                              view = view,
                              update = update }

type Message = AskedForCats | AskedForDogs | AskedForIceCream

catPicture = "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif"
dogPicture = "https://media.giphy.com/media/oJWx7MtpR2qdi/giphy.gif"
iceCreamPicture = "https://media.giphy.com/media/QjagU0ONoQwCc/giphy.gif"

model = { title = "cats",
          picture = "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif" }

view model = div
  [ pageStyling ]
  [
    h1 [ headingStyling ] [ text model.title ],
    button [ buttonStyling, onClick AskedForCats ] [ text "cats" ],
    button [ buttonStyling, onClick AskedForDogs ] [ text "dogs" ],
    button [ buttonStyling, onClick AskedForIceCream ] [ text "ice cream" ],
    br [] [],
    br [] [],
    img [ imageStyling, src model.picture ] []
  ]

update message model =
  case message of
    AskedForCats     -> { title = "cats",
                          picture = catPicture }

    AskedForDogs     -> { title = "dogs",
                          picture = dogPicture }

    AskedForIceCream -> { title = "ice cream",
                          picture = iceCreamPicture }

pageStyling =
    style [ ( "text-align", "center" ) ]

headingStyling =
    style
    [
      ( "font-size", "2em" ),
      ( "color", "#333" ),
      ("padding-bottom", "30px")
    ]

buttonStyling =
    style
      [
        ( "padding", "10px" ),
        ( "background-color", "#99ddff" ),
        ( "border-radius", "2px" ),
        ( "border", "1px solid #99ddff" ),
        ( "color", "white" ),
        ( "font-size", "1.5em" ),
        ( "cursor", "pointer" ),
        ( "margin", "5px")
      ]

imageStyling =
    style
      [
        ( "border-radius", "2px" ),
        ( "box-shadow", "0 2px 4px rgba(0,0,0,0.12), 0 2px 3px rgba(0,0,0,0.24)")
      ]
{% endhighlight %}

You can commit your changes.

{% highlight shell %}
$ git add -A
$ git commit -m "Refactor model into record, change update to use case statement, create new Message type, and expose imported modules"
{% endhighlight %}
