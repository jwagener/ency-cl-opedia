ENCY.Overlay = (options={}) ->
  ENCY.Overlay.removeAll()

  @$wrapper = $(".ency-overlay-wrapper")
  if @$wrapper.length == 0
    @$wrapper = $("<div class='ency-overlay-wrapper' />").appendTo("body")

  @$container = $("<div class='ency-overlay' />")
  @$e = $("<div class='ency-overlay-inner' />").appendTo(@$container)
  $("<a class='ency-overlay-close ss-icon' href='#'>close</a>").appendTo(@$container).on 'click', (e) =>
    e.preventDefault()
    e.stopImmediatePropagation()
    @$container.remove()
  @$container.appendTo(@$wrapper)
  this

$(document).on "keyup", (e) ->
  if e.keyCode == 27
    ENCY.Overlay.removeAll()

ENCY.Overlay.removeAll = ->
  $(".ency-overlay").remove()
