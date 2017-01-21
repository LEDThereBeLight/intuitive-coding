---
layout: post
title: "Javascript"
subtitle: "The basics"
section: solving-problems
comments: true
---

### Making functions

Javascript has a few differences from Elm. To make a function in Javascript, we use `let`. We also put the inputs to the function on the right side of the `=` sign, before an "arrow" written as `=>`. That's because functions can be viewed as inputs flowing through funnels to produce outputs.

The inputs go in, the function does some magic, and the output comes out at the end.

<p data-height="100" data-theme-id="27358" data-slug-hash="ggmVJN" data-default-tab="js,result" data-user="intuitivecoding" data-embed-version="2" data-pen-title="Making variables" data-editable="true" class="codepen">See the Pen <a href="http://codepen.io/intuitivecoding/pen/ggmVJN/">Making variables</a> by zach (<a href="http://codepen.io/intuitivecoding">@intuitivecoding</a>) on <a href="http://codepen.io">CodePen</a>.</p>
<script async src="https://production-assets.codepen.io/assets/embed/ei.js"></script>

In this code, we're taking in `word` as an input and giving back `word.toUpperCase()` as an output, which capitalizes the word.

Don't worry about the `print` function. We'll get to it eventually, but it's not really important that you understand it now. We'll just be using it to display the results of our code.

The other thing to know is that in Javascript, we call functions by using parentheses `()`. And if a function needs some inputs, we can pass them inside the parentheses.
