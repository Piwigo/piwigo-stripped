<?php

function theme_activate($id, $version, &$errors)
{
  global $prefixeTable, $conf;

  if (!isset($conf['stripped']))
  {
    $config = array(
	'paramVersion' 					=> '2.3',
	
	'themeStyle'					=> 'black',
	'hideMenu'						=> true,
	'animatedMenu'					=> true,
	'noLowercase'					=> false,
	'albumType'						=> 'small',
	'albumFrame'					=> true,
	'thumbFrame'					=> true,
	'showThumbLegend'				=> false,

	'showTitleOnBrowsePath'			=> false,
	'imageFrame'					=> true,
	'imageCaption'					=> 'title',
	'imageArrows'					=> false,
	'navArrows'						=> true,
	'HDlightbox'					=> true,
	'forceLightboxOn'				=> false,
	'defaultZoomSize'				=> 'fit',
	'animatedTabs'					=> true,
	'infoTabAdminOnly'				=> false,
	'defaultTab'					=> "none",

	'albumSize'						=> "thumb",
	'thumbSize'						=> "thumb",
	'imageSize'						=> "medium",
	'hdSize'						=> "xxlarge",
	
	'imageAutosize'					=> true,
	'imageAutosizeMargin'			=> 60,
	'imageAutosizeMinHeight'		=> 200,

	'imagePreload'					=> false,
	'imagePreloadNb'				=> 5,
	'imagePreloadThumbs'			=> false,
	'imagePreloadHD'				=> false,

	'marginContainer'				=> 30,
	'paddingContainer'				=> 10,
	'highResClickMode'				=> 'zoom',
	'maxThumb'						=> 15,
      );
      
    $query = "
INSERT INTO " . CONFIG_TABLE . " (param,value,comment)
VALUES ('stripped' , '".pwg_db_real_escape_string(serialize($config))."' , 'stripped theme parameters');";

    pwg_query($query);
  }
}

function theme_deactivate()
{
  global $prefixeTable;

  $query = "DELETE FROM " . CONFIG_TABLE . " WHERE param='stripped';";
  pwg_query($query);
}

?>