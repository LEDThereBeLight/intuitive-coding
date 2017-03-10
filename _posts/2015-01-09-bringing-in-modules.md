.---
layout: post
title: "Imports"
subtitle: "Using modules in our code"
section: elm
comments: true
---

### Importing modules

Let's finish up with the first line in our code.

{% highlight haskell %}
import Html

main = Html.text "Sucking at something is the first step towards being sorta good at something."
{% endhighlight %}

Some modules are available for use in our code by default. We have access to modules that help us work with Lists and Strings, modules that let us do basic math functions like addition and multiplication, and so on.

Other modules are a little less common, so while they still come packaged with the Elm language, we have to specifically tell Elm we want to use them. We can do this by using an *import statement*.

`import` statements are commands: they have the effect of pulling in the module for use in our code.

In this case, we're telling the computer to import the Html module and make its functions available for us to use in our code.
