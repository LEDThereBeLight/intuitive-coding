---
layout: post
title: "Modules"
subtitle: "Or how to be as <strong>lazy</strong> as possible"
section: elm
comments: true
---

### Getting functions from other places

Here's our code again.

{% highlight hs %}
import Html

main = Html.text "Sucking at something is the first step towards being sorta good at something."
{% endhighlight %}

So we know the words in the double quotes make up a single String. Let's talk about the `Html.text` function now. What's going on here? Why is one of the words capitalized? What is Html, anyway? And why the hell does this expression have a period in it - don't periods go at the end of sentences?

First, on why Html is capitalized.

### Modules

People have been writing code for a long time. It would be pretty ridiculous to have to reinvent every function we want to use when most things we can think of have already been created. So programming has a way to import functions from other places to use in our code. There are many ways to accomplish this, but Elm uses a modern approach called **modules**.

A **module** is a just a file. Every file we write is a different module. You can think of a module like a box with a bunch of functions inside. We might have a Math module which has functions for addition and subtraction, or a String module which has functions for uppercasing or lowercasing words.

Just like types, we always *capitalize* specific module names, otherwise the compiler will get confused.

![module](https://media.giphy.com/media/j1BQPAjNzKh9K/giphy.gif)
*a module with a function inside*

So `Html` is a module. But why is it called that?

The Html module is named after the HTML programming language, which was developed in the '90s to create web pages. So Elm's Html module is basically a box with a bunch of HTML functions inside. One of the functions inside the Html module is called `text`, which takes a single String as input and converts it into raw HTML to draw on the page.

We can use the Html module's text function to display our sentence on the page.

### Going deeper

Let's talk about the `.` in between Html and text now.

{% highlight haskell %}
import Html

main = Html.text "Sucking at something is the first step towards being sorta good at something."
{% endhighlight %}

In programming languages, it's common to use the `.` symbol to mean *"look inside."* It doesn't always mean this, but that's a good first guess whenever you see a `.` in a new language. In Elm, the `.` almost always means to "look inside."

So to translate `Html.text` into English, we could say "Look inside the Html module for a function called text."


<!-- [^1]: If you're familiar with object oriented languages, modules are Elm's approach to classes. Modules provide a form of encapsulation that allow coders to define public and private methods which can be selectively "exported" for use in other modules. The important difference is that Elm provides no implementation for inheritance - it strictly uses composition instead. Modules are an attempt at getting the best of both worlds from both functional and object oriented languages. Traditionally, object oriented languages and functional languages have been good at different mutually exclusive things. Object oriented languages are better when programs have a relatively constant number of procedures but new *things* are being added on over time. Functional languages are better when there are relatively constant *things* interacting, but the functionality of those things increases over time. Functional programming with modules (popularized by Haskell and other languages) is an attempt at providing the modularity of functional languages and the encapsulation of object oriented languages. -->
