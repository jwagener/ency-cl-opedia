setStateOn = ->
  $(".facebook-activity-sharing-state").text("(on)")

postRead = ->
  url = window.location.toString()
  if RWP.isArticleUrl(url)
    article = RWP.getArticle()
    FB.api "/me/#{app.namespace}:reads", "post", {article: article.encycl_url}, () ->
      console.log("posted to fb", arguments)

apps =
  "ency.cl": 
    id: 298824063549766
    namespace: "news" # "ency-cl-opedia"
  "en.wikipedia.org":
    id: 399696543407905
    namespace: "rewikipedia"
  "ency.dev":
    id: 344661862278618
    namespace: "news" #"encydev"

app = apps[window.location.hostname]

RWP.bind "initialized", ->
  FB.init
    appId: app.id
    status: true
    cookie: true
    xfbml: false

  console.log $(".enable-facebook-activity-sharing")
  $(".enable-facebook-activity-sharing").on "click", (e) ->
    console.log(e)
    e.preventDefault()
    FB.login ((d) ->
      if d.status == "connected"
        setStateOn()
        postRead()

    ), {scope: "publish_actions"}

RWP.bind "articleLoaded", ->
  FB.getLoginStatus (d) ->
    if d.status == "connected"
      setStateOn()
      postRead()
