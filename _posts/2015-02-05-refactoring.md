---
layout: post
title: "Refactoring"
subtitle: "Easy to read, easy to change"
section: app-building
comments: true
---

### Refactoring our code

In coding, just like in writing, we usually get our thoughts out onto the page and get the program to work the way we want it to, then proofread our statements and clean our code so that it's easier to read and work with.

Edgar Allen Poe was a pretty good writer, I'd say. Good enough at least to get a bunch of American schools to force kids to read his books. He wrote an essay about his writing style, called [The Philosophy of Composition](http://www.eapoe.org/works/essays/philcomp.htm). He talks about his approach to writing some of his best works, and uses *The Raven* as an example. Here's how he describes his writing style:

It is my design to render it manifest that no one point in its composition is referrible either to accident or intuition — that the work proceeded, step by step, to its completion with the precision and rigid consequence of a mathematical problem.
{: .quote}

What he's saying is that he doesn't write anything that doesn't tie into the underlying story, and he doesn't write anything that the reader already knows.

He actually does a pretty good job of explaining good coding style. We should keep our problem in mind and write only what's necessary to solve it.

The process of cleaning up our writing is called proofreading, and the process of cleaning up our code is called **refactoring**. What is refactoring? Well, **factoring** means to separate something into pieces to make something less complex (remember factoring in math class?), and "re" just means doing it again and again. Technically, refactoring is only part of the code editing process, but the word is generally used for the entire process.

There are a few main things we look for when refactoring, roughly in order of importance:

  1. **Complex code.** "Complex" literally means "built from many interconnected parts". We should try to think of our code as built from Legos that can be mixed and matched. Elm helps us out with this naturally.
  2. **Hard to read code**, like unhelpful variable names. We should be able to read our code without having to constantly look up the definitions of functions.
  3. **Horribly inefficient code**, though this takes some practice to be able to spot. It's better to have poor performance than to waste time optimizing something that doesn't need to be optimized.
  4. **Repetition**. Finding repetition means we should *consider* replacing it with a function, since it sets someone up to forget changing one of the occurrences if they want to modify our code in the future.

<!-- {: .quote-text .blue} -->

Honestly, in my opinion, some repetition isn't that big of a deal. The most important thing we need to worry about is making our code *simple* and *readable*, so that whoever is coming along after us can easily understand what's going and make changes without breaking everything. This is easier said than done.

Let's do a few things to make our program a little easier to read. Right now, all of the code sits inside the `main` function. This made it easier to write, but the length of our `main` function with all of the styling for every element makes it difficult to see at a glance what we're trying to do with our program.

### Replacing styles with functions

One thing we can do to improve our program is factor out the style attributes into their own functions. Remember that words can be replaced by their definitions. So instead of putting all of the styling in `main`, we can replace them with functions with definitions that equal our original in-line styling.

Let's create a new function called `pageStyling`, and define it to be equal to the HTML style attributes we used in our `div` container.
{: .info}

{% highlight haskell %}
pageStyling = Html.Attributes.style [ ("text-align", "center") ]
{% endhighlight %}

Now we can use our new function to replace the style attributes we used as the first input to our `Html.div` function.

{% highlight haskell %}
Html.div
  [ pageStyling ]
  {- other page elements -}
{% endhighlight %}

By the way, the line with `{- -}` is a comment. The Elm compiler ignores comments when the code is run.

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

buttonStyling =
  Html.Attributes.style
    [
      ("padding", "10px"),
      ("background-color", "#99ddff"),
      ("border-radius", "2px"),
      ("border", "1px solid #99ddff"),
      ("color", "white"),
      ("font-size", "1.5em"),
      ("margin", "5px"),
      ("cursor", "pointer")
    ]

imageStyling =
  Html.Attributes.style
    [
      ("border-radius", "2px"),
      ("box-shadow", "0 2px 4px rgba(0,0,0,0.12), 0 2px 3px rgba(0,0,0,0.24)")
    ]
{% endhighlight %}

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

Now we can use these new functions we just wrote to replace the styling in our `main` function. I'm also going play with the spacing in the code a bit for readability.

{% highlight haskell %}
import Html
import Html.Attributes

main = Html.div
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

*(style definitions)*
{% endhighlight %}

Much cleaner! Now, if we know a little Elm, we can just read the code and understand what's happening without having to worry about the details about how every individual element on the page is styled.
