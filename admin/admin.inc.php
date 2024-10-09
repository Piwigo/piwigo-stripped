<?php

global $conf;

// Need upgrade?
if (!isset($conf['stripped']))
  include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');

$stripped = unserialize( $conf['stripped'] );

// Need upgrade from v1.x?
if (!isset($stripped['themeStyle'])) {
	include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');
	$stripped = array_merge( unserialize( $conf['stripped'] ), (array)$stripped );
}

// Need upgrade from v2.x?
if (!isset($stripped['paramVersion'])) {
	include(PHPWG_THEMES_PATH.'stripped/admin/upgrade.inc.php');
	$stripped = array_merge( unserialize( $conf['stripped'] ), (array)$stripped );
}

load_language('theme.lang', PHPWG_THEMES_PATH.'stripped/');

$config= array ();

if(isset($_POST['submit_stripped']))
{
	$config['paramVersion']='2.3';

	$config['themeStyle']=$_POST['f_themeStyle'];
	$config['hideMenu']=isset($_POST['f_hideMenu']);
	$config['animatedMenu']=isset($_POST['f_animatedMenu']);
	$config['noLowercase']=!isset($_POST['f_forceLowercase']);
	$config['albumType']=$_POST['f_albumType'];
	$config['albumFrame']=isset($_POST['f_albumFrame']);
	$config['thumbFrame']=isset($_POST['f_thumbFrame']);
	$config['showThumbLegend']=isset($_POST['f_showThumbLegend']);

	$config['showTitleOnBrowsePath']=isset($_POST['f_showTitleOnBrowsePath']);
	$config['imageFrame']=isset($_POST['f_imageFrame']);
	$config['imageCaption']=$_POST['f_imageCaption'];
	$config['imageArrows']=isset($_POST['f_imageArrows']);
	$config['navArrows']=isset($_POST['f_navArrows']);
	$config['HDlightbox']=($_POST['f_lightboxOptions'] != 'never');
	$config['forceLightboxOn']=($_POST['f_lightboxOptions'] == 'always');
	$config['defaultZoomSize']=$_POST['f_defaultZoomSize'];
	$config['animatedTabs']=isset($_POST['f_animatedTabs']);
	$config['infoTabAdminOnly']=isset($_POST['f_infoTabAdminOnly']);
	$config['defaultTab']=$_POST['f_defaultTab'];

	$config['albumSize']=$_POST['f_albumSize'];
	$config['thumbSize']=$_POST['f_thumbSize'];
	$config['imageSize']=$_POST['f_imageSize'];
	$config['hdSize']=$_POST['f_hdSize'];

	$config['imageAutosize']=isset($_POST['f_imageAutosize']);
	if (isset($_POST['f_imageAutosizeMargin'])) { $config['imageAutosizeMargin']=intval($_REQUEST['f_imageAutosizeMargin']); }
	if (isset($_POST['f_imageAutosizeMinHeight'])) { $config['imageAutosizeMinHeight']=intval($_REQUEST['f_imageAutosizeMinHeight']); }

	$config['imagePreload']=isset($_POST['f_imagePreload']);
	$config['imagePreloadNb']=$_POST['f_imagePreloadNb'];
	$config['imagePreloadThumbs']=isset($_POST['f_imagePreloadThumbs']);
	$config['imagePreloadHD']=false;

	$config['marginContainer']=30;
	$config['paddingContainer']=10;
	$config['highResClickMode']='zoom';
	$config['maxThumb']=15;

	conf_update_param('stripped', $config, true);
	array_push($page['infos'], l10n('stripped Configuration updated'));
}

$template->set_filenames(array(
    'theme_admin_content' => dirname(__FILE__) . '/admin.tpl'));

$template->assign('options', safe_unserialize($conf['stripped']));

$template->assign_var_from_handle('ADMIN_CONTENT', 'theme_admin_content');
  
?>