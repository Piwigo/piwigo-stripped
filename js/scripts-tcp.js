jQuery("document").ready(function(jQuery){

// scripts Category Page ------------------------------------------------------------------------------------------------------------

	// menu switcher script from Simple Theme
	
	var delay;
	var animation_webkit = true;
	if (options.animatedMenu) {
		delay = "slow";
	} else {
		delay = 0;
	}

	jQuery("#menuswitcher").click(function(){
		if (jQuery("#menubar").is(":hidden")) {
			if (delay == 0) {
				jQuery("#menubar").show();
				tnb_resize();
			} else {
				if (animation_webkit) {
					jQuery("#menubar").show("blind",{},delay, function (){tnb_resize();});
				} else {
					jQuery("#menubar").show(delay, function (){tnb_resize();});
				}
			}
			jQuery.cookie('side-menu', 'showing', {path: "/"});
			if (jQuery("#thumbnails_block2").length != 0) tnb_resize();
			return false;
		} else {
				if (animation_webkit) {
					jQuery("#menubar").hide("blind",{},delay, function (){tnb_resize();});
				} else {
					jQuery("#menubar").hide(delay, function (){tnb_resize();});
				}
			jQuery.cookie('side-menu', 'hiding', {path: "/"});
		return false;
		}
	});

	// creates a variable with the contents of the cookie side-menu
	var sidemenu = jQuery.cookie('side-menu');
	
	// if cookie says the menu is hiding, keep it hidden!
	if (sidemenu == 'hiding') {
		jQuery("#menubar").hide();
	}
	if (sidemenu == 'showing') {
		jQuery("#menubar").show();
	}
  
	// resize thumbnail block
	jQuery(window).resize(function() { tnb_resize(); });
	tnb_resize();

	// display alt from PWG stuffs actions.

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
	}	
	
	// bug with MSIE6 & language switch
	/*
	if ((jQuery.browser.msie) && (jQuery.browser.version.substr(0,1) == "6")) {
		var lswitch = jQuery(".menuf > div > ul");
		if (lswitch.length==1) {
			var flags = lswitch.children("li").children("a");
			if (flags.length==2) {
				flags.first().remove();
			}
		}
	}*/
	
});



// Thumbnails Block Resize function

function tnb_resize() {
	if (jQuery("#thumbnails_block2").length != 0) {
		var tnb_width = 40+180*parseInt((jQuery("#thumbnails_block1").width()-40)/180);
		jQuery("#thumbnails_block2").css("max-width",tnb_width+"px");
	};
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
