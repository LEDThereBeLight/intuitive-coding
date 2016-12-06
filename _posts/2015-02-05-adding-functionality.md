---
layout: post
title: "functionality"
subtitle: "Starting to build our program"
section: app-building
---

### Keeping track of things with *state*

So now we have a working web page with a few buttons and an image. But it doesn't *do* anything. So how do we add functionality to the page?

The main gap in our knowledge right now is that we don't know how to make a program with **state**. State is the current situation of our program. Think about water. Depending on the temperature, water can have different states of solid, liquid, and gas. But in our program, we just run our code and get a single result, which Elm spits out on the page. Nothing can change based on different conditions.

If we want to make something interactive, we're going to need to be able to react to changes. Think about all the things Facebook has to keep track of to know what to show on the page. It has to know whether the current user is logged in or not, the user's friends, posts that were made recently, and so on.

First, a quick note: things are about to ramp up pretty quickly here. We're going to introduce some programming concepts that are core to just about every app but take a little time to get comfortable with. Don't be frustrated if it doesn't make sense right away - it sure didn't for me. But it will come.

### The state is stored in the *model*

The **model** represents the current state of the program, and the shape of the model is different for every program. Login forms need a model that keeps track of what someone types into the username and password fields. Gmail has a model that keeps track of new and unread emails. Games have a model that keeps track of the level you're on, your current hitpoints, and so on.

![shaping the model](https://media.giphy.com/media/TTRmmgPTOBgJ2/giphy.gif)
*shaping the model*

### Our program's model

Before we can add functionality to our page, we need to create a model that will keep track of the things that will change. 



![model](images/app-mvu.png)

Remember types? They're categories for values. We've already learned about the Character, List, and String types. These types are built into Elm. But types aren't special - we can make our own if we want. 















Let's create a new function called `pageStyling`, and define it to be equal to the HTML style attributes we used in our `div` container.
{: .info}

{% highlight haskell %}
pageStyling = Html.Attributes.style [ ("text-align", "center") ]
{% endhighlight %}

Now we can use our new function to replace the style attributes we used as the first input to our `Html.div` function.

{% highlight haskell %}
Html.div
  [ pageStyling ]
  *(page elements)*
{% endhighlight %}

### Repeating the process

We can repeat this process for the rest of our page elements.

Let's make new functions for `headingStyling`, `searchboxStyling`, `buttonStyling`, and `imageStyling`
{: .info}

{% highlight haskell %}
headingStyling =
  Html.Attributes.style
    [
      ("font-size", "2em"), ("color", "#333")
    ]

searchboxStyling =
  Html.Attributes.style
    [
      ("padding-top", "16px"),
      ("padding-bottom", "6px"),
      ("width", "188px"),
      ("outline", "none"),
      ("color", "#000"),
      ("font-size", "16px"),
      ("font-weight", "400"),
      ("border", "none"),
      ("border-bottom", "2px solid #99ddff")
    ]

buttonStyling =
  Html.Attributes.style
    [
      ("padding", "10px"),
      ("background-color", "#99ddff"),
      ("border-radius", "2px"),
      ("border", "1px solid #99ddff"),
      ("color", "white"),
      ("font-size", "1.5em"),
      ("cursor", "pointer")
    ]

imageStyling =
  Html.Attributes.style
    [
      ("border-radius", "2px"),
      ("box-shadow", "0 2px 4px rgba(0,0,0,0.12), 0 2px 3px rgba(0,0,0,0.24)")
    ]
{% endhighlight %}

Now we can use these new functions to replace the styling in our `main` function. I'm also going to change the formatting a bit for readability.

{% highlight haskell %}
import Html
import Html.Attributes

main = Html.div
  [ pageStyling ]
  [
    Html.h1 [ headingStyling ] [ Html.text "cats" ],
    Html.input [ searchboxStyling ] [],
    Html.br [] [],
    Html.br [] [],
    Html.button [ buttonStyling ] [ Html.text "more!" ],
    Html.br [] [],
    Html.br [] [],
    Html.img [ imageStyling, Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif" ] []
  ]

*(style definitions)*
{% endhighlight %}

Much cleaner! Now we can just read the code and understand what's happening without having to worry about the details about how every individual element on the page is styled.
