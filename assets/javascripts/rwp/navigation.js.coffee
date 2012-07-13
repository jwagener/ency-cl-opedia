RWP.Navigation = 
  scrollTo: (position) ->
    $.scrollTo position, 100, {offset: -50}

  navigateTo: (url, updateHistory = true) ->
    @showNavigating()
    stateObj = {url: url}
    title = (s = url.split("/"); s[s.length - 1]).replace("_", " ")
    history.pushState(stateObj, title, url) if updateHistory
    $("title").text(title)
    $.ajax
      dataType: "xml"
      url: url
      success: (doc) ->
        newContent = $("#content", doc)
        $("#content").replaceWith(newContent)
        RWP.processArticle()

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
      className: 'rwp-spinner'
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
  $(window).on "popstate", (e) ->
    state = e.originalEvent.state
    if state? && state.url?
      RWP.Navigation.navigateTo(state.url, false)

  $(window).on "hashchange", (e) ->
    RWP.Navigation.scrollTo window.location.hash

  $("a").live "click", (e) ->
    url = $(this).prop("href")
    if RWP.Navigation.isAjaxLoadable(url)
      e.preventDefault()
      RWP.Navigation.navigateTo url
