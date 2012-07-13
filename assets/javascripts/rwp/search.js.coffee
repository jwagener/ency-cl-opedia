RWP.Search = 
  getSuggestions:(term, callback) ->
    options =
      url: "http://en.wikipedia.org/w/api.php"
      data:
        format: "json"
        action: "opensearch"
        search: term
        namespace: 0
        suggest: ""
      success: (data) ->
        suggestions = data[1].slice(0, 5)
        callback(suggestions)
    options.dataType = "jsonp" unless RWP.isOnWikipedia()
    $.ajax options

$ ->
  $(".search").autocomplete
    appendTo: $(".search-box")
    create: (event, ui) ->
      $(".ui-autocomplete").addClass("dropdown-menu").width("248px");
    focus: (e) ->
      false
    source: (request, response) ->
      RWP.Search.getSuggestions(request.term, response)
    select: (event, ui) ->
      $(event.target).val("").blur()
      pageName = ui.item.value
      pagePath = encodeURIComponent(pageName)
      pagePath = pagePath.replace("%20", "_")
      RWP.navigateTo(pagePath)
      false
