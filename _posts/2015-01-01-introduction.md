---
layout: chapter
title: "Introduction"
subtitle: "Why coding is cool"
section: elm
---

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

This kind of code gives me anxiety just looking at it, and this is supposed to be a "simple" program. Fortunately, we can make computers speak any language we want, so why use a language like that? C++ was invented in the 70s, and computers have come a long way in the last 40 years. We don't need to code the way we did back then.

So instead of conforming, we're going to take advantage of the advances of the last few years and start by learning a modern language called Elm. This language was designed to allow us to create modern applications in a fraction of the time of the more "traditional" languages.

Let's begin.
