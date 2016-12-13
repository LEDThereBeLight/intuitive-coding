---
layout: post
title: "Learning a <strong>Language</strong>"
subtitle: "What exactly is coding, anyway?"
section: elm
---

### What is a language?

Languages let us combine expressions into structures that create larger meanings. In spoken languages, we can string together words into sentences that flow together fluently like the ones you're reading now.

Programming languages are the same as any spoken language. We have words, we have meanings, and we have rules for how to order the words.

Each programming language has different types of sentences, just like in natural languages. There are two main types of sentences in programming.

We have statements, where we *state* the way something is.

The sky is blue.
{: .info}

And we have commands, where we tell the computer to do something.

Capitalize this sentence and print it on the screen.
{: .info}

### Settling for programming languages

It would be nice if we could write normal English sentences in programming languages. But natural languages are complex, and the same word in English can often mean multiple different things, which makes them pretty tough to program with. We haven't figured out how to get computers to learn how to read between the lines - just think of how frustrating it can be to get Siri to understand what you're asking. 

So instead, we create new simplified languages without any filler words that can't be interpreted in multiple different ways. They don't sound as natural when you read them, but at least they're not ambiguous. 

### How to read

Computers read top-down, left-to-right just like us. Imagine you are a 5 year old just learning how to read. You don't know a lot of words, but you know some words. You can use the words you already know to help you learn more words.

You've just opened up a new book, and you read this sentence:

Not for the first time, an argument had broken out over breakfast at number four, Privet Drive.
{: .info}

You understand the first few words and know what's going on until you get to a word you haven't seen before: **argument**.

### Building our vocabulary

You look up "argument" in the dictionary, and you see the definition "an exchange of opposite views". Since an expression can be replaced by its definition, you substitute those words into the sentence to make it easier for you to understand:

Not for the first time, an exchange of opposite views had broken out over breakfast at number four, Privet Drive.
{: .info}

But you don't know what **exchange** or **opposite** mean, so you still can't understand the sentence.

You've got great discipline, so you decide to look up the definitions of each of those two words and substitute them into the sentence.

After substituting the definitions for **exchange** and **opposite** into the sentence, you end up with:

Not for the first time, an act of giving and receiving two things having opposite views had broken out over breakfast at number four, Privet Drive.
{: .info}

That's better, but the rest of the sentence still has some words you don't understand. So you go through the whole sentence and replace each expression or word with its definition until you get down to a sentence that has only words that you understand.

### The final sentence

After substituting the definition for every word you don't know, you end up with a sentence you can completely understand:

Not for the first time, an act of giving and receiving two things having opposite views had broken out over the first meal of the day at number four, Privet Carry Along by Force.
{: .info}

Okay, I don't think that whole process made it much easier to read either.

But a computer does. And that's how computers work. A hardware developer starts a computer off with a small set of words it understands and can perform, actions like addition and subtraction.

We as programmers teach computers new words so that we can write using language that we understand, rather than only using commands that the computer starts off knowing.

Computers look up and replace these new words with their definitions until they get down to basic operations they know how to perform.

This is great, because it means learning to program is more like learning a language than it is like learning a science. It's just a language that tells a computer what to do. Once you learn the most common words, you can get your point across, even if you sound a little bit awkward.

------

### Optional Note:

This section hints at a very deep concept that sits at the heart of computer science. But we're not hinting anymore. The idea is that we as authors must choose the way we word our code. If we want, we can code at the level of the machine and explicitly write out every instruction for the computer to perform. This is called **low level** programming. The benefit of coding in this way is that our programs will run faster because they are doing *exactly* what we want - no more, no less. The downsides with coding at this level are that it takes longer to write, and it's easy to get lost in the machine instructions and miss the higher level problems that we're trying to solve. Read the final version of the "translated" sentence above and compare it to the original version written by JK Rowling. Which is easier to understand?

On the opposite end of the spectrum, we can write code at a **high level**, explaining the ideas that we want the computer to perform and letting the people who wrote the programming language decide how to execute the tasks. The benefit is that it's faster to develop this way, because we focus on the problems we're trying to solve and not on telling the computer how to do its job. It's also easier to learn to program this way, because we can rely on the techniques developed by computer scientists in the last hundred years and not have to recode everything ourselves. What's more, with modern advances in computer hardware, the speed difference between low and high level languages is inconsequential outside enterprise or scientific applications.

One of the most valuable skills of a coder is being able to work at the right level of *abstraction*, meaning choosing between using high level concepts or low level instructions. A specific problem might be trivial to solve at a high level, or it might be impossible.

There are examples of programming languages on every part of the abstraction spectrum. Low level languages include the Machine Languages and Assembly Code. High level languages include Elm, Haskell, Ruby, and Python. And somewhere in between are languages like C, Javascript, and Java.
