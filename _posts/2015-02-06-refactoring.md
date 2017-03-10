---
layout: post
title: "Refactoring"
subtitle: "Easy to read, easy to change"
section: app-building
comments: true
---

### Refactoring our code

In coding, just like in writing, we usually get our thoughts out onto the page and get the program to work the way we want it to, then proofread what we wrote to clean up our code so that it's easier to read and work with.

Edgar Allen Poe was a pretty good writer, I'd say. Good enough at least to get a bunch of American schools to force kids to read his books. He wrote an essay about his writing style, called <a href="http://www.eapoe.org/works/essays/philcomp.htm" target="_blank">The Philosophy of Composition</a>. He talks about his approach to writing some of his best works, and uses *The Raven* as an example. Here's how he describes his writing style:

It is my design to render it manifest that no one point in its composition is referrible either to accident or intuition — that the work proceeded, step by step, to its completion with the precision and rigid consequence of a mathematical problem.
{: .quote}

What he's saying is that he doesn't write anything that doesn't tie into the underlying story, and he doesn't write anything that the reader already knows.

He actually does a pretty good job of explaining good coding style. We should keep our problem in mind and write only what's necessary to solve it.

The process of cleaning up our writing is called proofreading, and the process of cleaning up our code is called **refactoring**. What is refactoring? Well, **factoring** means to separate something into pieces to make something less complex (remember factoring in math class?), and "re" just means doing it again and again. Technically, refactoring is only part of the code editing process, but the word is generally used for the entire process.

There are a few main things we look for when refactoring:

  1. **Making code less complex.** "Complex" literally means "built from many interconnected parts". We should try to think of our code as built from many small, independent pieces, rather than pieces that all depend on one another.
  2. **Hard to read code**, like unhelpful variable names. We should be able to read our code without having to constantly look up the definitions of functions.
  3. **Horribly inefficient code**, though this takes some practice to be able to spot. It's better to have poor performance than to waste time optimizing something that doesn't need to be optimized.
  4. **Repetition**. Finding repetition means we should consider replacing it with a function, since it sets someone up to forget changing one of the occurrences if they want to modify our code in the future.

Let's do a few things to make our program a little easier to read. Right now, all of the code sits inside the `main` function. This made it easier to write, but the length of our `main` function with all of the styling for every element makes it difficult to see at a glance what we're trying to do with our program.

### Replacing styles with functions

One thing we can do to improve our program is factor out the style attributes into their own functions. Remember that words can be replaced by their definitions. So instead of putting all of the styling in `main`, we can replace each statement with a function.

Create a new function called `pageStyling`, and define it to be equal to the HTML style attribute we used in our `div` container.

{% highlight haskell %}
pageStyling = Html.Attributes.style [ ("text-align", "center") ]
{% endhighlight %}

Now we can use our new function to replace the style attribute we used as the first input to our `Html.div` function.

{% highlight haskell %}
Html.div
  [ pageStyling ]
  [{- other page elements -}]
{% endhighlight %}

By the way, the line with `{- -}` is a comment. The Elm compiler ignores comments when the code is run.

### Repeating the process

Remember that we repeated the button styling three times in our code. Whenever we see a code pattern repeated multiple times, we should think about making it into a function. We usually want to eliminate as much code as we can, since unwritten code can never break.

The solution is to do what we just did for the `pageStyling` function with each element on our page. Let's make new functions for `headingStyling`, `buttonStyling`, and `imageStyling`.

{% highlight haskell %}
headingStyling =
  Html.Attributes.style
    [
      ("font-size", "2em"),
      ("color", "#333"),
      ("padding-bottom", "30px")
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
      ("cursor", "pointer"),
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
main = Html.div
  [ pageStyling ]
  [
    Html.h1 [ headingStyling ] [ Html.text "cats" ],
    Html.button [ buttonStyling ] [ Html.text "cats" ],
    Html.button [ buttonStyling ] [ Html.text "dogs" ],
    Html.button [ buttonStyling ] [ Html.text "ice cream" ],
    Html.br [] [],
    Html.br [] [],
    Html.img [ imageStyling, Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif" ] []
  ]

{- style definitions we just created -}
{% endhighlight %}

### Final code

Here's our code so far.

{% highlight haskell %}
module Main exposing (..)
import Html
import Html.Attributes

main = Html.div
  [ pageStyling ]
  [
    Html.h1 [ headingStyling ] [ Html.text "cats" ],
    Html.button [ buttonStyling ] [ Html.text "cats" ],
    Html.button [ buttonStyling ] [ Html.text "dogs" ],
    Html.button [ buttonStyling ] [ Html.text "ice cream" ],
    Html.br [] [],
    Html.br [] [],
    Html.img [ imageStyling, Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif" ] []
  ]

pageStyling = Html.Attributes.style [ ("text-align", "center") ]

headingStyling =
  Html.Attributes.style
    [
      ("font-size", "2em"),
      ("color", "#333"),
      ("padding-bottom", "30px")
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

Much cleaner! Now to get us in the habit of saving early and often, let's commit our changes again.

{% highlight shell %}
$ git add -A
$ git commit -m "Refactor styling into individual functions"
{% endhighlight %}
