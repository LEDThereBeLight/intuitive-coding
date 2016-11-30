---
layout: post
title: "Imports"
subtitle: "How to use modules in our code"
section: elm
---

### Importing modules

Let's finish up with the first line in our code.

{% highlight haskell %}
import Html

main = Html.text "Sucking at something is the first step towards being sorta good at something."
{% endhighlight %}

Some modules are available for use in our code by default. We have access to modules that help us work with Lists and Strings, modules that let us do basic math functions like addition and multiplication, and so on.

Other modules are a little less common, so while they still come packaged with the Elm language, we have to specifically tell Elm we want to use them. We can do this by using an *import statement*.

`import` is a type of word called a **command**. Commands are very similar to functions. We use functions to ask the computer to *give us* something, and we use commands to ask the computer to *do* something.

In this case, we're telling the computer to import the Html module and make its functions available for us to use in our code.
