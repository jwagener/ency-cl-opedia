ENCY.Share = 
  setShareDropdownContent: ->
    article = ENCY.getArticle()
    text = "Just read #{article.title}"
    facebook = '<iframe allowtransparency="true" frameborder="0" scrolling="no" src="//www.facebook.com/plugins/like.php?send=false&amp;layout=button_count&amp;width=52&amp;show_faces=false&amp;action=like&amp;colorscheme=light&amp;font&amp;height=21&amp;appId=399696543407905&amp;href=URL"></iframe>'
    twitter = '<iframe allowtransparency="true" frameborder="0" scrolling="no" src="http://platform.twitter.com/widgets/tweet_button.1333103182.html#_=1333217261599&amp;count=none&amp;id=twitter-widget-0&amp;lang=en&amp;original_referer=URL&amp;size=m&amp;text=TEXT&amp;url=URL&amp;related=johanneswagener" class="twitter-share-button twitter-count-horizontal" title="Twitter Tweet Button"></iframe>';
    facebook = facebook.replace(/URL/g, encodeURIComponent(article.encyclUrl)).replace(/TEXT/g, encodeURIComponent(text))
    twitter = twitter.replace(/URL/g, encodeURIComponent(article.encyclUrl)).replace(/TEXT/g, encodeURIComponent(text))

    $(".ency-share-twitter, .ency-share-facebook").remove()
    $("<li class='ency-share-facebook'><a><span class='ss-social-icon'>facebook</span> Share to Facebook: #{facebook}</a></li>").appendTo(".dropdown-share")
    $("<li class='ency-share-twitter'><a><span class='ss-social-icon'>twitter</span> Share to Twitter: #{twitter}</a></li>").appendTo(".dropdown-share")


ENCY.bind "articleLoaded", ENCY.Share.setShareDropdownContent
