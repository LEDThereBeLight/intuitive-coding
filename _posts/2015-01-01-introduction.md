---
layout: chapter
title: "Introduction"
subtitle: "Why coding is cool"
section: elm
---

<!-- I've always found it funny how the whole world is obsessed with wizards and magic but almost no one has any desire to try the magic that actually exists in the world.

I remember reading Harry Potter as a kid. I would think to myself, "if only we had magic in the real world - life would be so exciting! I'd do nothing but study magic and become the best wizard in the world."

Well, it turns out we do have magic. It's called coding, and it allows us to do things that would make Dumbledore jealous. We can create machines that clean our clothes or wake us up in the morning, and robots that drive around our living rooms and vacuum our floors.

Wizards in the movies dedicate years of their lives reading dusty old books that look like they're written in ancient, cryptic languages. And that's actually not a bad description for what it feels like watching someone program in [Haskell](https://www.haskell.org/).

But learning to program shouldn't be difficult. Anyone can be a coder - there are no muggles. All it takes is time to learn the language. -->

The trouble with the way most people teach coding is that they start with theory and use math for examples. But most of us don't have an intuitive understanding of math, which makes coding seem even *more* difficult. But the secret is that programming is more like a language than a science. It's a set of words for ideas, so if you can learn a language, you can learn to code.

The first language I tried to learn was C++, which looks something like this.

{% highlight c++ %}
quickSort(arr[], low, high)
{
  if (low < high)
  {
    pi = partition(arr, low, high);
    quickSort(arr, low, pi - 1);
    quickSort(arr, pi + 1, high);
  }
}
partition (arr[], low, high)
{
  pivot = arr[high];  
  i = (low - 1)
  for (j = low; j <= high- 1; j++)
  {
    if (arr[j] <= pivot)
    {
      i++;
      swap arr[i] and arr[j]
    }
  }
  swap arr[i + 1] and arr[high])
  return (i + 1)
}
{% endhighlight %}

This kind of code gives me anxiety just looking at it, and this is supposed to be a "simple" program. The good news is that we can make computers speak any language we want, so why use a language like that? C++ was invented in the 70s, and computers have come a long way in the last 40 years. We don't need to code the way we did back then.

So instead of conforming, we're going to take advantage of the advances of the last few years and start by learning a modern language called Elm. This language was designed to allow us to create modern applications in a fraction of the time of the more "traditional" languages. 

<!-- ### But I need to learn Javascript to get a job!

If you want to learn Javascript, or Python, or any other mainstream language, trust me when I tell you that starting with Elm to learn the underlying concepts will make your life easier. My goal is to get you to learn coding as quickly as possible, not to push any specific language on you. The concepts you will learn through Elm will *all* transfer over to the other languages. Besides, once you know how to code, you're realize the language *doesn't matter*. -->

Let's begin.
