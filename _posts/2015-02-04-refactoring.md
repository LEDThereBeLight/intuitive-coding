---
layout: post
title: "Making Giffetch"
subtitle: "Starting to build our program"
section: app-building
---

### Refactoring our code

In coding, just like in writing, we usually get our thoughts out onto the page and get the program to work the way we want it to, then proofread our statements and clean our code so that it's easier to read and work with. **Factoring** means to separate something into pieces (remember factoring in math class?), and the process of cleaning up our code by splitting it into different pieces is called **refactoring**.

There are three main things we look for when proofreading, roughly in order of importance:
  1. Hard to read code, like unhelpful variable names. We should be able to read our code without having to constantly look up the definitions of functions
  2. Repetition. Finding repetition usually means we can replace it with a function
  3. Horribly inefficient code, though this takes some practice to be able to spot and usually isn't very important.
  
Honestly, some repetition isn't that big of a deal. It's not really something to stress out over. The most important thing is to make our code *readable*, so that whoever is coming along after us can easily understand what's going and make changes without breaking everything. If some code is repeated, but it's still easy to understand, it's not terribly difficult to just CTRL-F and change the code in each place.

Let's do a few things to make our program a little easier to read. Right now, all of the code sits inside the `main` function. This makes it simpler, but the length of our `main` function with all of the styling for every element makes it a little difficult to see at a glance what we're trying to do with our program.

### Replacing styles with functions

One thing we can do to improve our program is factor out the style attributes into their own functions. Remember that words can be replaced by their definitions. So instead of putting all of the styling in main, we can replace them with functions with definitions equal to our original in-line styling.

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

You might have noticed we repeated the code for the button styling three times. Whenever we see a code pattern repeated multiple times, we should think about making it into a function. We usually want to eliminate as much code as we can while still staying readable, since unwritten code can never break. 

We can actually use the same process of pulling out the styling for each element on the page into its own function and get rid of the button styling repetition at the same time.

Let's make new functions for `headingStyling`, `buttonStyling`, and `imageStyling`.
{: .info}

{% highlight haskell %}
headingStyling =
  Html.Attributes.style
    [
      ("font-size", "2em"), ("color", "#333")
    ]

<!-- searchboxStyling =
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
    ] -->

buttonStyling =
  Html.Attributes.style
    [
      ("padding", "10px"),
      ("background-color", "#99ddff"),
      ("border-radius", "2px"),
      ("border", "1px solid #99ddff"),
      ("color", "white"),
      ("font-size", "1.5em"),
      ("cursor", "pointer"),
      ("margin", "5px")
    ]

imageStyling =
  Html.Attributes.style
    [
      ("border-radius", "2px"),
      ("box-shadow", "0 2px 4px rgba(0,0,0,0.12), 0 2px 3px rgba(0,0,0,0.24)")
    ]
{% endhighlight %}

Now we can use these new functions we just wrote to replace the styling in our `main` function. I'm also going play with the spacing in the code a bit for readability.

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
    Html.button [ buttonStyling ] [ Html.text "cats" ],
    Html.button [ buttonStyling ] [ Html.text "dogs" ],
    Html.button [ buttonStyling ] [ Html.text "ice cream" ],
    Html.br [] [],
    Html.br [] [],
    Html.img [ imageStyling, Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif" ] []
  ]

*(style definitions)*
{% endhighlight %}

Much cleaner! Now we can just read the code and understand what's happening without having to worry about the details about how every individual element on the page is styled.
