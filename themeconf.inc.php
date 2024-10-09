<?php
/*
Theme Name: stripped
Version: auto
Description: stripped Theme
Theme URI: http://piwigo.org/ext/extension_view.php?eid=471
Author: Julien Capitaine (Zaphod on Piwigo forums)
Author URI: http://www.audreyetjulien.fr/galerie
*/

global $conf, $user, $stripped;

// Need upgrade?
if (!isset($conf['stripped']))
  include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');

$conf['stripped'] = safe_unserialize($conf['stripped']);

$stripped = array_merge($conf['stripped'], (array)$stripped );

// Need upgrade from v1.x?
if (!isset($stripped['themeStyle'])) {
	include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');
	$stripped = array_merge($conf['stripped'], (array)$stripped );
}

// Need upgrade from v2.x?
if (!isset($stripped['paramVersion'])) {
	include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');
	$stripped = array_merge($conf['stripped'], (array)$stripped );
}

// Need upgrade from v2.1 or v2.2?
if ((isset($stripped['paramVersion'])) && ($stripped['paramVersion'] != '2.3')) {
	include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');
	$stripped = array_merge($conf['stripped'], (array)$stripped );
}


add_event_handler('init', 'set_config_values');
function set_config_values()
{
  global $template, $pwg_loaded_plugins, $stripped;
  $template->assign(array(
                          'automatic_size_enabled'=> isset($pwg_loaded_plugins['automatic_size']),
                          'HDShadowbox_loaded'=> isset($pwg_loaded_plugins['HDShadowbox']),
                          'GMaps_loaded'=> isset($pwg_loaded_plugins['GMaps']),
                          'ThumbScroller_loaded'=> isset($pwg_loaded_plugins[ 'rv_tscroller' ]),
                          'usertags'=> isset($pwg_loaded_plugins['user_tags']),
                          'stripped'=> $stripped
                         ));
}
	
$themeconf = array(
  'parent' => 'default',
  'load_parent_css' => false,
  'load_parent_local_head' => false,
  'name' => 'stripped',
  'theme_dir' => 'stripped',
  'icon_dir' => 'themes/stripped/icon',
  'img_dir'      => 'themes/stripped/images',
  'admin_icon_dir' => 'themes/default/icon/admin',
  'mime_icon_dir' => 'themes/default/icon/mimetypes/',
  'local_head' => 'local_head.tpl',
  'colorscheme' => 'white' == $stripped['themeStyle'] ? 'clear' : 'dark',
);

load_language('theme.lang', PHPWG_THEMES_PATH.'stripped/');

pwg_set_session_var('show_metadata', true);

// max number of thumbnails by page 

add_event_handler('loc_begin_index', 'modify_nb_thumbnail_page');
function modify_nb_thumbnail_page()
{
	global $user, $page, $stripped;

	if (!isset($stripped['maxThumb'])) { $stripped['maxThumb']=15;}
	$user['nb_image_page']=$stripped['maxThumb'];
	$page['nb_image_page']=$stripped['maxThumb'];
}

// Preload function

if (isset($stripped['imagePreload']) && ($user['theme'] == 'stripped')) {
	add_event_handler('loc_end_picture', 'assign_next_images_url');
}

function assign_next_images_url()
{
	global $page, $template, $conf, $stripped;

	$nb_image =$stripped['imagePreloadNb'];
	$nb_max = $page['last_rank'] - $page['current_rank'];
	$nb_image = min ($nb_image, $nb_max);

	if ($nb_image < 1) return;

	for ($n = 1; $n <= $nb_image; $n++) {
		$pagenext[$n] = $page['items'][ $page['current_rank'] + $n ];
	}

	$picturenext = array();
	$idnext = array();

	for ($n = 1; $n <= $nb_image; $n++) {
		array_push($idnext, $pagenext[$n]);
	}

	$query = '
	SELECT *
	  FROM '.IMAGES_TABLE.'
	  WHERE id IN ('.implode(',', $idnext).')
	;';

	$result = pwg_query($query);

	while ($rownext = pwg_db_fetch_assoc($result))
	{
		for ($n = 1; $n <= $nb_image; $n++) {
			if (isset($pagenext[$n]) and $rownext['id'] == $pagenext[$n]) {$in = $n;}
		}

		$picturenext[$in] = $rownext;

		$derivative = new DerivativeImage($stripped['imageSize'], new SrcImage($rownext));
		$picturenext[$in]['image_url'] = $derivative->get_url();
	}

	for ($n = 1; $n <= $nb_image; $n++) {
		if (isset($picturenext[$n]['image_url'])) { $image_next[$n] = $picturenext[$n]['image_url']; }
	}
  
  $template->assign('U_IMGNEXT', $image_next );

}

?>
