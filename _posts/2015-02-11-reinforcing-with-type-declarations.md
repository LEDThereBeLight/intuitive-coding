---
layout: post
title: "Let the Types Flow"
subtitle: "Thinking in Types"
section: app-building
comments: true
---

### Why types are a good thing

In coding, it's important to have a good understanding of the types of values that are flowing through the program. Functions only ever work on specific types, so if you lose track of the types of inputs that you're giving to functions you'll run into errors. Elm is pretty good about telling you if you're doing something that doesn't make sense, like using an Integer function on a String. Other languages, like Javascript, are more than happy to do whatever you tell it to, happily giving you back meaningless results without a word of warning.

Elm is a **typed** language. That means it will tell us when we use a function that only works on one type of value on an input of the wrong type. **Untyped** languages don't have this restriction. The result in untyped languages is usually that you code something that you think makes sense, only to find a bug in your program that takes hours to track down and fix.

Let's take advantage of Elm's helpful **type declarations** to develop an intuition for how types of values flow through our programs. Learning how to visualize types will help dramatically when you go to untyped languages like Javascript that don't enforce type restrictions. They allow us to visualize functions as *pipes* between inputs and outputs.

### Type declarations

Let's see what type declarations look like with an example. Say we wanted to make a function that added two numbers.

{% highlight haskell %}
add first second = first + second
{% endhighlight %}

In Elm, `+` only works on numbers - that is, an Int type (whole number) or a Float type (decimal). If we wanted to restrict our function to only work on whole numbers, we could do this:

{% highlight haskell %}
add : Int -> Int -> Int
add first second = first + second
{% endhighlight %}

The first line is a type declaration. Type declarations are a way of telling the Elm compiler what types the functions we're creating are expecting to take in and return. Here's what the type declaration says in English:

`add` is a function that takes two Ints as inputs and gives back an Int as output.
{: .quote}

The `:` symbol is usually read as "has type", and doesn't actually change the function of our code. It's used to tell the compiler (and human readers) how the function is expected to be used. If we use the function in a way that violates the type declaration, Elm will throw an error and tell us we're doing something weird.

In our `add` function, we take in a two numbers, and give back a third number. The skinny arrow symbol (`->`) is used to show the flow of values through the function.

So why are the inputs not separated from the output?

Remember that in Elm, every variable is a function, and every variable's value has a type. We haven't talked about this yet, but technically, every function is only able to accept either *zero* or *one* input. In practice, it looks like our `add` function takes two inputs, but under the hood, what's happening is that it's taking in inputs one by one and returning a new function that accepts the next input.

Our `add` function is really a chain of functions. It's a function that accepts an Int input, and returns a new function of type `Int -> Int`.

This process of only allowing one input to be processed at a time is extremely powerful, and something a lot of mainstream languages miss out on. The actual word for it is called *currying*, because we're mixing in "ingredients" one at a time to create something more complex.

![currying](https://img.vimbly.com/images/full_photos/indian-cooking-6.jpg)

### Currying

Currying, or **partial application** as it's more formally known, is a powerful functional programming concept that allows us to save programming time by reusing code. Let's see how our `add` function would work by walking through each of the currying steps.

{% highlight haskell %}
add one two = one + two

-- We can make a function that always adds 2 like this:
addTwo = add 2

addTwo 7  -- produces 9
addTwo 15 -- produces 17

-- So when we call `add` like this...
-- add 1 2
-- What we're really doing is this:

add : Int -> Int -> Int
add 1 2
-- we produce a temporary function with the 1 applied
addOne : Int -> Int

-- Then we call our temporary function with the second input
addOne 2 -- produces our final value, an Int of 3
{% endhighlight %}

Let's see one more example.

{% highlight haskell %}
multiply x y = x * y

-- multiply 3 7 is the same as...

multiplyByThree = multiply 3

multiplyByThree 7 -- produces 21
{% endhighlight %}

In each of these cases, we're supplying a single input to a function and receiving back another function that takes a second input.

### Type variables

When we created our `add` function, we said that it could only work on Int values.

{% highlight haskell %}
add : Int -> Int -> Int
add one two = one + two
{% endhighlight %}

We also want our function to work on decimals, not just whole numbers. So how can we say that we want it to work on *two* different types?

The answer is to use a **type variable** in our type declaration. Just like normal variables can have multiple values, type variables can be used to represent multiple types. Type variables are lower-cased like normal variables. Elm has a few type variables built-in:

  * number
    * for Int and Float
  * comparable
    * for Int, Float, Char, String, List, and Tuple
  * appendable
    * for String and List

Here's what using one of these type variables for our `add` function would look like.

{% highlight haskell %}
add : number -> number -> number
add one two = one + two
{% endhighlight %}

Now we won't get an error when we use our function with decimals.

### Adding type declarations for our program

Let's add a type declaration for our `update` function. Remember that `update` is a function that takes a Message and a Model, and gives back a new Model.

{% highlight haskell %}
update : Message -> Model -> Model
update message model =
  case message of
    AskedForCats     -> { title = "cats",
                          picture = catPicture }

    AskedForDogs     -> { title = "dogs",
                          picture = dogPicture }

    AskedForIceCream -> { title = "ice cream",
                          picture = iceCreamPicture }
{% endhighlight %}

### More type declarations

Let's go through and add type declarations to some of the other functions in our program. Adding type declarations is always optional, but it's usually a good idea because it acts as good documentation (showing how a function should be used) and makes it more difficult to misuse a function.

We already know the type declaration for the `update` function:

{% highlight haskell %}
update : Message -> Model -> Model
{% endhighlight %}

But if you run this, it won't work. That's because Model isn't a default type that is built into Elm. We created a Message type when we wrote this line:

{% highlight haskell %}
type Message = AskedForCats | AskedForDogs | AskedForIceCream
{% endhighlight %}

So now we just have to do something similar for the Model.

{% highlight haskell %}
model = { title = "cats",
          picture = "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif" }
{% endhighlight %}

There's just a slight difference here. Our `model` isn't really a *new* type, it's just a specific type of Record - one with a "title" and a "picture" field. So what we're actually going to do is make a nickname for that specific type of record so that we can refer to it as a Model type from now on.

### Type aliases

We make nicknames for types like this:

{% highlight haskell %}
type alias Model = { title : String, picture : String }
{% endhighlight %}

"Alias" is just another word for nickname. This line, then, is saying,

Model is a nickname for a Record with two fields: "title", which has type String, and "picture", which also has type String.
{: .quote}

Now we can use our new Model "type alias" in our code to refer to that specific form of record.

{% highlight haskell %}
type alias Model = { title : String, picture : String }
model : Model
model = { title = "cats",
          picture = "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif" }
{% endhighlight %}

But there's one more thing we can do to make our code a little more idiomatic and similar to how you'll see most other Elm code out there. Whenever we create a type alias, Elm makes a new type constructor for us for free. Remember that type constructors are used to create values of a specific type, and this type needs a "title" and a "picture". So we can use our new type constructor to create a model like this:

{% highlight haskell %}
-- make the Model type constructor
type alias Model = { title : String, picture : String }

-- now we can use Model in our type declaration
model : Model
-- ...and also in our code to make new Models
model = Model "cats" "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif"
-- the last line creates a variable of type Model with the title and picture fields set
{% endhighlight %}

### Type parameters

Just like normal functions can accept inputs (also called arguments or parameters), types can accept inputs as well. The formal word for this is called **parameterized types**. It's an intimidating term, but a parameterized type is just a type that can have another type inside of it. Lists are parameterized types, because they can hold other types inside of them. So when we write type declarations for Lists, it usually looks something like this:

{% highlight haskell %}
-- function for the length of a list
length : List things -> Int

List.length [1, 2, 3]  -- produces 3
List.length ['a', 'b'] -- produces 2
{% endhighlight %}

What we're saying is that the length function takes a List of *things*, whether they're Ints, or Strings, or whatever. In this case, the word `things` is a **type variable** because it's a lowercased, generic word for multiple types. We can use this function no matter what type the elements of our List are.

`things` is also a type parameter, because it's used as an input to the List type in our type declaration.

We need to use type parameters when we write the type declaration for our `view` function.

### Type declaration for the view

Let's add a type declaration for our `view` function.

{% highlight haskell %}
view : Model -> Html Message
view model = div
  [ pageStyling ]
  [
    h1 [ headingStyling ] [ text model.title ],
    br [] [],
    br [] [],
    button [ buttonStyling, onClick AskedForCats ] [ text "cats" ],
    button [ buttonStyling, onClick AskedForDogs ] [ text "dogs" ],
    button [ buttonStyling, onClick AskedForIceCream ] [ text "ice cream" ],
    br [] [],
    br [] [],
    img [ imageStyling, src model.picture ] []
  ]
{% endhighlight %}

`view` is a function that takes a Model and gives back an Html value that is capable of producing Messages. Message is a type parameter for the Html type. It essentially tells us that Html and Message are linked. If we named our Message type something else, we would use that name instead of Message. We could also use a generic type variable to show this.

{% highlight haskell %}
-- These are all essentially equivalent:
view : Model -> Html Message -- Html produces ONLY our specific Message type we created
view : Model -> Html message -- Html can produce messages of any type
view : Model -> Html a       -- type variables can be named anything
{% endhighlight %}

That should be about good for type declarations. We can add declarations for the functions that don't accept any inputs, but I'm not sure it would do much good.

Since we went through a lot of examples and it was probably hard to tell what code you needed to write and what you didn't, here's the final code for our program so far.

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

type alias Model = { title : String, picture : String }
model : Model
model = Model "cats" "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif"

view : Model -> Html Message
view model = div
  [ pageStyling ]
  [
    h1 [ headingStyling ] [ text model.title ],
    br [] [],
    br [] [],
    button [ buttonStyling, onClick AskedForCats ] [ text "cats" ],
    button [ buttonStyling, onClick AskedForDogs ] [ text "dogs" ],
    button [ buttonStyling, onClick AskedForIceCream ] [ text "ice cream" ],
    br [] [],
    br [] [],
    img [ imageStyling, src model.picture ] []
  ]

update : Message -> Model -> Model
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
    style [
            ( "font-size", "2em" ),
            ( "color", "#333" )
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

Don't sweat the formatting - again, there are plugins for doing it for you.
