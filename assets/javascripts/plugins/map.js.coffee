ENCY.Map =
  extractCoord: (reg, url) ->
    m = url.match(reg)
    return null unless m
    c = m[1]
    split = c.split("_")
    if split.length == 1
      c = parseFloat(c)
    else
      c = parseInt(split[0], 10) || 0
      c += (parseInt(split[1], 10) || 0) / 60
      c += (parseInt(split[2], 10) || 0) / 3600

    if m[2] == "S" || m[2] == "W"
      c = 0 - c
    return c

  latLngFromGeohack: (url) ->
    latReg = new RegExp(/(-?\d+[\._]?\d+_?\d*)_([NS])/)
    lngReg = new RegExp(/(-?\d+[\._]?\d+_?\d*)_([EW])/)
    lat = ENCY.Map.extractCoord(latReg, url)
    lng = ENCY.Map.extractCoord(lngReg, url)

    if lat && lng
      new L.LatLng(lat, lng)

ENCY.bind "articleLoaded", (e) ->
  geohackUrl = $("#coordinates a.external").attr("href");
  if geohackUrl && latLng = ENCY.Map.latLngFromGeohack(geohackUrl)
    $("#coordinates").remove()
    ENCY.addArticleIcon $("<a href='#{geohackUrl}' class='ss-icon' title='Open Map'>location</a>").on "click", (e) ->
      e.preventDefault()
      e.stopImmediatePropagation()

      overlay = new ENCY.Overlay()
      overlay.$e.css
        height: "400px"

      map = new L.Map(overlay.$e[0])
      bing = new L.TileLayer.Bing("Ag_G9YGvTnWtqqSsQ5S4s44ddrRS7GmC7WO94Vo-NoL_p1TiWdwsYcIDirB3_5q-", "AerialWithLabels");

      map.addLayer(bing).setView(latLng, 7)
      marker = new L.Marker(latLng)
      map.addLayer(marker);
