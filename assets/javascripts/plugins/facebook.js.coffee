ENCY.FacebookActivitySharing =
  actionName: "ency-cl-opedia:study"
  app:
    id: 399696543407905
    namespace: "ency-cl-opedia"

  isWorthSharing: (article) ->
    s = article.pageName
    !s.match(/Portal\:/) && !s.match(/File\:/) && !s.match(/Special\:/) && !s.match(/Main_Page/) && !s.match(/Wikipedia\:/) && s != "opedia"

  setState: (activate=true) ->
    if activate
      $(".ency-share-facebook-activity").html("<span class='ss-social-icon'>facebook</span> Deactivate Facebook Activity Sharing")
    else
      $(".ency-share-facebook-activity").html("<span class='ss-social-icon'>facebook</span> Activate Facebook Activity Sharing")

  postRead: (delay) ->
    window.setTimeout (->
      url = window.location.toString()
      article = ENCY.getArticle()
      if ENCY.FacebookActivitySharing.isWorthSharing(article)
        FB.api "/me/#{ENCY.FacebookActivitySharing.actionName}", "post", {wikipedia_article: article.encyclUrl}, () ->
          true
    ), delay

  init: ->
    FB.init
      appId: ENCY.FacebookActivitySharing.app.id
      status: true
      cookie: true
      xfbml: false
    $(".ency-share-facebook-activity").on "click", ENCY.FacebookActivitySharing.onStateToggle
    ENCY.bind "articleLoad", ENCY.FacebookActivitySharing.onArticleLoaded

  onStateToggle: (e) =>
    e.preventDefault()
    FB.getLoginStatus (d) ->
      if d.status == "connected"
        FB.logout()
        ENCY.FacebookActivitySharing.setState(false)
        ENCY.flashMessage("Facebook Activity Sharing is now off!")
      else
        FB.login ((d) ->
          if d.status == "connected"
            ENCY.flashMessage("Facebook Activity Sharing is now on!")
            ENCY.FacebookActivitySharing.setState(true)
            ENCY.FacebookActivitySharing.postRead(0)
        ), {scope: "publish_actions"}

  onArticleLoaded: (e) =>
    FB.getLoginStatus (d) ->
      if d.status == "connected"
        ENCY.FacebookActivitySharing.setState(true)
        ENCY.FacebookActivitySharing.postRead(10000)

ENCY.bind "ready", ENCY.FacebookActivitySharing.init
