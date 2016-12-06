---
layout: post
title: "Creating new words"
subtitle: "Making our own language"
section: elm
---

### Making new words

It's fun to make a language, and we do it all the time in programming.

Let's look at the code we wrote again.

{% highlight haskell %}
import Html

main = Html.text "Sucking at something is the first step towards being sorta good at something."
{% endhighlight %}

The first line with `import Html` is a **command**, which is another type of expression that we'll come back to soon.

The second line says to create a new word called `main` and define it to be:
```haskell
Html.text "Sucking at something is the first step towards being sorta good at something."
```

We use the `=` symbol to make new words. Symbol isn't a special word - it just means a specific letter or character. Languages are made up of symbols that make up words and punctuation.

`=` is a symbol that takes two expressions:
1. A **name** to call the word, which we put on the left
2. A **definition** for the word, which we put on the right

So why on earth would we want to make a new word called `main`?

### main

The answer is that many programming languages (Elm included) are designed to look for a `main` function to run at the beginning of the program. This is a way to start our program off. Elm takes the definition of the `main` function that we wrote, runs it, and shows the output on the screen.

But `main` is very particular about the kinds of things it is willing to show on the screen.

![This is what main looks like](https://media.giphy.com/media/7RRYTJOBU8eWs/giphy.gif)
*a picture of main*

`main` won't accept just *anything* and show it on the screen. It only considers showing a certain **type** of expression.

### Types

A type is a category that we decide an expression falls into. Each type has a name, and we always capitalize their names to make it easier to tell them apart from other kinds of words, like functions.

There are lots of different types.

`'a'` is a **Character** type, because it's a single letter. Characters go inside single quotes.

**List** is a type that can hold another type. A List can only contain one type of data. You can't have a List of both letters and numbers, for example. 

Just like Characters go inside `' '`, Lists have their own symbol that they go inside. Lists use square brackets: `[ ]`. To make things clearer, each item in a list is separated by a comma.

Say you have a bunch of individual Characters:
  * `'h'`
  * `'e'`
  * `'l'`
  * `'l'`
  * `'o'`

Characters are great all by themselves, but sometimes we want to put them together to make words. We can string letters together to make words by putting them inside a List, like this:

`['h', 'e', 'l', 'l', 'o']`

But since it's pretty common to talk about words in our programs, we don't have to write them out as Lists of Characters with square brackets and single quotes going every which way. There's another type that exists as a kind of shorthand for Lists of Characters. It's called a **String**, and we make one with double quotes: `" "`.

{% highlight haskell %}
"Who's this Rorschach dude and why is he so good at drawing pictures of my dad beating me?"
{% endhighlight %}

So why do we use quotes for letters and words? There's a good reason. Let's switch back to English for a moment. I'm going to tell you to do something.

### Say your name.

The two words "your" and "name" combine to make an expression that represents a specific name: **yours**.
### Say "your name"

This sentence means to literally say the words in quotations - there's no meaning behind them.

Coding uses the same idea. If we are writing code and want to talk about actual letters or words themselves, rather than the ideas they represent, we put the letters in quotations.

### So, to recap
* Single letters go in single quotes, and we call them *Characters*
* Multiple letters go in double quotes, and we call them *Strings*
