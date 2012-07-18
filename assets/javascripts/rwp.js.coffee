//= require_tree ./vendor
//= require_self
//= require_tree ./rwp
//= require_tree ../plugins

window.RWP =
  isArticleUrl: (url) ->
    if url.match /en\.wikipedia\.org\/wiki\//
      true
    else if url.match /\/\/ency/
      true
    else
      false

  bind: (name, fn) ->
    $(document).bind(name, fn)

  trigger: (name, options) ->
    $(document).trigger(name, options)

  flashMessage: (text) ->
    $flash = $(".rwp-flash-message")
    $flash.text(text).addClass("visible")
    setTimeout (->
      $flash.removeClass("visible")
    ), 3000

  extractTitleFromUrl: (url) ->
    title = (s = url.split("/"); s[s.length - 1]).replace(/_/g, " ")
    decodeURIComponent(title)

  navigateTo: (url) ->
    RWP.Navigation.navigateTo(url)

  isOnWikipedia: ->
    window.location.hostname == "en.wikipedia.org"

  getArticle: ->
    slug = (p = window.location.pathname.split("/"); p[p.length - 1])
    {
      title: $("h1 span").text()
      pageName: slug
      encyclUrl: "http://ency.cl/#{slug}"
    }


RWP.addArticleIcon = ($e) ->
  $rwpIcons = $(".rwp-icons")
  if $rwpIcons.length == 0
    $rwpIcons = $("<div class='rwp-icons' />").appendTo(".firstHeading")
  $e.appendTo $rwpIcons

RWP.processArticle = ->
  RWP.trigger "articleLoaded"
  $(".toc-menu").html('')
  $toc = $(".toc td > ul").detach()
  $toc.addClass("dropdown-menu ui-menu dropdown-toc")
  $(".dropdown-toggle-toc").toggle $toc.find("li").length > 0
  $toc.replaceAll(".dropdown-toc")

  $rwpIcons = $("<div class='rwp-icons' />").appendTo(".firstHeading")

  $ambox = $(".ambox")
  if $ambox.length > 0
    $('<a class="ss-icon rwp-icon-warning" href="#" title="Show Warnings">warning</a>').appendTo($rwpIcons).on "click", (e) ->
      e.preventDefault()
      $ambox.toggle()
    $ambox.hide()

  RWP.addArticleIcon $("#protected-icon a").addClass("ss-icon").text("lock")
  RWP.addArticleIcon $("#spoken-icon a").addClass("ss-icon").text("volumehigh")
  RWP.addArticleIcon $("#featured-star a").addClass("ss-icon").text("star")
  $("#good-star a").hide()

  RWP.setEditLink()
  RWP.Navigation.scrollTo(window.location.hash)

RWP.setEditLink = ->
  article = RWP.getArticle()
  $(".btn-edit").attr("href", "http://en.wikipedia.org/w/index.php?title=#{article.pageName}&action=edit")

$ ->
  RWP.trigger("initialized")
  RWP.processArticle()

  $(".dropdown-toggle").bind "click", (e) ->
    e.preventDefault()
    e.stopImmediatePropagation()
    $dropdown = $($(this).attr('data-dropdown'))
    $dropdown.css "max-height", $(window).height() - 50
    $(".dropdown-menu").not($dropdown).removeClass("open")
    if $dropdown.hasClass("open")
      $dropdown.removeClass("open")
    else
      $dropdown.addClass("open").css("left", $(this).position().left - $dropdown.width() + 45)

