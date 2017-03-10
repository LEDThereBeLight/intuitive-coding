---
layout: post
title: "What is a function, anyway?"
subtitle: "or asking for cookies"
section: elm
comments: true
---

### Functions

English has different types of words, like nouns and verbs. Programming has different types of words, too.

One of the most common types of words we use in coding is called a **function**.

We use functions to ask the computer to *give us something*. Imagine your oven can talk. You want some cookies, so you say to it, "Bake." But your oven has a few questions for you before it knows exactly what you want. It asks you, "Bake what? For how long? At what temperature?" We have to answer all its questions before it can do its job. But once it has all the information it needs, it can "run" to start baking. We don't need to know how the oven does its job - all we care about is what we put in, the raw dough, and what we get back, the cookies.

Functions work the same way. We ask the computer to give us something, and we answer the questions it needs to know to get what we want. Whenever we want to ask the computer for something, we need to think about the questions it will have to "ask" in order to get what we want.

### I/O

We call the information that the function needs the **inputs**, **arguments**, or **parameters** to the function, and what it gives us back is called the **output**. Input, argument, and parameter all mean the same thing.

So how do we use a function? It's easy. All we have to do is get its attention. And we get a function's attention the same way we get anyone's attention: by **calling its name**. We call a function by writing out the name of the function, and then giving it an input if it needs one.

<!-- We can answer its questions all at once, and it will run, or we can answer some of them now and keep the function around to run later. -->

Remember the code we just wrote?

{% highlight haskell %}
import Html

main = Html.text "Sucking at something is the first step towards being sorta good at something."
{% endhighlight %}

`Html.text` is a function that takes one input: a string of text to show on the screen. When we give a function an input, we call the combination a **functional expression**. Elm takes the output of this functional expression and automatically shows it on the screen.

Functions are not able to affect anywhere else in the program - they are completely self-contained. That is to say, they have no **effects** - they take inputs, and give back outputs, and that's all they do. They don't *change* anything. Part of the reason we're using Elm to start with, rather than, say, Javascript, is because Elm makes a distinction between *functions* and *commands*. A function is just code that returns a value. A command, which we'll come back to later, has an effect like printing to the screen, or changing a value in memory.

### In short

Remember:

  * functions can take in inputs, but they don't have to
  * functions always give us something back
  * we tell the computer to run a function by calling its name

<!-- [^1]: Technically, "parameter" and "argument" are not *necessarily* the same. Say you have a function:
{% highlight haskell %}
add num1 num2 = num1 + num2

main = Html.text <| toString <| add 3 4
{% endhighlight %}
You would say "the arguments to the function add are '3' and '4'", or "the actual parameters to add are '3' and '4'." That's what actually goes into the function when you call it. On the other hand, you would say, "the formally bound parameters in the add function are num1 and num2", because they're what the function is defined to use. The function, when called, takes the *actual* parameters and *binds* the formal parameter names to those values. -->
