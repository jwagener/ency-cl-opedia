RWP.Overlay = (options={}) ->
  RWP.Overlay.removeAll()

  @$wrapper = $(".rwp-overlay-wrapper")
  if @$wrapper.length == 0
    @$wrapper = $("<div class='rwp-overlay-wrapper' />").appendTo("body")

  @$container = $("<div class='rwp-overlay' />")
  @$e = $("<div class='rwp-overlay-inner' />").appendTo(@$container)
  $("<a class='rwp-overlay-close ss-icon' href='#'>close</a>").appendTo(@$container).on 'click', (e) =>
    e.preventDefault()
    e.stopImmediatePropagation()
    @$container.remove()
  @$container.appendTo(@$wrapper)
  this

$(document).on "keyup", (e) ->
  if e.keyCode == 27
    RWP.Overlay.removeAll()

RWP.Overlay.removeAll = ->
  $(".rwp-overlay").remove()
