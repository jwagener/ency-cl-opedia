html = '<div class="ency-onboarding">
    <a class="ency-overlay-close" href="#"><div class="ss-icon"></div></a>
    <h1>Welcome to Ency.cl/opedia!</h1>
    <p>
      Ency.cl/opedia is an expiriment to have a fresh take on the Wikipedia reading experience.
      It\'s focus is on a simple design and features that improve exploration and curation, for example better maps &amp; media integration and sharing to your social networks.
    </p>
    <p>
      This is just a start, but the best thing is that it is open-source and easily extendable. So if you have your own ideas about how to improve it feel free to hack on the source code.
    </p>
    <p>
      Enjoy discovering and sharing Wikipedia!
    </p>
  </div>'

ENCY.bind "initialized", ->
  if ENCY.getArticle().pageName == "opedia"
    $onboarding = $(html).prependTo("#content")
    $("#mp-topbanner").remove()
