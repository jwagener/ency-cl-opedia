# Ency.cl/opedia

## What?

Ency.cl/opedia is an experiment to improve the Wikipedia reading experience.
It's focus is on a clutter free, simple design and features that improve exploration and curation.

This includes map and image overlays, sharing to social networks and some more small details.
And it is just a start, because the best thing is that it's open-source and easily extendable. So if you have your own ideas about how to improve the Wikipedia experience feel free to hack on the source code.

On my <a href="http://lolcat.biz/" target="_blank">blog</a> I wrote some more on my motiviation why I did this.

Enjoy discovering and sharing Wikipedia!

## Hacking

Start by cloning the repo and setting up the gems:

    $ git clone git@github.com:jwagener/ency-cl-opedia.git
    $ cd ency-cl-opedia
    $ bundle install
    $ thin start
    $ open "http://localhost:3000"

And you should be ready to hack.

Aside from some small backend in ency.rb that proxies the content from en.wikipedia.org
most of the magic happens client side and is managed in assets/javascripts.

If you want to extend the functionality the best way is to add a new plugin to assets/javascripts/plugin.

Good smaller examples are image-overlay.js.coffee and facebook.js.coffee.
Both of them just hook into the system by setting up event listeners for ready (when the page and app is initialized) and articleLoad (when a new article is loaded) using ENCY.bind "ready" and ENCY.bind "articleLoad".

Feel free to setup your own instances on the web or send pull-requests if you want features to be deployed on http://ency.cl/opedia.
