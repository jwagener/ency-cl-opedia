RWP.registerPlugin "Image Overlay", ->
  RWP.bind "articleLoaded", (e) ->
    $("a.image").on "click", (e) ->
      overlay = new RWP.Overlay()
      imageUrl = $(this).find("img").attr("src")
      console.log(imageUrl)
      imageUrl = imageUrl.replace(/\/\d*px-/, "/#{overlay.$e.width()}px-")
      console.log(imageUrl)
      overlay.$e.css("background-image", "url(#{imageUrl})")
      e.preventDefault()
      e.stopImmediatePropagation()
