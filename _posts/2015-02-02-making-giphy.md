---
layout: post
title: "Making Giffetch"
subtitle: "Starting to build our program"
section: app-building
---

### Starting our Elm program

We'll start this program the way we start every Elm program, by importing the Html module and defining the `main` function.

{% highlight haskell %}
import Html

main = Html.text "Starting text"
{% endhighlight %}

This produces the following result:

Starting text
{: .answer}

Let's change our program to display an image instead of text. The Html module has lots of different functions for displaying things on a page - `text` is just one of them. You can see all the different options at [Elm's docs](http://package.elm-lang.org/packages/elm-lang/html/2.0.0/Html), but we haven't learned how to even read the docs yet, so we'll be explaining the functions we need in detail here.

### A quick note on HTML

You can continue this section without any knowledge of HTML, but it will be clearer if you understand some basic concepts of the language. HTML is a pretty simple language, so if you've never seen it before, I recommend taking an hour and skimming the HTML section on [marksheet.io](http://marksheet.io/html-basics.html). You don't need to know much about HTML, but you should know three things:
  * How to recognize HTML when you see it
  * Some of the most common elements, such as `div`, `img`, `a`, and `p`
  * How HTML elements combine to build a page (hint: elements are **nested**, or placed within other elements).

I'll do my best to explain things as we go, but a little bit of background knowledge will help.

### The Elm `img` function

Every HTML element is available in Elm as a function, and they have the same name as their HTML counterpart:
  * `div`, `span`
  * `h1`
  * `p`
  * `ul`, `li`
  * `br`


All of these HTML functions in the Elm Html module take two inputs:
  1. A list of HTML attributes
  2. A list of children elements

### Displaying an image

Let's use the `img` function to draw an image on the page.

Replace `Html.text "Starting text"` with `Html.img [] []`, then compile.
{: .info}

{% highlight haskell %}
import Html

main = Html.img [] []
{% endhighlight %}

<img src="#"/>
{: .answer}

What we're doing here is creating an image element and providing an empty list of attributes and an empty list of children elements.

### A source for our image

There's an image element on our page, but we haven't told Elm the address for where our image is located, so nothing shows up. Let's add a **source** for the image by using the HTML `src` attribute.

The Elm Html module only has functions for HTML elements. To add an HTML attribute, we need to import another module, appropriately named `Html.Attributes`.

Import the Html.Attributes module, and change the first input of the `img` element from `[]` to `[Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"]`
{: .info}

{% highlight haskell %}
import Html
import Html.Attributes

main = Html.img [Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"] []
{% endhighlight %}

<img src="https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif">
{: .answer}

Progress. Now we've set the source location of our image element to an image URL, so a picture shows up on the page.

### A detour

By far, the most complicated part of our app is going to be the part that allows us to search for a GIF on the internet and display it on the page. We'll work up to that, but for now it makes sense to start with something slightly simpler until we can see how all the pieces of the app will fit together. 

Instead of adding a search bar, for now we're going to add a few buttons that the user can click on to show GIFs from different categories. This will dramatically simplify our app and allow us to tackle the steps involved in searching the internet all at once, after we have a working app already.

Here's what we're going to start with:

![cats, dogs, and ice cream](/images/app-mvu.png)

### Building the rest of the page

Let's add the title and buttons to our page.

Here are the functions we'll need:
  * `h1`, for the title
  <!-- * `input`, for the search bar -->
  * `button`, for the search button
  * `br`, for adding line breaks to space out our elements

### Wrapping our elements

We want to add some more HTML elements to our `main` function, but if we do that we'll run into a problem: function definitions only accept a *single expression* as a definition. So how do we add more elements while keeping the definition of `main` as a single expression?

The answer is to use an HTML `div` element that will contain all of the page elements that we want to display. Divs are meaningless, they're just used to group together elements in a page, which is exactly what we need.

Let's nest our `img` element within a `div` as the second input to the function.
{: .info}

{% highlight haskell %}
import Html
import Html.Attributes

main = Html.div
  []
  [
    Html.img [Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"] []
  ]
{% endhighlight %}

<div><img src="https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"></div>
{: .answer}

### Adding a heading

Now we can add as many HTML elements as we want by just adding to the list and separating the elements with commas.

Let's add a heading with the code `h1 [] []`
{: .info}

{% highlight haskell %}
import Html
import Html.Attributes

main = Html.div
  []
  [
    Html.h1 [] [],
    Html.img [Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"] []
  ]
{% endhighlight %}

<div><h1></h1><img src="https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"></div>
{: .answer}

This will create a line for our heading with an empty list of attributes and an empty list of children elements.

### Filling in our heading

The heading is there, but it doesn't have any text. We already know how to add text: we can use our favorite function, `Html.text`. We're putting the text *inside* the heading element, so it should go inside the second input to the h1 function.

Change the second input to the `h1` function from `[]` to `[Html.text "cats"]`.
{: .info}

{% highlight haskell %}
import Html
Html.Attributes

main = Html.div
  []
  [
    Html.h1 [] [Html.text "cats"],
    Html.img [Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"] []
  ]
{% endhighlight %}

<div><h1>cats</h1><img src="https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"></div>
{: .answer}

<!-- ### A search bar

Right under the heading, let's add a search bar that we can use to get gifs from different categories.

Add a line below the `h1` element with the code `input [] []`
{: .info}

{% highlight haskell %}
import Html
import Html.Attributes

main = Html.div
  []
  [
    Html.h1 [] [Html.text "cats"],
    Html.input [] [],
    Html.img [Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"] []
  ]
{% endhighlight %}

<div><h1>cats</h1>
<input/><img src="https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"></div>
{: .answer} -->

### Some buttons

Now let's add a few buttons that we can press to trigger new GIFs.

Add three lines below the `h1` element with the code `button [] [Html.text "topic"]`, and then change the text to the three categories of pictures you want to show.
{: .info}

We'll use cats, dogs, and ice cream for our categories.

<div><h1>cats</h1><input/><button>cats</button><button>dogs</button><button>ice cream</button><img src="https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"></div>
{: .answer}

### Some breathing room

Finally, let's space things out so we have a little more room.

Add some `br [] []` lines to create new lines between our elements.
{: .info}

{% highlight haskell %}
import Html
import Html.Attributes

main = Html.div
  []
  [
    Html.h1 [] [Html.text "cats"],
    Html.input [] [],
    Html.br [] [],
    Html.br [] [],
    Html.button [] [Html.text "cats"],
    Html.button [] [Html.text "dogs"],
    Html.button [] [Html.text "ice cream"],
    Html.br [] [],
    Html.br [] [],
    Html.img [Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"] []
  ]
{% endhighlight %}

<div><h1>cats</h1><input/><br/><br/><button>cats</button><button>dogs</button><button>ice cream</button><br/><br/><img src="https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"></div>
{: .answer}

*[Html]: An elm module with functions that create HTML webpage elements
*[div]: A division element, used to group other elements into a section
*[span]: Used to create sections within text with different formatting from the rest of the text
*[h1]: A primary heading element for title text
*[input]: A text input field element
*[p]: A paragraph element
*[ul]: An unordered list container
*[li]: A list item element
*[br]: A line break element
*[attributes]: A way of providing additional information about the HTML element, like the file location for images
*[img]: An image element
*[src]: The location for an image, usually a URL
*[[]]: An empty list
