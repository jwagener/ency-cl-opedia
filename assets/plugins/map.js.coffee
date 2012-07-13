RWP.registerPlugin "Coordinates to Map", ->
  RWP.bind "articleLoaded", (e) ->
    geohackUrl = $("#coordinates a.external").attr("href");
    $("<a href='#{geohackUrl}' class='ss-icon'>location</a>").replaceAll("#coordinates").on "click", (e) ->
      overlay = new RWP.Overlay()
      overlay.$e.html("This should be a leaflet map for #{geohackUrl}")
      e.preventDefault();
