html = '<div class="ency-onboarding">
    <a class="ency-overlay-close" href="#"><div class="ss-icon"></div></a>
    <h1>Welcome to Ency.cl/opedia!</h1>
    <p>
      Ency.cl/opedia is an expiriment to improve the Wikipedia reading experience.
    </p>
    <p>
      It\'s focus is on a simple design and features that improve exploration and curation, like a better maps &amp; media integration and sharing to your social networks.
    </p>
    <p>
      This is just a start, the best thing is that it\'s open-source and easily extendable. So if you have your own ideas about how to improve the Wikipedia experience feel free to hack on the <a href="https://github.com/jwagener/ency-cl-opedia" target="_blank">source code</a>.
      I wrote a bit more on my motivation behind this project on my <a href="http://lolcat.biz/" target="_blank">blog</a>.
    </p>
    <p>
      Enjoy discovering and sharing Wikipedia!
    </p>
  </div>'

ENCY.bind "ready", ->
  if ENCY.getArticle().pageName == "opedia"
    $onboarding = $(html).prependTo("#content")
    $("#mp-topbanner").remove()
