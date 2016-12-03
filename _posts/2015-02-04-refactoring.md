---
layout: post
title: "Making Giffetch"
subtitle: "Starting to build our program"
section: app-building
---

### Refactoring our code

In coding, just like in writing, we usually get our thoughts out onto the page and get the program to work the way we want it to, then proofread our statements and clean our code so that it's easier to read and work with. **Factoring** means to separate something into pieces (remember factoring in math class?), and the process of proofreading and cleaning up code into smaller pieces without changing its behavior is called **refactoring**.

Becoming a good editor takes time and experience, and getting better at cleaning up code so that it's easier to read and build off of is a continuous process.

Let's do a few things to make our program a little less overwhelming. Right now, all of the code sits inside the `main` function. This makes it simpler, but the length of our `main` function with all of the styling present makes it a little difficult to see at a glance what we're trying to do with our code.

One thing we can do to improve our program is **factor out** the style attributes into their own functions. Remember that words can be replaced by their definitions. So instead of putting all of the styling in main, we can replace them with functions whose definitions are each of the styles.

### Replacing styling with functions

Create a new function called `pageStyling`, and define it to be equal to the HTML style attributes we used in our `div` container.
{: .info}

{% highlight haskell %}
pageStyling = Html.Attributes.style [ ("text-align", "center") ]
{% endhighlight %}

Now we can use our new function in place of the style attributes we wrote out as the first input to our `Html.div` function.

{% highlight haskell %}
Html.div
  [ pageStyling ]
  [ ...rest of page elements ]
{% endhighlight %}

### Repeating the process

We can repeat this process for the rest of our page elements.

Make new functions for `headingStyling`, `searchboxStyling`, `buttonStyling`, and `imageStyling`
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

Now we can use these new functions to replace the styling in our `main` function. I'm also going to go ahead and add a few spaces for readability.

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

Much cleaner! If you're familiar with Elm and HTML, you can practically just read the code and understand what's going on without having to worry about the details about how every individual element is styled.
