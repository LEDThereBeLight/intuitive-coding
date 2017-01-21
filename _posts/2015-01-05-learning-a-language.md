---
layout: post
title: "Learning a <strong>Language</strong>"
subtitle: "What exactly is <strong>programming</strong>, anyway?"
section: elm
comments: true
---

### Settling for programming languages

It would be nice if we could write normal English sentences to program computers. But natural languages are complex, and the same word in English can often mean multiple different things. Computers are pretty stupid at this stage of history. We haven't figured out how to get them to read between the lines - just think of how frustrating it can be to get Siri to understand what you're asking.

So to remove ambiguity, we create new simplified languages without any filler words that *can't* be interpreted in multiple different ways. They don't sound as natural when you read them, but at least we can get computers to process them.

### What is a language?

Languages let us combine expressions into structures that create meanings. In spoken languages, we can string words into sentences that flow together fluently.

Programming languages are the same as any natural language. We have words, we have meanings, and we have rules for how to order the words.

And just like in natural languages, programming languages have different types of sentences to express different ideas. Programming stole a lot of these words from English grammar, so without going into enough detail to trigger an episode of PTSD from your grade school classes, a little background will go a long way.

### Declarative and Imperative

We have **declarative sentences**, which simply make a statement of how something is.

And we have **imperative sentences**, where we command the computer to do something.

Here is an example. Say someone was holding a list of groceries, and we wanted to know if the list had a certain food on it.

Here's the list:

  * Nutella
  * Frozen Pizza
  * Ranch Dressing
  * Potato Chips (ruffled)

Using a *declarative* English question, we might ask,

Does the list contain "Chips Ahoy Cookies"?
{: .quote}

Not so bad. We're just *declaring* what we want to know.

Now what about if we had to use imperative sentences?

Say the person who has the list is a complete idiot. Instead of just asking them if something is in the list, you have to tell them how to look. You might say something like,

Look in the list to see if it contains "Chips Ahoy Cookies" and tell me yes or no.
{: .quote}

But you won't get an answer, because you forgot to explain how to look in the list.

Fine... go through the items in the list one by one and tell me if any of them are "Chips Ahoy Cookies".
{: .quote}

Oops! You're making progress, but you forgot to say when to stop, so you still never get your answer!

Okay, go through the items in the list one by one and if any of them are "Chips Ahoy Cookies", stop looking and tell me "Yes". Otherwise, if you get to the end of the list, stop looking and tell me "No".
{: .quote}

I don't know about you, but I'm sick of this already and we haven't even gotten to coding. And for many years, this was the only way to program. Fortunately, there are better ways to do things now.

### What this means for our code

If our goal is to be productive coders, we should strive to write code that's *declarative* instead of *imperative* whenever we can. Tell the computer what you want, instead of how to do its job. Real coding is always a mix of the two styles, because there's not always a declarative way to get what you're looking for. But programming languages tend to lean one way or another, either more imperative or more declarative. Elm leans heavily toward declarative.

Just to drive the point home, here is how we would implement the procedure we just walked through in Elm.

{% highlight haskell %}
shoppingList = [ "Nutella", "Frozen Pizza", "Ranch Dressing", "Potato Chips (ruffled)" ]
cookies = "Chips Ahoy Cookies"

answer = List.member cookies shoppingList
{% endhighlight %}

And here's the translation into old-school Javascript, a largely imperative language.

{% highlight js %}
var list = ["Nutella", "Frozen Pizza", "Ranch Dressing", "Potato Chips (ruffled)"];
var cookies = "Chips Ahoy Cookies";
var search = function(list, item) {
  for (var i = 0; i < list.length; i++) {
    if (list[i]===item) {
      return true;
    }
  }
  return false;
}

var answer = search(list, cookies);
{% endhighlight %}

### How to read

Computers read top-down, left-to-right just like us. Imagine you are a 5 year old just learning how to read. You don't know a lot of words, but you know some words. You can use the words you already know to help you learn more words.

You've just opened up a new book, and you read this sentence:

Not for the first time, an `argument`{:.quote-text} had broken out over `breakfast`{:.quote-text .red} at number four, Privet `Drive`{:.quote-text .red}.
{: .quote}

You understand the first few words and know what's going on until you get to a word you haven't seen before: **argument**.

### Building our vocabulary

You look up "argument" in the dictionary, and you see the definition "an exchange of opposite views." Since an expression can be replaced by its definition, you substitute those words into the sentence to make it easier for you to understand:

Not for the first time, an `exchange`{:.quote-text .red}` of `{:.quote-text .blue}`opposite`{:.quote-text .red}` views`{:.quote-text .blue} had broken out over `breakfast`{:.quote-text .red} at number four, Privet `Drive`{:.quote-text .red}.
{: .quote}

But you don't know what **exchange** or **opposite** mean, so you still can't understand the sentence.

You've got great discipline, so you decide to look up the definitions of each of those two words and substitute them into the sentence.

After substituting the definitions for **exchange** and **opposite** into the sentence, you end up with:

Not for the first time, an `act of giving and receiving two things having completely different views`{:.quote-text .blue} had broken out over `breakfast`{:.quote-text .red} at number four, Privet `Drive`{:.quote-text .red}.
{: .quote}

That's better, but the rest of the sentence still has some words you don't understand. So you go through the whole sentence and replace each expression or word with its definition until you get down to a sentence that has only words that you understand.

### The final sentence

After substituting the definition for every word you don't know, you end up with a sentence you can completely understand:

Not for the first time, an `act of giving and receiving two things having completely different views`{:.quote-text .blue} had broken out over `the first meal of the day`{:.quote-text .blue} at number four, Privet `Carry Along with Physical Strength`{:.quote-text .blue}.
{: .quote}

Okay, I don't think that whole process made it much easier to read either.

But a computer does. And that's how computers work. A hardware developer starts a computer off with a small set of words it understands and can perform, actions like addition, or storing and looking up definitions of words.

We as coders teach computers new words using the small set of words the computer already knows. That way, we can write using language that we understand, rather than only using commands that the computer starts off knowing.

Computers look up and replace these new words with their definitions until they get down to basic operations they know how to perform. This process is called **evaluating expressions**. Evaluating an expression just means replacing an expression with a definition to create a **value**, which is simply another expression that we consider the "final answer." That is, it's simplified enough for the computer to work with.

In our case, the person who wrote the Elm language takes care of converting our code into "computer-readable" values. As long as we follow the rules of Elm, we can create expressions in our program that will get translated down into the words the computer is born knowing - we don't have to use those words directly.

![compiling](images/compiling.png)
*Elm compiles to Javascript which your browser then compiles to "machine code"*

This is great, because it means learning to program is more like learning a language than it is like learning a science. It's just a language that tells a computer what to do. Once you learn the most common words, you can get your point across, even if you sound a little bit awkward.

<!-- ### Optional Note:

This section hints at a very deep concept that sits at the heart of computer science. But we're not hinting anymore. The idea is that we as authors must choose the way we word our code. If we want, we can code at the level of the machine and explicitly write out every instruction for the computer to perform. This is called **low level** programming. The benefit of coding in this way is that our programs will run faster because they are doing *exactly* what we want - no more, no less. The downsides of coding at this level are that it takes longer to write, and it's easy to get lost in the machine instructions and lose sight of the higher level problems that we're trying to solve. Read the final version of the "translated" sentence above and compare it to the original version written by JK Rowling. Which is easier to understand?

On the opposite end of the spectrum, we can write code at a **high level**, explaining the ideas that we want the computer to perform and letting the people who wrote the programming language decide how to execute the tasks. The benefit is that it's faster to develop this way, because we focus on the problems we're trying to solve and not on telling the computer how to do its job. It's also easier to learn to program this way, because we can rely on the techniques developed by computer scientists in the last hundred years and not have to recode everything ourselves. What's more, with modern advances in computer hardware, the speed difference between low and high level languages is irrelevant outside specific applications where you're running *billions* or *trillions* of operations.

One of the most valuable skills of a coder is being able to work at the right level of **abstraction**, meaning choosing between using high level concepts or low level instructions. A specific problem might be easy to solve at a high level, or it might be impossible.

There are examples of programming languages on every part of the abstraction scale. Low level languages include Machine Languages and Assembly Code. High level languages include Elm, Haskell, Ruby, and Python. And somewhere in between are languages like C, Javascript, and Java. -->
