---
layout: post
title: "Designing Programs"
subtitle: "How to think about coding"
section: app-building
---

### How to think about designing a program

When learning how to build apps, the smart approach is usually to build one step at a time. That means getting something simple to show up on the page, and then adding in functionality once you have something to show.

It's natural to feel a very strong temptation to plan everything out up front. I often feel like I need to come up with a grand architecture for a program where every piece fits together seamlessly and efficiently, or that I need to have an answer ready for every question someone might ask about my app.

But creative hobbies like coding rarely require such foresight. Think about how authors write books. Sure, there's usually an outline of the underlying story they want to tell and a picture of how things will come together in the end. But authors usually just start writing and see where the story takes them, rather than planning everything out ahead of time. The result is that writing feels natural and fun. The same is true of song writers - they play around with a few riffs that sound good together and build up a song around them.

You could even look at evolution as another example. There's no grand design that every animal is evolving towards. Mutations just kind of happen by chance and the ones that work out stick around. If we were to redesign humans from the ground up, there are lots of things we would do differently - why can't the spinal cord repair itself after an injury? But the truth is that there's no way of knowing ahead of time what is worth spending your time planning and developing. And if you try to design a perfect architecture for your program, you'll find that you waste a lot of time on things that are unimportant or never get used.

Some planning can be a good thing. As you gain experience, you start to get a feel for what areas are worth thinking through and what paths are a waste of time. But without building lots of programs, there's no way to know ahead of time what is or is not worth thinking about. So until you get that experience it's simpler and more fun to just *build*, and see where the program takes you. Don't worry about making every line of your code as efficient as possible, worry about making something that works and then go back to improve the areas that become problems.

### Getting set up

Let's learn how to build something. [Our app](/giffetch.html) is going to have a few main features. It:

  * Lets you enter a phrase for a certain category of GIFs
  * Searches the internet for a GIF in that category
  * Gets the image's location and displays it on the page

It's a simple app on the surface, but we'll need to use some pretty cutting-edge concepts to bring everything together and make it work without any page reloading or extra BS. Building this app will teach us some of the most important coding skills and will allow us to move up to either building more complex applications or moving into other interesting areas like data science or AI.

### How to start

We can start with either the display of the page or with its functionality. I'm a visual person, and I like being able to see what I'm working on. So we're going to start with the layout, rather than functionality that is more difficult to visualize.

Let's get an image and show it on the page. We'll be using the online code editor at [elm-lang.org/try](http://www.elm-lang.org/try) to keep the startup costs low and not to have to install anything yet. You can follow along by opening the online editor in another tab.
