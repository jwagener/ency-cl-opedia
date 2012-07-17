setStateOn = ->
  $(".facebook-activity-sharing-state").text("(on)")

postRead = (delay) ->
  window.setTimeout (->
    url = window.location.toString()
    if RWP.isArticleUrl(url)
      article = RWP.getArticle()
      FB.api "/me/#{app.namespace}:read", "post", {article: article.encycl_url}, () ->
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

  $(".enable-facebook-activity-sharing").on "click", (e) ->
    e.preventDefault()
    FB.login ((d) ->
      if d.status == "connected"
        setStateOn()
        postRead(0)
    ), {scope: "publish_actions"}

RWP.bind "articleLoaded", ->
  FB.getLoginStatus (d) ->
    if d.status == "connected"
      setStateOn()
      postRead(0)
