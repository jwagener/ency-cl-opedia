RWP.registerPlugin "Remove navboxes", ->
  RWP.bind "articleLoaded", ->
    $(".navbox").remove()
