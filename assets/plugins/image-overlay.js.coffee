RWP.bind "articleLoaded", (e) ->
  $("a.image").on "click", (e) ->
    overlay = new RWP.Overlay()
    imageUrl = $(this).find("img").attr("src")
    width = 500 # overlay.$e.width()
    scaledImageUrl = imageUrl.replace(/\/\d*px-/, "/#{width}px-")
    $image = $("<img src='#{imageUrl}' class='rwp-overlay-image' />").appendTo(overlay.$e)
    $scaledImage = $("<img src='#{scaledImageUrl}' class='rwp-overlay-image' />").hide().appendTo(overlay.$e).on "load", (e) ->
      $image.remove()
      $scaledImage.show()

    e.preventDefault()
    e.stopImmediatePropagation()
