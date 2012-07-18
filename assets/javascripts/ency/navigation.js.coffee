ENCY.Navigation = 
  scrollTo: (position) ->
    if position == ""
      position = 0
    $.scrollTo position, 100, {offset: -50}

  navigateTo: (url, updateHistory = true) ->
    @showNavigating()
    stateObj = {url: url}
    title = ENCY.extractTitleFromUrl(url)
    title = "#{title} - Ency.cl/opedia"
    history.pushState(stateObj, title, url) if updateHistory
    $("title").text(title)
    $.ajax
      dataType: "html"
      url: url
      error: (xhr) ->
        $("#content").replaceWith("Failed to load :(")
      success: (doc) ->
        from = doc.indexOf("<!-- content -->")
        to = doc.indexOf("<!-- /content -->")
        content = doc.substring(from, to)
        $("#content").replaceWith(content)
        _gaq.push(['_trackPageview'])
        ENCY.processArticle()

  showNavigating: ->
    $content = $("#content")
    $content.html ""
    opts =
      lines: 11
      length: 7
      width: 3
      radius: 9
      rotate: 0
      color: '#000'
      speed: 1
      trail: 60
      shadow: false
      hwaccel: false
      className: 'ency-spinner'
      zIndex: 2e9
      top: 'auto'
      left: 'auto'
    spinner = new Spinner(opts).spin $content[0]


  # en.wikipedia.org/bla -> en.wikipedia.org/blub        true
  # en.wikipedia.org/bla -> google.com/foobar            false
  # en.wikipedia.org/bla -> en.wikipedia.org/bla#blub    false

  isAjaxLoadable: (url) ->
    currentUrl = new URI(window.location)
    newUrl = new URI(url)
    isLocal = newUrl.host == currentUrl.host
    currentUrl.fragment = newUrl.fragment = ""
    differentPage = newUrl.toString() != currentUrl.toString()
    isLocal && differentPage


$ ->
  history.replaceState({url: window.location.toString()}, document.title, window.location.toString())
  $(window).on "popstate", (e) ->
    state = e.originalEvent.state
    if state? && state.url?
      ENCY.Navigation.navigateTo(state.url, false)

  $(window).on "hashchange", (e) ->
    ENCY.Navigation.scrollTo window.location.hash

  $("a").live "click", (e) ->
    ENCY.Overlay.removeAll()
    $(".dropdown-menu").removeClass("open")
    url = $(this).prop("href")
    if url.match /index\.php/
      true
    else if ENCY.Navigation.isAjaxLoadable(url)
      e.preventDefault()
      ENCY.Navigation.navigateTo url
