---
layout: post
title: "Ready to deploy"
subtitle: "Putting our site on the internet"
section: app-building
comments: true
---

### Compiling

We've done all of our developing locally using `elm-reactor`, but it's time to put our app on the internet. Web browsers aren't able to read Elm code, so we'll need to compile our code into an HTML page that the browser will know what to do with.

Make sure you're in your project's directory in your terminal, and run this command.

{% highlight shell %}
$ elm-make Main.elm --output=index.html
# Success! Compiled 1 module.
# Successfully generated index.html
{% endhighlight %}

What we're doing is telling Elm to "make", or compile, our Main.elm file and output the compiled code into index.html, which is the standard name for a home page on the web.

### Pushing to Github

[Github](https://github.com/) makes it easy to publish sites. So what's Github? Github is kind of the social media site for coders. It acts as a portfolio for your work. If you're interested in ever getting a job as a developer, you'll need some way to demonstrate your coding abilities, and that often happens through your code on Github. Go ahead and make an account, and then you'll see how easy it is to post our site live on the internet.

Let's set up a new repository for our code. A **repository** is just kind of a formal name for a bucket that our code sits in. Github isn't related to Git, but they integrate well together. You can create a repository on the home page after signing in.

![new repository](images/github.png)

Name and create your repo.

![create repo](images/new-repository.png)

Then just follow the instructions to publish your code. We already have an *existing repository* since we've been Using Git for our project, so you can simply copy and paste the instructions from that section.

![existing repo](images/existing-repository.png)

{% highlight shell %}
$ git remote add origin https://github.com/username/repo-name.git
$ git push -u origin master
# Counting objects
# Delta compression using up to 4 threads.
# Compressing objects: 100%, done.
# Writing objects: 100%, done.
# * [new branch]     master -> master
# Branch master set up to track remote branch master from origin.
{% endhighlight %}

Once your code is pushed, open up the repo's settings.

![settings](images/github-settings.png)

And set the GitHub Pages Source to the `master branch`.

![settings](images/github-pages-branch.png)

You can follow the link to see your page live!

![settings](images/github-pages-link.png)

That's all for this tutorial. If you managed to get through everything, well done. It was a lot of work to publish a website with a couple simple features, but the good news is that all projects follow the same structure, so you've gotten through the hard part. Please leave a comment, I'd love to hear your thoughts!
