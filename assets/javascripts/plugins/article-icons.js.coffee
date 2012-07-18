ENCY.bind "articleLoaded", ->
  $rwpIcons = $("<div class='ency-icons' />").appendTo(".firstHeading")

  $ambox = $(".ambox")
  if $ambox.length > 0
    $('<a class="ss-icon ency-icon-warning" href="#" title="Show Warnings">warning</a>').appendTo($rwpIcons).on "click", (e) ->
      e.preventDefault()
      $ambox.toggle()
    $ambox.hide()

  ENCY.addArticleIcon $("#protected-icon a").addClass("ss-icon").text("lock")
  ENCY.addArticleIcon $("#spoken-icon a").addClass("ss-icon").text("volumehigh")
  ENCY.addArticleIcon $("#featured-star a").addClass("ss-icon").text("star")
  $("#good-star a").hide()