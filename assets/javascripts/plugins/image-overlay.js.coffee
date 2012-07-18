ENCY.bind "articleLoaded", (e) ->
  $("a.image").on "click", (e) ->
    overlay = new ENCY.Overlay()
    imageUrl = $(this).find("img").attr("src")
    width = 500 # overlay.$e.width()
    scaledImageUrl = imageUrl.replace(/\/\d*px-/, "/#{width}px-")
    $image = $("<img src='#{imageUrl}' class='ency-overlay-image' />").appendTo(overlay.$e)
    $scaledImage = $("<img src='#{scaledImageUrl}' class='ency-overlay-image' />").hide().appendTo(overlay.$e).on "load", (e) ->
      $image.remove()
      $scaledImage.show()

    e.preventDefault()
    e.stopImmediatePropagation()
