jQuery(window).load(function() {
    setTimeout(function() {
     // Prefetch all files referenced in prefetch tags
     var $prefetchTags = jQuery('HEAD LINK[rel=prefetch][href]');

     // preload all prefetched image links
     $prefetchTags.filter('[href$=.jpg],[href$=.jpeg]')
     .each(function() {
             new Image().src = this.href;
     });
	 
     // preload all images with class=preload
	 var $preload = jQuery(".preload");
     $preload.each(function() {
            new Image().src = jQuery(this).html();
     });

    }, 0);
});
