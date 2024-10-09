{combine_script id='core.switchbox' load='async' require='jquery' path='themes/default/js/switchbox.js'}

{assign var=derivative value=$pwg->derivative($stripped.imageSize, $current.src_image)}
{assign var='size' value=$derivative->get_size()}
{literal}
<script type="text/javascript">
var image_w = {/literal}{$size[0]}{literal}
var image_h = {/literal}{$size[1]}{literal}
</script>
{/literal}

{include file='infos_errors.tpl'} 

<div class="titrePage" id="imageHeaderBar">
	<div class="browsePath">
		{$SECTION_TITLE}
		{if ($stripped.showTitleOnBrowsePath)}{$LEVEL_SEPARATOR}{$current.TITLE}{/if}
	</div>
    <ul class="randomButtons">
		<li id="imageToolBar">
			{include file='picture_nav_buttons.tpl'|@get_extent:'picture_nav_buttons'}
		</li>

{if isset($U_PHOTO_ADMIN) or isset($U_CADDIE) or !empty($U_SET_AS_REPRESENTATIVE)}
    <li><a id="adminSwitchLink" href="#">{'Administration'|translate}</a></li>

{footer_script require='jquery'}{literal}
jQuery().ready(function() {
  (window.SwitchBox=window.SwitchBox||[]).push("#adminSwitchLink", "#adminSwitchBox");
});
{/literal}{/footer_script}
 
<div id="adminSwitchBox" class="switchBox">
  <ul>
  {if isset($U_PHOTO_ADMIN)}
    <li><a href="{$U_PHOTO_ADMIN}" title="{'Modify information'|@translate}">{'edit'|@translate}</a></li>
  {/if}
  {if isset($U_CADDIE)}
    <li><a href="{$U_CADDIE}" onclick="addToCadie(this, '{$ROOT_URL}', {$current.id}); return false;" title="{'add to caddie'|@translate}" rel="nofollow">{'caddie'|@translate}</a></li>
  {/if}
  {if !empty($U_SET_AS_REPRESENTATIVE) }
    <li><a href="{$U_SET_AS_REPRESENTATIVE}" title="{'set as album representative'|@translate}">{'representative'|@translate}</a></li>
  {/if}
  </ul>
</div>
{/if}

		{strip}{if isset($U_SLIDESHOW_START) }
			<li><a href="{$U_SLIDESHOW_START}" title="{'slideshow'|@translate}" rel="nofollow">{'slideshow'|@translate}</a></li>
		{/if}{/strip}
		{strip}{if isset($favorite) }
			<li><a href="{$favorite.U_FAVORITE}" title="{if $favorite.IS_FAVORITE}{'delete this photo from your favorites'|@translate}{else}{'add this photo to your favorites'|@translate}{/if}">{'Favorites'|@translate}</a></li>
        {/if}{/strip}
		{strip}{if isset($current.U_DOWNLOAD)}
			<li><a id="downloadSwitchLink" href="{$current.U_DOWNLOAD}" title="{'download this file'|@translate}">{'Download'|@translate}</a></li>
		{/if}{/strip}

{if !empty($current.formats)}
{footer_script require='jquery'}{literal}
jQuery().ready(function() {
  jQuery("#downloadSwitchLink").removeAttr("href");
 
  (window.SwitchBox=window.SwitchBox||[]).push("#downloadSwitchLink", "#downloadSwitchBox");
});
{/literal}{/footer_script}
 
<div id="downloadSwitchBox" class="switchBox">
  <div class="switchBoxTitle">{'Download'|translate} - {'Formats'|translate}</div>
  <ul>
  {foreach from=$current.formats item=format}
    <li><a href="{$format.download_url}" rel="nofollow">{$format.label}<span class="downloadformatDetails"> ({$format.filesize})</span></a></li>
  {/foreach}
  </ul>
</div>
{/if} {* has formats *}

		{strip}{if isset($PLUGIN_PICTURE_ACTIONS)}
			<li class="plugin_buttons plugin_buttons_group1">{$PLUGIN_PICTURE_ACTIONS}</li>
		{/if}
    {/strip}
    {if isset($PLUGIN_PICTURE_BUTTONS)}{foreach from=$PLUGIN_PICTURE_BUTTONS item=button}<li class="plugin_buttons plugin_buttons_group1">{$button}</li>{/foreach}{/if}
		{strip}{if isset($U_CADDIE)}{*caddie management BEGIN*}
			{footer_script}
				{literal}
					function addToCadie(aElement, rootUrl, id)
					{
						if (aElement.disabled) return;
						aElement.disabled=true;
						var y = new PwgWS(rootUrl);
						y.callService(
							"pwg.caddie.add", {image_id: id} ,
							{
								onFailure: function(num, text) { alert(num + " " + text); document.location=aElement.href; },
								onSuccess: function(result) { aElement.disabled = false; }
							}
						);
					}
				{/literal}
			{/footer_script}
		{/if}{/strip}
		<li class="plugin_buttons plugin_buttons_group2">{*caddie management END*}</li>
    </ul>
		{if ($GMaps_loaded)}<div id="text_gmaps" style="display:none">{'GMap'|@translate}</div>{/if}
	<div style="clear:both;"></div>
</div> <!-- imageHeaderBar -->

{if !empty($PLUGIN_PICTURE_BEFORE)}{$PLUGIN_PICTURE_BEFORE}{/if}
<div id="content">
	<div class="hideTabsZone hideTabs">&nbsp;</div>

 <!-- Image HD --> 
  <div id="theImageHigh" style="display:none;">
    <div id="theImgHighBg"></div>
    <div id="theImgHighContainer">
      <div id="theImgHighCloseButton" onclick="closeDisplayHigh();"></div>
      <div id="theImgHighZoomButton" class="fit" onclick="switchZoomHigh();"></div>
      <div id="theImgHighContainer2">
        <img id="theImgHigh" src="" style="display:none;" alt="{$ALT_IMG}">
      </div>
    </div>
  </div>

	{assign var='display_description_tab' value=false}
	{if (($stripped.imageCaption != 'description') && isset($COMMENT_IMG))}
		{assign var='display_description_tab' value=true}
	{/if}

	{assign var='showTitle' value=false}
	{if isset($COMMENT_IMG) and $stripped.imageCaption == 'description'}
		{assign var='showTitle' value=true}
	{/if}
	{if isset($current.TITLE) and $stripped.imageCaption == 'title'}
		{assign var='showTitle' value=true}
	{/if}

<div id="theImageAndTitle">
	<div id="theImageBox" >
		<div class="hideTabsZone hideTabs">&nbsp;</div>
		{if (isset($previous) && $stripped.navArrows) }
			<a href="{$previous.U_IMG}" id="imgprev">&nbsp;</a>
		{/if}
		<div id="theImage">
			{$ELEMENT_CONTENT}
		</div>
		{if (isset($next) && $stripped.navArrows)}
			<a href="{$next.U_IMG}" id="imgnext">&nbsp;</a>
		{/if}
	</div>
	{if $showTitle }
		<div id="imageTitleContainer"><div id="imageTitle">
			{if ($stripped.imageCaption == 'description' )}
				{$COMMENT_IMG}
			{/if}
			{if ($stripped.imageCaption == 'title' )}
				{$current.TITLE}
			{/if}
		</div></div>
	{/if}
 </div> <!-- theImage -->
 <div style="clear: both;"></div>

 	<div id="tabZone">

		{assign var='display_info_panel' value=false}
		{assign var='display_count' value='0'}
		{if $display_info.author}{assign var='display_count' value=$display_count+1}{/if}
		{if $display_info.created_on}{assign var='display_count' value=$display_count+1}{/if}
		{if $display_info.posted_on}{assign var='display_count' value=$display_count+1}{/if}
		{if $display_info.dimensions}{assign var='display_count' value=$display_count+1}{/if}
		{if $display_info.file}{assign var='display_count' value=$display_count+1}{/if}
		{if $display_info.filesize}{assign var='display_count' value=$display_count+1}{/if}
		{if $display_info.categories}{assign var='display_count' value=$display_count+1}{/if}
		{if $display_info.visits}{assign var='display_count' value=$display_count+1}{/if}
		{if $display_info.rating_score and isset($rate_summary) }{assign var='display_count' value=$display_count+1}{/if}
		{if isset($rating)}{assign var='display_count' value=$display_count+1}{/if}
		{if $display_info.privacy_level and isset($available_permission_levels) }{assign var='display_count' value=$display_count+1}{/if}
		{if (($display_count > 0) && ((isset($U_ADMIN)) || ($stripped.infoTabAdminOnly == false)))}
			{assign var='display_info_panel' value=true}
		{/if}
		<div id="tabTitleBar">
			<ul id="tabTitles">
				{if $display_description_tab}
					<li id="tabTcaption" class="tabTitle" name="caption">{'Description'|@translate}</li>
				{/if}
				{if ($display_info.tags && (isset($related_tags) || ($usertags)))}
					<li id="tabTtags" class="tabTitle" name="tags">{'Tags'|@translate}</li>
				{/if}
				{if isset($metadata)}
					{foreach from=$metadata item=meta key=id}
						<li id="tabTmeta{$id}" class="tabTitle" name="meta{$id}">{$meta.TITLE}</li>
					{/foreach}
				{/if}
				{if $display_info_panel}
					<li id="tabTinfo" class="tabTitle" name="info">{'Information'|@translate}</li>
				{/if}
				{if (isset($COMMENT_COUNT) and ($COMMENT_COUNT>0)) or isset($comment_add) }
					<li id="tabTcomments" class="tabTitle" title="{'Add a comment'|@translate}" name="comments">{$COMMENT_COUNT|translate_dec:'%d comment':'%d comments'}</li>
				{/if}
			</ul>
		</div>
		<div id="tabs">
			{if $display_description_tab}
				<div id="Tcaption" class="tabBlock"><div class="tabBlockContent">
					{$COMMENT_IMG}
				</div></div>
			{/if}
			{if ($display_info.tags && (isset($related_tags) || ($usertags)))}
				<div id="Ttags" class="tabBlock"><div class="tabBlockContent">
				{if ($usertags)}<table id="TagsTable"><tr id="Tags" ><td class="label"></td><td class="value">{/if}
				{foreach from=$related_tags item=tag name=tag_loop}{if !$smarty.foreach.tag_loop.first}, {/if}
					<a href="{$tag.URL}">{$tag.name}</a>
				{/foreach}
				{if ($usertags)}</td></tr></table>{/if}
				</div></div>
			{/if}
			{if isset($metadata)}
				{foreach from=$metadata item=meta key=id}
					<div id="Tmeta{$id}" class="tabBlock"><div class="tabBlockContent">
						{if count($meta.lines)>0 and !array_key_exists('<!--rawContent-->', $meta.lines)}
							<table id="table_meta{$id}" class="infoTable2">
								{foreach from=$meta.lines item=value key=label}
									  <tr>
										<td class="label">{$label|@translate}</td>
										<td class="value">{$value}</td>
									  </tr>
								{/foreach}
							</table>
						{else}
							  {assign var='empty' value='<!--rawContent-->'}
							  {$meta.lines.$empty}
						{/if}
					</div></div>
				{/foreach}
			{/if}
			{if $display_info_panel}
				<div id="Tinfo" class="tabBlock"><div class="tabBlockContent">
				
<dl id="standard" class="imageInfoTable">
{strip}
	{if $display_info.author and isset($INFO_AUTHOR)}
	<div id="Author" class="imageInfo">
		<dt>{'Author'|@translate}</dt>
		<dd>{$INFO_AUTHOR}</dd>
	</div>
	{/if}
	{if $display_info.created_on and isset($INFO_CREATION_DATE)}
	<div id="datecreate" class="imageInfo">
		<dt>{'Created on'|@translate}</dt>
		<dd>{$INFO_CREATION_DATE}</dd>
	</div>
	{/if}
	{if $display_info.posted_on}
	<div id="datepost" class="imageInfo">
		<dt>{'Posted on'|@translate}</dt>
		<dd>{$INFO_POSTED_DATE}</dd>
	</div>
	{/if}
	{if $display_info.dimensions and isset($INFO_DIMENSIONS)}
	<div id="Dimensions" class="imageInfo">
		<dt>{'Dimensions'|@translate}</dt>
		<dd>{$INFO_DIMENSIONS}</dd>
	</div>
	{/if}
	{if $display_info.file}
	<div id="File" class="imageInfo">
		<dt>{'File'|@translate}</dt>
		<dd>{$INFO_FILE}</dd>
	</div>
	{/if}
	{if $display_info.filesize and isset($INFO_FILESIZE)}
	<div id="Filesize" class="imageInfo">
		<dt>{'Filesize'|@translate}</dt>
		<dd>{$INFO_FILESIZE}</dd>
	</div>
	{/if}
	{if $display_info.tags and isset($related_tags)}
	<div id="Tags" class="imageInfo">
		<dt>{'Tags'|@translate}</dt>
		<dd>
		{foreach from=$related_tags item=tag name=tag_loop}{if !$smarty.foreach.tag_loop.first}, {/if}<a href="{$tag.URL}">{$tag.name}</a>{/foreach}
		</dd>
	</div>
	{/if}
	{if $display_info.categories and isset($related_categories)}
	<div id="Categories" class="imageInfo">
		<dt>{'Albums'|@translate}</dt>
		<dd>
			<ul>
				{foreach from=$related_categories item=cat}
				<li>{$cat}</li>
				{/foreach}
			</ul>
		</dd>
	</div>
	{/if}
	{if $display_info.visits}
	<div id="Visits" class="imageInfo">
		<dt>{'Visits'|@translate}</dt>
		<dd>{$INFO_VISITS}</dd>
	</div>
	{/if}
{if $display_info.rating_score and isset($rate_summary)}
	<div id="Average" class="imageInfo">
		<dt>{'Rating score'|@translate}</dt>
		<dd>
		{if $rate_summary.count}
			<span id="ratingScore">{$rate_summary.score}</span> <span id="ratingCount">({$rate_summary.count|@translate_dec:'%d rate':'%d rates'})</span>
		{else}
			<span id="ratingScore">{'no rate'|@translate}</span> <span id="ratingCount"></span>
		{/if}
		</dd>
	</div>
{/if}
{if isset($rating)}
	<div id="rating" class="imageInfo">
		<dt>
			<span id="updateRate">{if isset($rating.USER_RATE)}{'Update your rating'|@translate}{else}{'Rate this photo'|@translate}{/if}</span>
		</dt>
		<dd>
									<form action="{$rating.F_ACTION}" method="post" id="rateForm" style="margin:0;">
										<div>
											{foreach from=$rating.marks item=mark name=rate_loop}
												{if isset($rating.USER_RATE) && $mark==$rating.USER_RATE}
													<input type="button" name="rate" value="{$mark}" class="rateButtonSelected" title="{$mark}">
												{else}
													<input type="submit" name="rate" value="{$mark}" class="rateButton" title="{$mark}">
												{/if}
											{/foreach}
											{strip}{combine_script id='core.scripts' load='async' path='themes/default/js/scripts.js'}
											{combine_script id='rating' load='async' require='core.scripts' path='themes/default/js/rating.js'}
											{footer_script}
												var _pwgRatingAutoQueue = _pwgRatingAutoQueue||[];
												_pwgRatingAutoQueue.push( {ldelim}rootUrl: '{$ROOT_URL}', image_id: {$current.id},
													updateRateText: "{'Update your rating'|@translate|@escape:'javascript'}", updateRateElement: document.getElementById("updateRate"),
													ratingSummaryText: "{'%.2f (rated %d times)'|@translate|@escape:'javascript'}", ratingSummaryElement: document.getElementById("ratingSummary"){rdelim} );
											{/footer_script}
											{/strip}
										</div>
									</form>
		</dd>
	</div>
{/if}
{/strip}
</dl>
				
					<table id="standard" class="infoTable">
						{if $display_info.privacy_level and isset($available_permission_levels)}
							<tr id="Privacy">
								<td class="label">{'Who can see this photo?'|@translate}</td>
								<td class="value">
									{combine_script id='core.scripts' load='async' path='themes/default/js/scripts.js'}
									{footer_script}
										{literal}function setPrivacyLevel(selectElement, rootUrl, id, level)
										{
											selectElement.disabled = true;
											var y = new PwgWS(rootUrl);
											y.callService(
											"pwg.images.setPrivacyLevel", {image_id: id, level:level} ,
											{
												method: "POST",
												onFailure: function(num, text) { selectElement.disabled = false; alert(num + " " + text); },
												onSuccess: function(result) { selectElement.disabled = false; }
											}
										);
										}{/literal}
									{/footer_script}
									<select onchange="setPrivacyLevel(this, '{$ROOT_URL}', {$current.id}, this.options[selectedIndex].value)">
										{foreach from=$available_permission_levels item=label key=level}
											<option label="{$label}" value="{$level}"{if $level == $current.level} selected="selected"{/if}>{$label}</option>
										{/foreach}
									</select>
								</td>
							</tr>
						{/if}
					</table>
				</div></div>
			{/if}
			{if (isset($COMMENT_COUNT) and ($COMMENT_COUNT>0)) or isset($comment_add) }
				<div id="Tcomments" class="tabBlock"><div id="theComments" class="tabBlockContent">
					<div id="theCommentsBlock">
						{if !empty($COMMENT_NAV_BAR)}
							<div class="navigationBar">{$COMMENT_NAV_BAR}</div>
						{/if}
						{if isset($comment_add)}
							<div id="commentAdd">
								<h4>{'Add a comment'|@translate}</h4>
								<form  method="post" action="{$comment_add.F_ACTION}" class="filter" id="addComment" >
                  {if $comment_add.SHOW_AUTHOR}
                    <p><label for="author">{'Author'|@translate}{if $comment_add.AUTHOR_MANDATORY} ({'mandatory'|@translate}){/if} :</label></p>
                    <p><input type="text" name="author" id="author" value="{$comment_add.AUTHOR}"></p>
                  {/if}
                  {if $comment_add.SHOW_EMAIL}
                    <p><label for="email">{'Email'|@translate}{if $comment_add.EMAIL_MANDATORY} ({'mandatory'|@translate}){/if} :</label></p>
                    <p><input type="text" name="email" id="email" value="{$comment_add.EMAIL}"></p>
                  {/if}
                  <p><label for="website_url">{'Website'|@translate} :</label></p>
                  <p><input type="text" name="website_url" id="website_url" value="{$comment_add.WEBSITE_URL}"></p>
                  <p><label for="contentid">{'Comment'|@translate} ({'mandatory'|@translate}) :</label></p>
                  <p><textarea name="content" id="contentid" rows="5" cols="50">{$comment_add.CONTENT}</textarea></p>
                  <p><input type="hidden" name="key" value="{$comment_add.KEY}">
                    <input class="submit" type="submit" value="{'Submit'|@translate}"></p>
                </form>
							</div>
						{/if}
						{if !empty($navbar) }{include file='navigation_bar.tpl'|@get_extent:'navbar'}{/if}
						{if isset($comments)}
							<div id="commentList">
								{if isset($COMMENT_LIST)}
									{$COMMENT_LIST}
								{else}
								    {include file='comment_list.tpl'}
								{/if}
							</div>
						{/if}
						<div style="clear: both;"></div>
					</div>
				</div></div>
			{/if}
		</div>
	</div>
    <div style="clear: both;"></div>
</div>
{if isset($stripped.imagePreload) && isset($U_IMGNEXT)}
<div id="image_urls" style="display:none;">
	{foreach from=$U_IMGNEXT item=u_img key=id}
		{if isset($u_img)}<div class="next{$id} preload">{$u_img}</div>{/if}
	{/foreach}
</div>
{/if}
{if !empty($PLUGIN_PICTURE_AFTER)}{$PLUGIN_PICTURE_AFTER}{/if}
