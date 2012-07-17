RWP.Map =
  extractCoord: (reg, url) ->
    m = url.match(reg)
    return null unless m
    c = m[1]
    c = parseFloat(c.replace("_", ".").replace("_", ""))
    if m[2] == "S" || m[2] == "W"
      c = 0 - c
    return c
  latLngFromGeohack: (url) ->
    latReg = new RegExp(/(-?\d+[\._]?\d+_?\d*)_([NS])/)
    lngReg = new RegExp(/(-?\d+[\._]?\d+_?\d*)_([EW])/)
    lat = RWP.Map.extractCoord(latReg, url)
    lng = RWP.Map.extractCoord(lngReg, url)

    if lat && lng
      new L.LatLng(lat, lng)

RWP.bind "articleLoaded", (e) ->
  geohackUrl = $("#coordinates a.external").attr("href");
  if geohackUrl && latLng = RWP.Map.latLngFromGeohack(geohackUrl)
    $("#coordinates").remove()
    RWP.addArticleIcon $("<a href='#{geohackUrl}' class='ss-icon' title='Open Map'>location</a>").on "click", (e) ->
      e.preventDefault()

      overlay = new RWP.Overlay()
      overlay.$e.css
        height: "400px"

      map = new L.Map(overlay.$e[0])
      cloudmade = new L.TileLayer('http://{s}.tile.cloudmade.com/999551f2992c4486ad66b907b3a1e0ce/997/256/{z}/{x}/{y}.png', {
        attribution: '<a href="http://openstreetmap.org">OpenStreetMap</a> - <a href="http://creativecommons.org/licenses/by-sa/2.0/">CC-BY-SA</a> - <a href="http://cloudmade.com">CloudMade</a>',
        maxZoom: 18
      })

      map.addLayer(cloudmade).setView(latLng, 7)
      marker = new L.Marker(latLng)
      map.addLayer(marker);
