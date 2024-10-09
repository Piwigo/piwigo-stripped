<div class="titrePage">
	<div class="browsePath">
		<span id="menuswitcher" title="{'Show/hide menu'|@translate}">{'Menu'|@translate}</span><span class="arrow"> »</span>
		<h2>{$TITLE}</h2>
	</div>
	{if isset($U_EDIT) or isset($U_SLIDESHOW) or !empty($PLUGIN_INDEX_ACTIONS) or !empty($PLUGIN_INDEX_BUTTONS) or isset($U_SEARCH_RULES) or isset($U_CADDIE) }
		<div class="categoryActionsContainer">
			<ul class="categoryActions group1">
			  	{if isset($SEARCH_IN_SET_ACTION) and $SEARCH_IN_SET_ACTION}
				{combine_css path="themes/default/vendor/fontello/css/gallery-icon.css" order=-10}
					<li id="cmdSearchInSet"><a href="{$SEARCH_IN_SET_URL}" title="{'Search in this set'|translate}" class="pwg-state-default pwg-button">
					<i class="gallery-icon-search-folder icon-white"></i>
					</a></li>
				{/if}
        {if !empty($PLUGIN_INDEX_BUTTONS)}{foreach from=$PLUGIN_INDEX_BUTTONS item=button}<li class="mainAction">{$button}</li>{/foreach}{/if}
        {if !empty($PLUGIN_INDEX_ACTIONS)}{$PLUGIN_INDEX_ACTIONS}{/if}
				{if isset($U_SEARCH_RULES)}
					{combine_script id='core.scripts' load='async' path='themes/default/js/scripts.js'}
					<li><a href="{$U_SEARCH_RULES}" onclick="popuphelp(this.href); return false;" title="{'Search rules'|@translate}" rel="nofollow">{'Help'|@translate}</a></li>
				{/if}
				{if isset($U_SLIDESHOW)}
					<li class="mainAction"><a href="{$U_SLIDESHOW}" title="{'slideshow'|@translate}" rel="nofollow">{'slideshow'|@translate}</a></li>
				{/if}
				{if isset($U_EDIT)}
					<li class="mainAction"><a href="{$U_EDIT}" title="{'edit'|@translate}">{'edit'|@translate}</a></li>
				{/if}
				{if isset($U_CADDIE) }
					<li class="mainAction"><a href="{$U_CADDIE}" title="{'add to caddie'|@translate}">{'caddie'|@translate}</a></li>
				{/if}
			</ul>
		</div>
	{/if}
	{if ($GMaps_loaded)}<div id="text_gmaps" style="display:none">{'GMap'|@translate}</div>{/if}
</div>
<div id="content" {if !$stripped.hideMenu}class="menuShown"{/if}>
	{$MENUBAR}
	<div id="content_cell">
		{include file='infos_errors.tpl'} 
		{if !empty($PLUGIN_INDEX_CONTENT_BEFORE)}<div class="subcontent">{$PLUGIN_INDEX_CONTENT_BEFORE}</div>{/if}
		<div id="subcontent">
			{if isset($chronology.TITLE) }
				<h2>{$chronology.TITLE}</h2>
			{/if}
			{if isset($chronology_views) }
				{if isset($U_MODE_POSTED) }
					<a href="{$U_MODE_POSTED}" rel="nofollow">{'display a calendar by posted date'|@translate}</a>
				{/if}
				{if isset($U_MODE_CREATED) }
					<a href="{$U_MODE_CREATED}" rel="nofollow">{'display a calendar by creation date'|@translate}</a>
				{/if}
				<div class="calendarViews">{'View'|@translate}:
					<select onchange="document.location = this.options[this.selectedIndex].value;">
						{foreach from=$chronology_views item=view}
							<option value="{$view.VALUE}"{if $view.SELECTED} selected="selected"{/if}>{$view.CONTENT}</option>
						{/foreach}
					</select>
				</div>
			{/if}

			{if !empty($PLUGIN_INDEX_CONTENT_BEGIN)}<div class="content_block">{$PLUGIN_INDEX_CONTENT_BEGIN}</div>{/if}
			{if !empty($category_search_results) }
				<div>{'Album results for'|@translate} <strong>{$QUERY_SEARCH}</strong> :
					{foreach from=$category_search_results item=res name=res_loop}
					{if !$smarty.foreach.res_loop.first} &mdash; {/if}
					{$res}
					{/foreach}
				</div>
			{/if}
			{if !empty($tag_search_results) }
				<div>{'Tag results for'|@translate} <strong>{$QUERY_SEARCH}</strong> :
					{foreach from=$tag_search_results item=tag name=res_loop}
						{if !$smarty.foreach.res_loop.first} &mdash; {/if} <a href="{$tag.URL}">{$tag.name}</a>
					{/foreach}
				</div>
			{/if}
			{if isset($FILE_CHRONOLOGY_VIEW) }
				{include file=$FILE_CHRONOLOGY_VIEW}
			{/if}

			{if isset($SEARCH_IN_SET_BUTTON) and $SEARCH_IN_SET_BUTTON}
				<div class="mcs-side-results search-in-set-button">
				  <div>
				  <p><a href="{$SEARCH_IN_SET_URL}" class="gallery-icon-search-folder">{'Search in this set'|translate}</a></p>
				  </div>
				</div>
			{/if}

			{if !empty($CONTENT_DESCRIPTION) }
				<div class="content_block"><div class="additional_info">
					{$CONTENT_DESCRIPTION}
				</div></div>
			{/if}
      {if !empty($CONTENT)}{$CONTENT}{/if}
			{if !empty($CATEGORIES) }{$CATEGORIES}{/if}
      {if !empty($cats_navbar)}
        {include file='navigation_bar.tpl'|@get_extent:'navbar' navbar=$cats_navbar}
      {/if}

	  {if !empty($SEARCH_ID)}
		{include file='themes/default/template/include/search_filters.inc.tpl'}
	  {/if}

			{if !empty($THUMBNAILS) }
				<div id="thumbnails_block1">
					<div id="thumbnails_block2">
						<div class="thumbnails" id="thumbnails">{$THUMBNAILS}</div>
						{if (!(empty($thumb_navbar)) && !($ThumbScroller_loaded)) }
							{include file='navigation_thumb.tpl'|@get_extent:'navbar' navbar=$thumb_navbar}
						{/if}
					</div>
						{if !empty($thumb_navbar) }
							{include file='navigation_bar.tpl'|@get_extent:'navbar' navbar=$thumb_navbar}
						{/if}
				</div>
        <div class="loader"><img src="{$ROOT_URL}{$themeconf.img_dir}/ajax_loader.gif"></div>
			{else if !empty($SEARCH_ID)}
				<div class="mcs-no-result">
			  		<div class="text">
						<span class="top">{'No results are available.'|@translate}</span>
						<span class="bot">{'You can try to edit your filters and perform a new search.'|translate}</span>
			  		</div>
				</div>
			{/if}
			{if !empty($PLUGIN_INDEX_CONTENT_END) }<div class="content_block">{$PLUGIN_INDEX_CONTENT_END}</div>{/if}
		</div> <!-- subcontent -->
		{if !empty($PLUGIN_INDEX_CONTENT_AFTER)}<div class="subcontent">{$PLUGIN_INDEX_CONTENT_AFTER}</div>{/if}
	</div>
	<div style="clear: both;"></div>
</div>