RWP.registerPlugin "Coordinates to Map", ->
  RWP.bind "articleLoaded", (e) ->
    geohackUrl = $("#coordinates a.external").attr("href");
    if geohackUrl
      match = geohackUrl.match(/(-?\d+\.\d+)_N_(-?\d+\.\d+)_E/)
      lat = match[1]
      lng = match[2]

      $("#coordinates").remove()
      RWP.addArticleIcon $("<a href='#{geohackUrl}' class='ss-icon' title='Open Map'>location</a>").on "click", (e) ->
        e.preventDefault()

        overlay = new RWP.Overlay()
        overlay.$e.css
          height: "400px"

        map = new L.Map(overlay.$e[0])
        cloudmade = new L.TileLayer('http://{s}.tile.cloudmade.com/999551f2992c4486ad66b907b3a1e0ce/997/256/{z}/{x}/{y}.png', {
          attribution: 'Map data &copy; <a href="http://openstreetmap.org">OpenStreetMap</a> contributors, <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a>, Imagery © <a href="http://cloudmade.com">CloudMade</a>',
          maxZoom: 18
        })

        map.addLayer(cloudmade).setView(new L.LatLng(lat, lng), 7)
        marker = new L.Marker(new L.LatLng(lat, lng))
        map.addLayer(marker);
