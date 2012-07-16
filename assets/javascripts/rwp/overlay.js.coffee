RWP.Overlay = (options={}) ->
  $(".rwp-overlay-wrapper").remove()

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