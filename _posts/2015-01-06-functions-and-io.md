---
layout: post
title: "What is a function, anyway?"
subtitle: "or asking for cookies"
section: elm
---

### Functions

English has different types of words, like nouns and verbs. Programming has different types of words, too.

One of the most common types of words we use in coding is called a **function**.

We use functions to ask the computer to *give us something*.

Imagine your oven can talk. You want some cookies, so you say to it, "Bake."

But your oven has a few questions for you before it knows exactly what you want. It asks you, "Bake what? For how long? At what temperature?" We have to answer all its questions before it can do its job.

<!-- //- The oven can't do its job until all its questions are answered, but you don't have to answer all the questions at once. You can answer some, and the oven will remember what you told it. It's like saving your settings.
//-
//- Maybe you always bake for 10 minutes at 350 degrees. So you change the settings on your oven to always bake at that temperature for that amount of time. Now you can bake different things without mentioning the temperature or time again. You bake cookies today, and cake tomorrow - the oven already knows how long and what temperature to bake at.
//-
//- If you need to, you can always reset the settings and start over with a new "bake" request. But the oven will only *run* when it has all its questions answered - in this case, it has a temperature, time, and something raw to bake. -->

Functions work the same way. We ask the computer to give us something, and we answer the questions it needs to know to get what we want. Whenever we want to ask the computer for something, we need to think about the questions it will have to "ask" in order to get what we want.

### I/O

We call the information that the function needs the **inputs**, **arguments**, or **parameters** to the function, and what it gives us back is called the **output**. Input, argument, and parameter are all synonymous.[^1]

So how do we use a function? It's easy. All we have to do is get its attention. And we get a function's attention the same way we get anyone's attention: by **calling its name**.

<!-- We can answer its questions all at once, and it will run, or we can answer some of them now and keep the function around to run later. -->

Remember the code we just wrote?

{% highlight elm %}
import Html

main = Html.text "Sucking at something is the first step towards being sorta good at something."
{% endhighlight %}

`Html.text` is a function that takes one input: a string of text to show on the screen. When we give a function an input, we call the combination a **functional expression**. Elm takes the output of this functional expression and automatically shows it on the screen.

### In short

Remember:
  * functions always give us something, and
  * we tell the computer to run a function by calling its name and giving it an input

[1]: Technically, "parameter" and "argument" are not *necessarily* the same. Say you have a function:
{% highlight elm %}
add num1 num2 = num1 + num2

main = Html.text <| toString <| add 3 4
{% endhighlight %}
You would say "the arguments to the function add are '3' and '4'", or "the actual parameters to add are '3' and '4'." That's what actually goes into the function when you call it. On the other hand, you would say, "the formally bound parameters in the add function are num1 and num2", because they're what the function is defined to use. The function, when called, takes the *actual* parameters and *binds* the formal parameter names to those values.
