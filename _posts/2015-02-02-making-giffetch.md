---
layout: post
title: "Making Giffetch"
subtitle: "Starting to build our program"
section: app-building
comments: true
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

Let's change our program to display an image instead of text. The Html module has lots of different functions for displaying things on a page - `text` is just one of them. You can see all the different options at [Elm's docs](http://package.elm-lang.org/packages/elm-lang/html/2.0.0/Html), but admittedly, Elm's documentation is rather poor. It's meant for professional developers who are already familiar with functional languages like Haskell. So we'll be explaining everything as we go along.

### A quick note on HTML

You can continue this section without any knowledge of HTML, but it will be clearer if you understand some basic concepts of the language. HTML is a pretty simple language, and a very valuable skill, so if you've never seen it before, I recommend taking an hour and skimming the wonderful HTML section on Jeremy Thomas' [marksheet.io](http://marksheet.io/html-basics.html). If you take a look, you'll notice his site is the layout I started with to create this website.

You don't need to know much about HTML, but you should know three things:

  * How to recognize HTML when you see it
  * Some of the most common elements, such as `div`, `img`, `a`, and `p`
  * How HTML elements combine to build a page (hint: elements are **nested**, or placed within other elements).

I'll do my best to explain things as we go, but a little bit of background knowledge will help.

### The Elm `img` function

Every HTML element is available in Elm as a function, and they have the same name as their HTML counterparts:

  * `div`, `span`
  * `h1`, `h2`, `h3`
  * `p`
  * `ul`, `li`
  * `br`

All of the HTML functions in the Elm Html module take two inputs:

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

What we're doing here is creating an image element and providing an empty List of attributes and an empty List of children elements.

Spacing usually doesn't matter in Elm (it does in some languages), so all of these are equivalent. If spacing does matter and you mess it up, the Elm compiler will tell you, so I won't bother to list out the places here. It's not really something to worry about.

{% highlight haskell %}
import Html

main = Html.img
  []
  []
{% endhighlight %}

{% highlight haskell %}
import Html

main = Html.img [ ] [ ]
{% endhighlight %}

### A source for our image

There's an image element on our page, but we haven't told Elm the address for where our image is located, so nothing shows up. Let's add a **source** for the image by using the HTML `src` attribute.

The Elm Html module only has functions for HTML elements. To add an HTML attribute, we need to import another module, appropriately named `Html.Attributes`.

### Where is Html.Attributes?

Even though it's two words, `Html.Attributes` is just one module. It's just saved in Elm inside a folder called "Html", so we use the `.` to access it. Honestly, this isn't important to understand, but Elm stores its modules in a file structure like this:

<ul class="files">
  <li>
    <i class="fa fa-folder-o"></i>
    elm_modules
    <ul>
      <li>
        <i class="fa fa-file-code-o"></i>
        Html (the module we've already imported)
      </li>
      <li>
        <i class="fa fa-folder-o"></i>
        Html
        <ul>
          <li>
            <i class="fa fa-file-code-o"></i>
            Attributes (our new module)
          </li>
        </ul>
      </li>
    </ul>
  </li>
</ul>

The point is that `Html.Attributes` is really just one module. It's good enough just to remember that whenever we use it, we have to use its full name of `Html.Attributes`.

### Importing Html.Attributes

Import the Html.Attributes module, then add a `src` with a URL to the first input of the `img` element.
{: .info}

The order of the `import` lines doesn't matter.

{% highlight haskell %}
import Html
import Html.Attributes

main = Html.img [Html.Attributes.src "https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif"] []
{% endhighlight %}

<img src="https://media.giphy.com/media/11s7Ke7jcNxCHS/giphy.gif">
{: .answer}

Progress. Now we've set the source location of our image element to an image URL, so a picture shows up on the page. All we're doing here is saying, "the img element takes a List of one attribute" - namely, a `src` attribute.


*[Html]: An elm module with functions that create HTML webpage elements
*[div]: A division element, used to group other elements into a section
*[span]: Used to create sections within text with different formatting from the rest of the text
*[h1]: A primary heading element for title text
*[p]: A paragraph element function
*[ul]: An unordered list container
*[li]: A list item element function
*[br]: A line break element function
*[attributes]: A way of providing additional information about the HTML element, like the file location for images
*[img]: An image element function
*[src]: The location for an image, usually a URL
*[[]]: An empty list
