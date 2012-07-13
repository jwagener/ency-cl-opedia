RWP.Share = 
  setShareDropdownContent: ->
    url = window.location.toString()
    text = RWP.getArticle().title
    html = "<span class='dropdown-title'>Share this Article:</span>";
    html += '<iframe allowtransparency="true" frameborder="0" scrolling="no" src="//www.facebook.com/plugins/like.php?send=false&amp;layout=button_count&amp;width=52&amp;show_faces=false&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21&amp;appId=399696543407905&amp;href=URL" class="facebook"></iframe>'
    html += '<iframe allowtransparency="true" frameborder="0" scrolling="no" src="http://platform.twitter.com/widgets/tweet_button.1333103182.html#_=1333217261599&amp;count=none&amp;id=twitter-widget-0&amp;lang=en&amp;original_referer=URL&amp;size=m&amp;text=TEXT&amp;url=URL&amp;related=johanneswagener" class="twitter-share-button twitter twitter-count-horizontal" title="Twitter Tweet Button"></iframe>';

    html = html.replace(/URL/g, encodeURIComponent(url));
    html = html.replace(/TEXT/g, encodeURIComponent(text));
    $(".dropdown-share").html(html);


$ ->
  $(".btn-share").on "click", RWP.Share.setShareDropdownContent
