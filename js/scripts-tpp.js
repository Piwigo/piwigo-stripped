var showtabs;
var selectedTab;
var interfaceTimerDelay;
var isScrollable;
var zoomMode;

jQuery("document").ready(function(jQuery) {

	zoomMode=options.defaultZoomSize;

	// display alt from PWG stuffs actions

	var stuffs_actions=jQuery(".categoryActions",".stuffs_block .stuffs");
	
	if (stuffs_actions.length != 0) {
		stuffs_actions.each(function(index) {
			var images=jQuery(this).find("img");
			if (images.length !=0) {
				images.each(function(index) {
					var alt_text = (jQuery(this).attr("alt"));
					jQuery(this).before(alt_text);
					jQuery(this).parents("li").css("width","auto");
					jQuery(this).remove();
				});
			}
		});
	}
	
	// gmaps icon
	
	var icon_gmaps=jQuery("#icon_gmaps");
	var text_gmaps=jQuery("#text_gmaps");
	if ((icon_gmaps.length == 1) && (text_gmaps.length ==1)) {
		icon_gmaps.text(text_gmaps.text());
		icon_gmaps.css("text-align","right");
		icon_gmaps.wrapAll('<li>');
	}
	
	// Tabs

	var tab_loaded=0;
	var delay=400;
	var hfirst;
	//if (jQuery.browser.msie) {hfirst=false;} else {hfirst=true;}
	hfirst=true;
	var tab_titles=jQuery(".tabTitle");
	var tab_blocks=jQuery(".tabBlock");
	var tab_name;
	var tab_start = null;
	
	if ( (options.defaultTab) && (options.themeStyle == "original") ) {
		if (options.defaultTab != "none") tab_start = options.defaultTab;
		if (options.defaultTab == "last") tab_start = jQuery.cookie("tabactive");
	}

	if ((tab_titles.length != 0) && (tab_titles.length == tab_blocks.length)) {

		if (tab_start != null) {
			tab_blocks.each(function(index) {
				jQuery(this).css("display","none");
			});
			tab_loaded=1;
			jQuery("#tabs").css("height","auto");
	
			tab_titles.each(function(index1) {
				tab_name = jQuery(this).attr("name");
				if (tab_name == tab_start) {
					jQuery(this).addClass("tabSelected");
					jQuery.cookie("tabactive",jQuery(this).attr("name"));
					var old_selected_tab =-1;
					tab_blocks.each(function(index2) {
						if (index1 == index2) {
							jQuery(this).show();
						}
					});
				}
			});
		
		}

		tab_titles.each(function(index1) {
			var tab_title = jQuery(this);
			tab_title.click(function () {
				if (tab_loaded==0) {
					tab_blocks.each(function(index) {
						jQuery(this).css("display","none");
					});
					tab_loaded=1;
					jQuery("#tabs").css("height","auto");
				}
				if (jQuery(this).hasClass("tabSelected")) {
					var tab_title = jQuery(this);
					tab_blocks.each(function(index2) {
						if (index1 == index2) {
							if (options.animatedTabs) {
								jQuery(this).slideUp(delay, function() {tab_title.removeClass("tabSelected");});
							} else {
								jQuery(this).hide();
								tab_title.removeClass("tabSelected");
							}
						}
					});
					jQuery.cookie("tabactive",null);
				} else {
					jQuery(this).addClass("tabSelected");
					jQuery.cookie("tabactive",jQuery(this).attr("name"));
					var old_selected_tab =-1;
					tab_titles.each(function(index2) {
						if ((index1 != index2) && (jQuery(this).hasClass("tabSelected"))) {
						old_selected_tab=index2;
						jQuery(this).removeClass("tabSelected");
						}
					});
					tab_blocks.each(function(index2) {
						if (index1 == index2) {
							if ((old_selected_tab == -1) && (options.animatedTabs)) {
								jQuery(this).slideDown(delay);
							} else {
								jQuery(this).show();
							}
						}
					});
					tab_blocks.each(function(index2) {
						if (index2 != index1) {
							jQuery(this).hide();
						}
					});
				}
			});
		}); 
		
		if (options.themeStyle != "original") {
			jQuery("#content > .hideTabsZone").css("top",jQuery("#content").offset().top+"px");			
			jQuery(".hideTabs").click(function() {
				
				tab_titles.each(function(index1) {
					if (jQuery(this).hasClass("tabSelected")) {
						var tab_title = jQuery(this);
						tab_blocks.each(function(index2) {
							if (index1 == index2) {
								if (options.animatedTabs) {
									jQuery(this).slideUp(delay, function() {tab_title.removeClass("tabSelected");});
								} else {
									jQuery(this).hide();
									tab_title.removeClass("tabSelected");
								}
							}
						});
						jQuery.cookie("tabactive",null);
					} 
				});
			
			});
		}
	}

	
	// Image autosize function inspired from Autosize Plugin (from cljosse)

	var img_ratio=image_w / image_h;

	if ((options.imageAutosize) || (options.themeStyle != 'original')) {
	
		jQuery(window).resize(function () {
			
			var Fenetre = jQuery(window);
			var ImageContainer = jQuery("#theImageAndTitle");
			var ImageCadre = jQuery("#theImg");
			var Image = jQuery("img","#theImg");
			var TitleBox=jQuery("#imageTitleContainer");
			var Content=jQuery("#content");
			
			var marge_cote=5;
			
			var marge_sup = 5 + Content.offset().top;
			var marge_inf;
			if (options.themeStyle == 'original') {
				marge_inf = options.imageAutosizeMargin+10;	
				if (options.navArrows) marge_cote=20;
			} else {
				marge_inf = 30;
				if (options.navArrows) marge_cote=25;
			}
			var marge_spec = 0;

			if (ImageCadre.length == 0) {
				ImageContainer.css("opacity","1");
				jQuery("img","#theImageAndTitle").css("opacity","1");
				ImageContainer.css("top",marge_sup+"px");
				//maps & earth
				if (jQuery("#map").length == 1) {
					ImageContainer.css("position","static");
					ImageContainer.css("margin-top","10px");
				}
				return;
			}
			
			var slideshow=jQuery("#light_slideshow");
			if (slideshow.length!=0) {
				marge_inf = 5;
				marge_spec = 25;
			}
			
			if (Image.length != 1) {
				if (TitleBox.length !=0) TitleBox.css("width","97%");
				return;
			}

			var win_height = Fenetre.height();
			marge_inf = ImageContainer.height()-Image.height()+marge_inf;
			var img_H = win_height - marge_sup - marge_inf;

			if (options.imageAutosize) {
			
				var Hmin = options.imageAutosizeMinHeight;
				
				var max_H = img_H;

				if (img_H >= image_h) img_H = image_h;
				if (img_H <= Hmin) img_H = Hmin;

				var img_W = Math.round(parseFloat(img_H * img_ratio));
				
				var marge_image = ImageCadre.outerWidth() - Image.width();
				var ext_width;
				
				if (options.themeStyle == 'original') { ext_width = jQuery("#content").width();} else {ext_width = Fenetre.width();};
				var max_W = ext_width - marge_image - marge_cote * 2;
				
				if (img_W > max_W) {
					img_H = Math.round(parseFloat(max_W / img_ratio));
					img_W = max_W;
				}
			
				Image.css("width", img_W + "px");
				Image.css("height", img_H + "px");
			
			} else {
			
				img_H = image_h;

			}

			if (options.themeStyle != 'original') {
				var marge_tot = win_height - img_H - marge_inf - marge_sup - marge_spec;
				if (marge_tot < 0) marge_tot=0;
			
				var marge = marge_sup + Math.round(parseFloat(marge_tot / 2));

				ImageContainer.css("top",marge+"px");
			}

			// limit img title Container width

			if (TitleBox.length != 0) {
				TitleBox.css("min-width",jQuery("#theImg").outerWidth()+"px");
			}

			jQuery.cookie("stripped_max_width",max_W);
			jQuery.cookie("stripped_max_height",max_H);

			ImageContainer.css("opacity","1");
			ImageCadre.css("opacity","1");
			TitleBox.css("opacity","1");

			if (options.themeStyle != 'original') {
				var max_footer_width = jQuery("#content").width() - jQuery("#tabTitles").width() - 5;
				jQuery("#copyright").css("max-width",max_footer_width);
			}
			return;

		});
		
		jQuery(window).resize();
		jQuery(window).resize();
	
	}	else {
		jQuery("#theImageAndTitle").css("opacity","1");
		jQuery("#theImg").css("opacity","1");
		jQuery("#imageTitleContainer").css("opacity","1");
		jQuery("#theImageAndTitle").css("position","static");
		jQuery("#theImageAndTitle").css("margin-top","10px");
		var TitleBox=jQuery("#imageTitleContainer");
		if (TitleBox.length !=0) TitleBox.css("width","97%");
	}
	
		
});



// Scripts taken from Gally Theme

function openDisplayHigh(url)
{
  jQuery('#theImageHigh').css(
    {
      width:jQuery("html").get(0).scrollWidth+"px",
      height:jQuery("html").get(0).scrollHeight+"px",
      display:"block"
    }
  );

  if(jQuery("#theImgHigh").attr('src')=="")
  {
    p = new Object();
    p.left = ((jQuery(window).width()-jQuery("#theImgHighContainer").prop("clientWidth")-options.paddingContainer*2)/2)+"px";
    p.top = ((jQuery(window).height()-jQuery("#theImgHighContainer").prop("clientHeight")-options.paddingContainer*2)/2)+"px";


    jQuery('#theImgHighContainer')
      .css(
        {
          left:p.left,
          top:p.top,
          padding:options.paddingContainer+"px"
        }
      );


    jQuery("#theImgHigh")
      .load(
        function ()
        {
          jQuery(document).data("highWidth", jQuery("#theImgHigh").width());
          jQuery(document).data("highHeight", jQuery("#theImgHigh").height());

          p=calcImgHighPositionAndSize(zoomMode);

          jQuery('#theImgHighContainer').css("background-image", "none")
          displayZoomHigh();
          jQuery("#theImgHigh").css( {display:"block"} );
        }
      )
      .attr('src', url);

    if(options.highResClickMode=='close')
    {
      jQuery("#theImgHigh").bind('click', closeDisplayHigh);
    }
    else
    {
      // switch zoom
      jQuery("#theImgHigh").bind('click', switchZoomHigh);
    }
  }
  else
  {
    p=calcImgHighPositionAndSize(zoomMode);

    jQuery('#theImgHighContainer')
      .css(
        {
          left:p.left+"px",
          top:p.top+"px",
          width:p.width+"px",
          height:p.height+"px"
        }
      );
  }
}

function calcImgHighPositionAndSize(zoom)
{
  p = new Object();
  imgH = jQuery(document).data("highHeight") 
  imgW = jQuery(document).data("highWidth") 

  if(zoom=='full')
  {
    p.width = (jQuery("html").get(0).clientWidth-(options.marginContainer+options.paddingContainer)*2);
    p.height = (jQuery("html").get(0).clientHeight-(options.marginContainer+options.paddingContainer)*2);
    p.left=options.marginContainer;
    p.top=options.marginContainer;

    if(p.width>imgW)
    {
      p.width = imgW;
      p.left = (jQuery("html").get(0).clientWidth-p.width)/2;
      jQuery("#theImgHighZoomButton").hide();
    }

    if(p.height>imgH)
    {
      p.height = imgH;
      p.top = (jQuery("html").get(0).clientHeight-p.height)/2;
      jQuery("#theImgHighZoomButton").hide();
    }
	
	if ((p.width==imgW) && (p.height==imgH)) switchZoomHigh();
  }
  else
  {
    //zoom = 'fit'
	ratioImg = imgW / imgH;
    ratioPage = jQuery("html").get(0).clientWidth / jQuery("html").get(0).clientHeight;

    if((ratioPage > 1 && (ratioPage > ratioImg)) ||
       (ratioPage < 1 && (ratioPage < ratioImg)))
    {
      p.height = (jQuery("html").get(0).clientHeight-(options.marginContainer+options.paddingContainer)*2);
      p.width = p.height*ratioImg;
    }
    else
    {
      p.width = (jQuery("html").get(0).clientWidth-(options.marginContainer+options.paddingContainer)*2);
      p.height = p.width/ratioImg;
    }
	
	if ((p.width > imgW) || (p.height > imgH)) {
		p.height = imgH;
		p.width = imgW;
		jQuery("#theImgHighZoomButton").hide();
	}
    p.left = (jQuery("html").get(0).clientWidth-p.width)/2;
    p.top = (jQuery("html").get(0).clientHeight-p.height)/2;
  }

  return(p);
}

function closeDisplayHigh()
{
  jQuery('#theImageHigh').css('display', 'none');
}

function switchZoomHigh()
{
  if(zoomMode=='full')
  {
    zoomMode="fit";
  }
  else
  {
    zoomMode="full";
  }

  jQuery("#theImgHighZoomButton").toggleClass('full').toggleClass('fit');

  displayZoomHigh();
}

function displayZoomHigh()
{
  p=calcImgHighPositionAndSize(zoomMode);

  jQuery('#theImgHighContainer').css(
      {
        left:p.left+"px",
        top:p.top+"px",
        width:p.width+"px",
        height:p.height+"px"
      }
    );

    if(zoomMode=="full")
    {
      jQuery("#theImgHigh")
        .css(
          {
            width:jQuery(document).data("highWidth")+"px",
            height:jQuery(document).data("highHeight")+"px"
          }
        );
      jQuery('#theImgHighContainer').bind("mousemove",
          function(event)
          {
            deadArea = options.marginContainer*2;
            mouseX=Math.max(Math.min(event.clientX-this.offsetLeft, this.clientWidth - deadArea), deadArea);
            mouseY=Math.max(Math.min(event.clientY-this.offsetTop, this.clientHeight - deadArea), deadArea);
            jQuery("#theImgHigh")
              .css("left",Math.round((jQuery("#theImgHigh").prop("scrollWidth")-this.clientWidth) * -(mouseX-deadArea)/(this.clientWidth-2*deadArea))+"px")
              .css("top",Math.round((jQuery("#theImgHigh").prop("scrollHeight")-this.clientHeight) * -(mouseY-deadArea)/(this.clientHeight-2*deadArea))+"px");
          }
        );
    }
    else
    {
      jQuery("#theImgHigh")
        .css(
          {
            width:p.width+"px",
            height:p.height+"px",
            left:"0px",
            top:"0px"
          }
        );
      jQuery('#theImgHighContainer').unbind("mousemove");
    }
}
/**
 * Cookie plugin
 * Copyright (c) 2006 Klaus Hartl (stilbuero.de)
 * Dual licensed under the MIT and GPL licenses:
 */
jQuery.cookie=function(name,value,options){if(typeof value!='undefined'){options=options||{};if(value===null){value='';options=jQuery.extend({},options);options.expires=-1;}
var expires='';if(options.expires&&(typeof options.expires=='number'||options.expires.toUTCString)){var date;if(typeof options.expires=='number'){date=new Date();date.setTime(date.getTime()+(options.expires*24*60*60*1000));}else{date=options.expires;}
expires='; expires='+date.toUTCString();}
var path=options.path?'; path='+(options.path):'';var domain=options.domain?'; domain='+(options.domain):'';var secure=options.secure?'; secure':'';document.cookie=[name,'=',encodeURIComponent(value),expires,path,domain,secure].join('');}else{var cookieValue=null;if(document.cookie&&document.cookie!=''){var cookies=document.cookie.split(';');for(var i=0;i<cookies.length;i++){var cookie=jQuery.trim(cookies[i]);if(cookie.substring(0,name.length+1)==(name+'=')){cookieValue=decodeURIComponent(cookie.substring(name.length+1));break;}}}
return cookieValue;}};




