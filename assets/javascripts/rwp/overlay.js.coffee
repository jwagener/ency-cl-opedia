RWP.Overlay = (options={}) ->
  @$container = $("<div class='rwp-overlay' />")
  @$e = $("<div class='rwp-overlay-inner' />").appendTo(@$container)
  $("<a class='rwp-overlay-close ss-icon' href='#'>close</a>").appendTo(@$container).on 'click', (e) =>
    e.preventDefault()
    e.stopImmediatePropagation()
    @$container.remove()
  @$container.appendTo("body")
  this