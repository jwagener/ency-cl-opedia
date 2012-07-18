html = '<div class="ency-onboarding">
    <a class="ency-overlay-close" href="#"><div class="ss-icon"></div></a>
    <h1>Welcome to Ency.cl/opedia!</h1>
    <p>
      Ency.cl/opedia is an experiment to improve the Wikipedia reading experience.
      It\'s focus is on a clutter free, simple design and features that improve exploration and curation.
    <p>
      This includes map and image overlays, sharing to social networks and some more small details.
      And it is just a start, because the best thing is that it\'s open-source and easily extendable. So if you have your own ideas about how to improve the Wikipedia experience feel free to hack on the <a href="https://github.com/jwagener/ency-cl-opedia" target="_blank">source code</a>.
      I wrote a bit more on my motivation behind this project on my <a href="http://lolcat.biz/" target="_blank">blog</a>.
    </p>
    <p>
      Give it a go and enjoy exploring and sharing Wikipedia!
    </p>
  </div>'

ENCY.bind "ready", ->
  if ENCY.getArticle().pageName == "opedia"
    $onboarding = $(html).prependTo("#content")
    $("#mp-topbanner").remove()
