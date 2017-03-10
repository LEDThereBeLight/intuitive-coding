---
layout: post
title: "The land of acronyms"
subtitle: "Moving around in the terminal"
section: app-building
comments: true
---

### Working with directories

Let's open up a terminal and make a new folder for our project. We usually call them **directories** instead of folders.

We can see what directory the terminal current has open using the `pwd` command, which stands for **present working directory**. The `$` symbol is the prompt where we enter commands.

{% highlight shell %}
$ pwd
# /Users/zblue
{% endhighlight %}

We can **make a new directory** by running the `mkdir` command and giving it a folder name as an input.

{% highlight shell %}
$ mkdir giffetch
{% endhighlight %}

Now if we **list** all of the contents of the current directory with `ls`, we'll see our new folder.

{% highlight shell %}
$ ls
# giffetch
# other files and folders
{% endhighlight %}

We can **change** into the **directory** with `cd`.

{% highlight shell %}
$ cd giffetch
{% endhighlight %}

Now we can run `pwd` again, which should show us in our app's directory.

{% highlight shell %}
$ pwd
# /Users/zblue/giffetch
{% endhighlight %}

Finally, let's actually make the file we're going to write our program in. We'll call our file **Main** to follow Elm convention, and give it the **.elm** filetype.

{% highlight shell %}
$ touch Main.elm
{% endhighlight %}

If we run `ls`, we should see our new file.

{% highlight shell %}
$ ls
# Main.elm
{% endhighlight %}

If you're using Atom, you can open the file with `atom .`, which is a shortcut for opening the current directory. Otherwise, open the file Main.elm in your text editor.

{% highlight shell %}
$ atom .
{% endhighlight %}

### Starting our program

We'll start this program the way we start every Elm program, by creating a module with the same name as the filename `Main`, importing the Html module, and defining the `main` function. We'll get to what all of this means soon, so hang tight - it shouldn't be clear yet.

{% highlight haskell %}
-- name our project Main using the module keyword and expose everything for other files to use
module Main exposing (..)

-- import the Html module
import Html

-- the actual running code of our program
main = Html.text "hi there"
{% endhighlight %}

That's all we need to create a very simple webpage. We can run our program by running the `elm-reactor` in the terminal, which is a program that we added when we installed the Elm language. The elm-reactor compiles and **serves** our site so that we can preview it on our computer.

{% highlight shell %}
$ elm-reactor
# elm-reactor 0.18.0
# Listening on http://localhost:8000
{% endhighlight %}

Now our terminal program will continuously run the elm-reactor program until we stop it, which we can do by pressing **Ctrl + c** on the keyboard.

{% highlight shell %}
# Terminate batch job (Y/N)?
$ y
{% endhighlight %}

**Ctrl + c** is good to know because it's basically our "get me the hell out of here" button. It forces any program running in the terminal to end. But we do actually want to run the elm-reactor to start our project, so let's start it again.

{% highlight shell %}
$ elm-reactor
# elm-reactor 0.18.0
# Listening on http://localhost:8000
{% endhighlight %}

We can follow the link in a web browser and then click on our project to view our page.

![the project menu](/images/elm-reactor.png/)
*the Elm project menu*

![yep, it works](/images/hi-there.png/)

If you get an error, it's likely because you're on a Windows PC. If that's the case, you should download <a href="https://youtu.be/TjxEH_tr7e0?t=2m36s" target="_blank">Cygwin</a>, which will allow you to work in a Mac-like environment. After installing the program, **run Cygwin as an Administrator** and elm-reactor should work.
{: .info}

Make sure your page works, and then we'll use Git to save our changes. If you've never used Git before, the <a href="https://blog.marvelapp.com/designers-guide-git/" target="_blank">Marvel App blog</a> has a great introduction.

First, designate our current directory as a **Git repository** where we're going to keep track of changes with `git init`.

{% highlight shell %}
$ git init
# Initialized empty Git repository in /Users/zblue/giffetch
{% endhighlight %}

Next, **add** all of the files in this folder to be tracked for changes with `git add`. Here we're using the `-a` **flag**, which is a shortcut for adding "all" files in the current directory.

{% highlight shell %}
$ git add -A
{% endhighlight %}

Now **commit your files**. This is effectively saving a snapshot of your work at this point in time. We can add a message to our commit for when we come back to it later with the `-m` flag. We typically write commit messages in present tense. If everything goes well, we'll get a warm reply in the terminal.

{% highlight shell %}
$ git commit -m "Initial commit. Add Main.elm"
# [master (root-commit) b21a300] Initial commit. Add Main.elm
# 1 file changed, 71 insertions(+)
create mode 100644 Main.elm
{% endhighlight %}

*[$]: A line of input a user enters into the terminal
*[#]: The message the terminal returns
