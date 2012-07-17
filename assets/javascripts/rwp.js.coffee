//= require_tree ./vendor
//= require_self
//= require_tree ./rwp
//= require_tree ../plugins

window.RWP =
  plugins: {}
  registerPlugin: (name, fn) ->
    RWP.plugins[name] = fn
    RWP.plugins[name]()

  bind: (name, fn) ->
    $(document).bind(name, fn)

  trigger: (name, options) ->
    $(document).trigger(name, options)

  navigateTo: (url) ->
    RWP.Navigation.navigateTo(url)

  isOnWikipedia: ->
    window.location.hostname == "en.wikipedia.org"

  getArticle: ->
    {
      title: $(".firstHeading").text().replace(/^\s+|\s+$/g, '')
      slug: (p = window.location.pathname.split("/"); p[p.length - 1])
    }

  hijackPage: ->
    $(RWP.Templates.header).prependTo("body");
    $('<meta name="viewport" content="width=640, initial-scale=1">').appendTo("head");

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

  RWP.setEditLink()

RWP.setEditLink = ->
  uri = new URI(window.location, decodeQuery: true)
  uri.query.action = "edit"
  $(".btn-edit").attr("href", uri.toString())

$ ->
  RWP.hijackPage()
  RWP.processArticle()

  $(".dropdown-toggle").live "click", (e) ->
    e.preventDefault()
    e.stopImmediatePropagation()
    $dropdown = $($(this).attr('data-dropdown'))
    $(".dropdown-menu").not($dropdown).removeClass("open")
    $dropdown.toggleClass("open").css("left", $(this).position().left - $dropdown.width() + 45)

  $(document).on "mouseup", (e) ->
    unless $(e.target).hasClass("dropdown-toggle")
      $(".dropdown-menu").removeClass("open")

document.write("<link rel='stylesheet' href='http://ency.cl/assets/wikipedia.css' />)")
