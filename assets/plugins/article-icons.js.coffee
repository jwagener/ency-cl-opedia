RWP.bind "articleLoaded", ->
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