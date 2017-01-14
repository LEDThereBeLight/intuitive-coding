---
layout: post
title: "Refactoring Round Two"
subtitle: "...and a bunch of new ideas"
section: app-building
comments: true
---

### Keeping track of things with *state*

Our simple program works great, but there are some things we can clean up and in the process teach ourselves some important ideas. These concepts are critical to any sort of data science, artificial intelligence programs, or problems that you'd be asked to solve in an interview.

Let's go top to bottom and refactor. We'll start with the model.

### Refactoring the model

{% highlight haskell %}
model = ("cats", "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif")
{% endhighlight %}

Our model is extremely simple, just a Tuple of two Strings. We have to use `Tuple.first` and `Tuple.second` to access each part, which isn't very descriptive or easy to read. It's also not very flexible - the Tuple module doesn't have a `third` function, so we wouldn't have a good way to access any additional parts if we wanted to expand our model.

We're going to convert it into a Record, which is the goto data structure for containing multiple pieces that have specific, labeled parts.

So first, what's a data structure?

A **data structure** is just a type that lets us organize data in a computer. An Integer is not a data structure, because it just holds a single value. A List *is* a data structure, one that lets us group multiple elements of the same type. A Tuple is a data structure which lets us group elements of different types. And stepping up the complexity a bit, we come to a Record.

A **Record** is a data structure that allows us to group elements of different types as a series of pairs (names and values). You can think of it like a row in a table.

![excel table](http://content.gcflearnfree.org/topics/236/table_record_new_bottom.png)

Each row is a Record, which is essentially just a bunch of cells with a name (the column header) and a value (the text in the cell).

Let's convert our model from a Tuple into a Record. Just like Lists use square brackets `[ ]` and Tuples use parentheses `( )`, Records have their own symbol: curly braces `{ }`.

Inside the curly braces, we list out the pairs of names and values separated by `=` signs. For example, our model as a Record would look like:

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

We also need to change the update function since that uses the model as well.

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

It's kind of a pain to see the image location URL everywhere we use the model. Let's make functions for each of the image locations to make our code a little cleaner.

{% highlight haskell %}
catPicture = "https://media.giphy.com/media/ND6xkVPaj8tHO/giphy.gif"
dogPicture = "https://media.giphy.com/media/oJWx7MtpR2qdi/giphy.gif"
iceCreamPicture = "https://media.giphy.com/media/QjagU0ONoQwCc/giphy.gif"
{% endhighlight %}

Go ahead and replace the URLs with the new functions in our code.

### Case statements

Here's what our update function looks like currently.

{% highlight haskell %}
update message model =
       if message == "asked for cats"      then { title = "cats",
                                                  picture = catsPicture }
  else if message == "asked for dogs"      then { title = "dogs",
                                                  picture = dogsPicture }
  else if message == "asked for ice cream" then { title = "ice cream",
                                                  picture = iceCreamPicture }
  else model
{% endhighlight %}

It works, but it's a little crude. We can do two things to clean it up. The first is by using a **case statement** instead of multiple "if statements."

Here's the template for a case statement:

{% highlight haskell %}
case {- variable name -} of
  firstPattern  -> firstOutput
  secondPattern -> secondOutput
  thirdPattern  -> thirdOutput
{% endhighlight %}

Replacing the "if statements" with "case statements" in our update function will look like this:

{% highlight haskell %}
update message model =
  case message of
    "asked for cats"      -> { title = "cats",
                               picture = catsPicture }

    "asked for dogs"      -> { title = "dogs",
                               picture = dogsPicture }

    "asked for ice cream" -> { title = "ice cream",
                               picture = iceCreamPicture }

    _                     -> model
{% endhighlight %}

A case statement is Elm's way of **pattern matching**, which is a programming concept that reacts to inputs based on what they look like. We'll have more to say about this soon.

Using a case statement instead of if statements isn't just for aesthetics. It takes advantage of Elm's modern features to make our code more reliable. Whenever Elm sees a case statement, it makes sure we account for every possible "pattern". That is, we can't forget to write code for a pattern that our code is capable of producing, because Elm will tell us we're forgetting something when we try to compile.

Note that we need to use a skinny arrow `->`, not an `=` sign, to say what the function should output if the `message` matches the pattern on the left.

You're probably wondering what this line at the bottom means.
{% highlight haskell %}
_ -> model
{% endhighlight %}


This does the same thing as the line in our "if statement" that said

{% highlight haskell %}
else model
{% endhighlight %}

The `_` is a wildcard in Elm. This line is basically saying, "if you see a message of any pattern besides the ones I mentioned above, just give back the old model." It doesn't match *an absence* of a message, it matches *any* message. Note the difference.

// Would be better to trigger the pattern matching error here rather than have them add the _ line initially and explaining it

Case statements pattern match based on types. Even though we only *use* three different message Strings in our program, the type of our message is still a String, which can be any sequence of letters. So we have to guard against accidentally adding another message later on and forgetting to handle it in the update function.

### Creating new types

Right now, we're simply using Strings for our messages. This works fine, and makes intuitive sense (messages are words), but there's a better alternative.

Remember how the Bool type has two options, True and False? Here's the definition of Bool. We'll explain what each part means.

{% highlight haskell %}
type Bool = True | False
{% endhighlight %}

The `type` at the beginning tells Elm that we're defining a new type, not just a normal function. The name of our new type goes next: `Bool`. Types are always capitalized to make them distinct from variable names. Bool can be one of two things, `True` or `False`. True and False are called **constructors**, because we can use them to build a Bool type. There's nothing weird going on here - constructors are values just like variables are, and they can be passed into functions as inputs.

That `|` symbol is literally just a separator between the two constructors. It's read as "or", so the entire statement can be read out loud as,

Bool is a type that can have the values of either True or False.
{: .quote}

We create types for values that don't fit nicely into Elm's predefined types. For example, we only have three different messages in our program. It doesn't make sense to have to account for how to handle *every* String in existence in every function that uses messages when we know our message can really only have three options.

So let's define a new type called Message as follows:

{% highlight haskell %}
type Message = AskedForCats | AskedForDogs | AskedForIceCream
{% endhighlight %}

This is saying,

The Message type can have one of three values: AskedForCats, AskedForDogs, or AskedForIceCream.
{: .quote}

Now we can replace our String messages in the `update` and `view` functions with our newly created type.

Here's the new `update`:

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

Note that we can get rid of the `_ -> model` line at the end because the message can *never* be anything but one of the three values we created when we built the Message type.

Let's also change the `view` to use our new messages:

{% highlight haskell %}
view model = Html.div
  [ pageStyling ]
  [
    Html.h1 [ headingStyling ] [ Html.text model.title ],
    Html.br [] [],
    Html.br [] [],
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

We can accomplish this with **record update** syntax. It's not *really* updating the record, it's making a new one, but it helps with understanding what we're trying to do. The record update syntax uses the `.` symbol to look inside the original Record and "update" it.

<!-- // Need to talk about how it also makes the code more efficient because it reuses the parts that are the same  -->

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

Great! Things are really starting to look better. Note that we have to mention the `model` again on the right side of the `|` (pronounced "where") sign.

Here's how to read one of these lines aloud:

"When the message matches AskedForIceCream, return an updated model where the title is "ice cream" and the picture is equal to the iceCreamPicture function."

This uses a little more code than what we had before, but it makes our intention clear: that we're essentially wanting to return an updated model. It's also more efficient, because Elm can reuse the parts of the model that we keep the same without having to make an entirely new record from scratch.

<!-- **Alias** is just another word for "nickname". So what we're doing is making a nickname for an existing type, rather than creating a whole new type like we did above. -->

### Exposing

This is an optional change, but it's something that's good to be aware of.

Right now, we're mentioning the module name everywhere we use a function from inside a module. That's all well and good - it makes it clear exactly where a function is coming from - but as we get more comfortable with what functions are from each module, it can look a little wordy.

We can fix that by **exposing** modules' functions in our code.

For example, we can change this:

{% highlight haskell %}
view model = Html.div
  [ pageStyling ]
  [
    Html.h1 [ headingStyling ] [ Html.text "cats" ],
    Html.br [] [],
    Html.br [] [],
    Html.button [ buttonStyling, Html.Events.onClick AskedForCats ] [ Html.text "cats" ],
    Html.button [ buttonStyling, Html.Events.onClick AskedForDogs ] [ Html.text "dogs" ],
    Html.button [ buttonStyling, Html.Events.onClick AskedForIceCream ] [ Html.text "ice cream" ],
    Html.br [] [],
    Html.br [] [],
    Html.img [ imageStyling, Html.Attributes.src model.picture ] []
  ]
{% endhighlight %}

...into this:

{% highlight haskell %}
view model = div
  [ pageStyling ]
  [
    h1 [ headingStyling ] [ text "cats" ],
    input [ searchboxStyling ] [],
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

Does it make the code easier to read? That's up to you. But let's learn how to do it so you can make your own decision.

To allow the use of functions without writing out the module name first, we need to update the import lines at the top of our code to "expose" certain functions. Here's what we've got right now:

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

The `(..)` looks a little weird the first time you see it. It's basically just supposed to represent an ellipsis in parentheses (...). The reason there are two dots is that typically, in programming languages, `...` is used to mean "up to but not including", meaning the last element is excluded. `..` includes everything, including the last element. Elm doesn't have a `...`, but to stick to convention it still uses `..`. So basically it's just saying, "expose everything in the module." This will give us access to every function defined in the module (lower cased words), and every type defined in the module (uppercase words).

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
    br [] [],
    br [] [],
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
    style [ ( "font-size", "2em" ), ( "color", "#333" ) ]


buttonStyling =
    style
        [ ( "padding", "10px" )
        , ( "background-color", "#99ddff" )
        , ( "border-radius", "2px" )
        , ( "border", "1px solid #99ddff" )
        , ( "color", "white" )
        , ( "font-size", "1.5em" )
        , ( "cursor", "pointer" )
        , ( "margin", "5px")
        ]


imageStyling =
    style
        [ ( "border-radius", "2px" )
        , ( "box-shadow"
          , "0 2px 4px rgba(0,0,0,0.12), 0 2px 3px rgba(0,0,0,0.24)"
          )
        ]
{% endhighlight %}

<!-- redefining model using the Model type constructor -->
