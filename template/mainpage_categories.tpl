{footer_script}
  var error_icon = "{$ROOT_URL}{$themeconf.icon_dir}/errors_small.png", max_requests = {$maxRequests};
{/footer_script}
<div class="loader"><img src="{$ROOT_URL}{$themeconf.img_dir}/ajax_loader.gif"></div>
<ul class="thumbnailCategories">
  {foreach from=$category_thumbnails item=cat name=catloop}
  {assign var=derivative value=$pwg->derivative($stripped.albumSize, $cat.representative.src_image)}
  {if !$derivative->is_cached()}
  {combine_script id='jquery.ajaxmanager' path='themes/default/js/plugins/jquery.ajaxmanager.js' load='footer'}
  {combine_script id='thumbnails.loader' path='themes/default/js/thumbnails.loader.js' require='jquery.ajaxmanager' load='footer'}
  {/if}
  <li class="odd{if ($smarty.foreach.catloop.iteration-1) % 2 == 0}0{else}1{/if}" {if ($stripped.albumFrame)}onclick="window.location='{$cat.URL}';"{/if}>
	<div class="thumbnailCategory">
		<div class="illustration">
			<a href="{$cat.URL}">
        <img {if $derivative->is_cached()}src="{$derivative->get_url()}"{else}src="{$ROOT_URL}{$themeconf.icon_dir}/img_small.png" data-src="{$derivative->get_url()}"{/if} alt="{$cat.TN_ALT}" title="{$cat.NAME|@replace:'"':' '|@strip_tags:false} - {'display this album'|@translate}">
			</a>
		</div>
		<div class="description">
			<h3>
				<a href="{$cat.URL}">{$cat.NAME}</a>
				{if !empty($cat.icon_ts)}
				<img title="{$cat.icon_ts.TITLE}" src="{$ROOT_URL}{$themeconf.icon_dir}/recent{if $cat.icon_ts.IS_CHILD_DATE}_by_child{/if}.png" alt="(!)">
				{/if}
			</h3>
			<div class="text" {if !$stripped.albumFrame}onclick="window.location='{$cat.URL}';"{/if}>
				  {if isset($cat.INFO_DATES) }
				  <p class="dates">{$cat.INFO_DATES}</p>
				  {/if}
				  <p class="Nb_images">{$cat.CAPTION_NB_IMAGES}</p>
				  {if not empty($cat.DESCRIPTION)}
				  <p>{$cat.DESCRIPTION}</p>
				  {/if}
			</div>
		</div>
	</div>
  </li>
  {/foreach}
</ul>
