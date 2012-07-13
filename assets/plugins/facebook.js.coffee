RWP.registerPlugin "Facebook Sharing", ->
  FB.init
    appId: '399696543407905'
    status: true
    cookie: true
    xfbml: false

  $(".enable-fb").on "click", (e) ->
    e.preventDefault()
    FB.login (->
    ), {scope: "publish_actions"}

  RWP.bind "articleLoaded", ->
    FB.getLoginStatus (d) ->
      if d.status == "connected"
        FB.api "/me/rewikipedia:read", "post", {article: "http://rewikipedia.herokuapp.com/" + RWP.getPageName()}, () ->
          1
