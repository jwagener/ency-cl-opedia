setState = (activate=true)->
  if activate
    $(".rwp-share-facebook-activity").html("<span class='ss-social-icon'>facebook</span> Deactivate Facebook Activity Sharing")
  else
    $(".rwp-share-facebook-activity").html("<span class='ss-social-icon'>facebook</span> Activate Facebook Activity Sharing")

postRead = (delay) ->
  window.setTimeout (->
    url = window.location.toString()
    if RWP.isArticleUrl(url)
      article = RWP.getArticle()
      #FB.api "/me/#{app.namespace}:read", "post", {wikipedia_article: article.encyclUrl}, () ->
      FB.api "/me/news.reads", "post", {article: article.encyclUrl}, () ->
        true
  ), delay

app =
  id: 399696543407905
  namespace: "ency-cl-opedia"

RWP.bind "initialized", ->
  FB.init
    appId: app.id
    status: true
    cookie: true
    xfbml: false

  $(".rwp-share-facebook-activity").on "click", (e) ->
    e.preventDefault()
    FB.getLoginStatus (d) ->
      if d.status == "connected"
        FB.logout()
        setState(false)
        RWP.flashMessage("Facebook Activity Sharing is now off!")
      else
        FB.login ((d) ->
          if d.status == "connected"
            RWP.flashMessage("Facebook Activity Sharing is now on!")
            setState(true)
            postRead(0)
        ), {scope: "publish_actions"}

RWP.bind "articleLoaded", ->
  FB.getLoginStatus (d) ->
    if d.status == "connected"
      setState(true)
      postRead(10000)
