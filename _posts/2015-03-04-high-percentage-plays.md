---
layout: problem
title: "Python"
section: solving-problems
comments: true
---

### High percentage plays

#### The most common functions

There is always more than one way to solve a problem. In programming languages, just like in natural languages, some words are more valuable to know than others. 

### The problem

How could we use negative indexes to write a function that creates a new, reversed String from an existing String?

<button class="hints">Hint</button>
<ul class="hintsBlock"></ul>

<textarea style="border-radius: 10px" id="code" name="code">
def reverse(string):
  return string # use List slicing

print reverse("Yo what's up")
</textarea>


<script>
let hints = [
  "We want to use List slicing, which looks like 'A string'[start:end:step]",
  "We need the whole string, so we don't need to mess with the start or end indices",
  "Using a negative step size will start from the end of the String",
  "string[::-1] will give back the string in reverse"
]
let hintsButton = document.querySelector("button.hints")
let hintsBlock = document.querySelector(".hintsBlock")
let i = 0
hintsButton.onclick = function() {
  if (i >= hints.length) return
  let element = document.createElement("li")
  element.innerHTML = hints[i]
  hintsBlock.appendChild(element)
  i += 1
}
</script>
