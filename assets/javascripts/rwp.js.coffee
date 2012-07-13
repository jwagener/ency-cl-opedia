//= require_tree ./vendor
//= require_self
//= require_tree ./rwp

window.RWP =
  plugins: {}
  registerPlugin: (name, fn) ->
    RWP.plugins[name] = fn
    RWP.plugins[name]()

  bind: (name, fn) ->
    $("body").bind(name, fn)

  trigger: (name, options) ->
    $("body").trigger(name, options)

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

RWP.processArticle = ->
  RWP.trigger "articleLoaded"
  $(".toc-menu").html('')
  $toc = $(".toc td > ul").detach()
  $toc.addClass("dropdown-menu ui-menu dropdown-toc")
  $toc.insertAfter(".dropdown-toggle-toc")

  $('<div class="rwp-flash ss-icon">warning<div class="rwp-flash-messages" /></div>').appendTo(".firstHeading")
  $(".ambox").appendTo(".rwp-flash-messages")
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
    $dropdown.toggleClass("open").css("left", $(this).position().left - $dropdown.width() + 20)

  $(document).on "mouseup", (e) ->
    unless $(e.target).hasClass("dropdown-toggle")
      $(".dropdown-menu").removeClass("open")

document.write("<link rel='stylesheet' href='http://localhost:3000/assets/wikipedia.css' />)")
