---
layout: post
title: "Hooking Up Our Program"
subtitle: "The sum is greater than the parts"
section: app-building
comments: true
---

### Bringing our view to life

In the last section, we talked about the update and how it accepts this vague idea of a *message* to know what to change in the model. But what is a message, and where do they come from?

The secret is that we haven't gotten the whole story about the view. The view isn't simply a static page that takes orders from the model about what to show. The view is what the user interacts with, so it's in a great position to listen for changes. We need to set up the view to actively listen for events that the user triggers on the page.

Here's the code from our view again.

{% highlight haskell %}
view model = Html.div
  [ pageStyling ]
  [
    Html.h1 [ headingStyling ] [ Html.text "cats" ],
    Html.br [] [],
    Html.br [] [],
    Html.button [ buttonStyling ] [ Html.text "cats" ],
    Html.button [ buttonStyling ] [ Html.text "dogs" ],
    Html.button [ buttonStyling ] [ Html.text "ice cream" ],
    Html.br [] [],
    Html.br [] [],
    Html.img [ imageStyling, Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif" ] []
  ]
{% endhighlight %}

To bring our view to life, we need to import another module: `Html.Events`. This module is full of functions that produce "events" when certain things happen, which will feed into our update function once we wire everything together.

First, add an import line near the top of the file (the order of imports doesn't matter):
{% highlight haskell %}
import Html.Events
{% endhighlight %}

One of the functions in the module, called `onClick`, listens for mouse clicks from the user and triggers a message when it detects one. We can attach `onClick` to any Html element. Guess which elements we want to tell to listen for clicks? **The buttons**.

`onClick` takes one input: the message it should send when it's triggered by a mouse click. In our program, our messages are just Strings.

Remember, Html functions take two inputs:

  1. a list of attributes, things that affect the element itself
  2. a list of children elements

Since `onClick` is going to affect the functionality of each button, let's add `Html.Events.onClick` to the List of attributes for each of our buttons in the view and supply the messages we created in the last section as inputs.

{% highlight haskell %}
Html.button [ buttonStyling, Html.Events.onClick "asked for cats" ] [ Html.text "cats" ],
Html.button [ buttonStyling, Html.Events.onClick "asked for dogs" ] [ Html.text "dogs" ],
Html.button [ buttonStyling, Html.Events.onClick "asked for ice cream" ] [ Html.text "ice cream" ],
{% endhighlight %}

Now, whenever we click on a button, the view will send out one of our messages like "asked for dogs".

But if you run the code now, nothing happens. That's because we've been working on individual components but haven't wired everything together yet.

### Putting it all together

So we've explained what the model, view, and update functions are individually. But I'd be shocked if you had any real understanding of what they mean, because they're not really functions that work on their own. The key point to all this is that the model, view, and update form a network that reacts to changes. It's hard to talk about each component separately, because they're all dependent on one another.

To make all our pieces fit together, we need a new function: `Html.beginnerProgram`.

Don't be fooled by the name. This function isn't for beginners, it's just the wiring we start with to hold our app together until we decide we need our program to interact with the outside world. It's plenty capable of fully-featured applications.

`Html.beginnerProgram` takes a view, a model, and an update function, wires them together to create an interactive application, and creates an Html value capable of producing Messages. Here's the flow:



1. A user presses a button that we told to listen for "clicks"
![button](https://media.giphy.com/media/cNPrsXBpZJZx6/giphy.gif)



2. The view sends a message to the update as its first input
![message](https://media.giphy.com/media/PyyTxFoyXpoD6/giphy.gif)



3. The update grabs the model as its second input and runs, creating a new, updated model
![generator](https://media.giphy.com/media/3o6ozvTAmjn8gDzbRC/giphy.gif)



4. The app throws away the old model and keeps the new model
![youths](https://media.giphy.com/media/qG2h9G9NMRRE4/giphy.gif)



5. The model tells the view that it needs to change, and the page redraws only the components that are different
![transform](https://media.giphy.com/media/5yLgocvrcL4Vi9dh5Ac/giphy.gif)

And then we're ready for a new message again.

Let's change our `main` to use `Html.beginnerProgram`.

{% highlight haskell %}
main = Html.beginnerProgram { model = model,
                              view = view,
                              update = update }
{% endhighlight %}

What we're doing here is giving Html.beginnerProgram a Record with three values. We're


Here's our final code.

{% highlight haskell %}
import Html
import Html.Attributes
import Html.Events

main = Html.beginnerProgram { model = model,
                              view = view,
                              update = update }

view model = Html.div
  [ pageStyling ]
  [
    Html.h1 [ headingStyling ] [ Tuple.first model ],
    Html.input [ searchboxStyling ] [],
    Html.br [] [],
    Html.br [] [],
    Html.button [ buttonStyling ] [ Html.text "cats" ],
    Html.button [ buttonStyling ] [ Html.text "dogs" ],
    Html.button [ buttonStyling ] [ Html.text "ice cream" ],
    Html.br [] [],
    Html.br [] [],
    Html.img [ imageStyling, Html.Attributes.src Tuple.second model ] []
  ]
{% endhighlight %}


That's it - try running the code and see how it works.
