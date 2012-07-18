RWP.FacebookActivitySharing =
  app:
    id: 399696543407905
    namespace: "ency-cl-opedia"

  isWorthSharing: (article) ->
    s = article.pageName
    !s.match(/Portal\:/) && !s.match(/File\:/) && !s.match(/Special\:/) && !s.match(/Main_Page/) && !s.match(/Wikipedia\:/)

  setState: (activate=true) ->
    if activate
      $(".rwp-share-facebook-activity").html("<span class='ss-social-icon'>facebook</span> Deactivate Facebook Activity Sharing")
    else
      $(".rwp-share-facebook-activity").html("<span class='ss-social-icon'>facebook</span> Activate Facebook Activity Sharing")

  postRead: (delay) ->
    window.setTimeout (->
      url = window.location.toString()
      article = RWP.getArticle()
      if RWP.FacebookActivitySharing.isWorthSharing(article)
        #FB.api "/me/#{app.namespace}:read", "post", {wikipedia_article: article.encyclUrl}, () ->
        FB.api "/me/news.reads", "post", {article: article.encyclUrl}, () ->
          true
    ), delay

  init: ->
    FB.init
      appId: RWP.FacebookActivitySharing.app.id
      status: true
      cookie: true
      xfbml: false
    $(".rwp-share-facebook-activity").on "click", RWP.FacebookActivitySharing.onStateToggle
    RWP.bind "articleLoaded", RWP.FacebookActivitySharing.onArticleLoaded

  onStateToggle: (e) =>
    e.preventDefault()
    FB.getLoginStatus (d) ->
      if d.status == "connected"
        FB.logout()
        RWP.FacebookActivitySharing.setState(false)
        RWP.flashMessage("Facebook Activity Sharing is now off!")
      else
        FB.login ((d) ->
          if d.status == "connected"
            RWP.flashMessage("Facebook Activity Sharing is now on!")
            RWP.FacebookActivitySharing.setState(true)
            RWP.FacebookActivitySharing.postRead(0)
        ), {scope: "publish_actions"}

  onArticleLoaded: (e) =>
    FB.getLoginStatus (d) ->
      if d.status == "connected"
        RWP.FacebookActivitySharing.setState(true)
        RWP.FacebookActivitySharing.postRead(10000)

RWP.bind "initialized", RWP.FacebookActivitySharing.init
