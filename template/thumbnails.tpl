{footer_script}
  var error_icon = "{$ROOT_URL}{$themeconf.icon_dir}/errors_small.png", max_requests = {$maxRequests};
{/footer_script}
{if !empty($thumbnails)}{strip}
<ul class="thumbList">
	{foreach from=$thumbnails item=thumbnail}
  {assign var=derivative value=$pwg->derivative($stripped.thumbSize, $thumbnail.src_image)}
  {if !$derivative->is_cached()}
  {combine_script id='jquery.ajaxmanager' path='themes/default/js/plugins/jquery.ajaxmanager.js' load='footer'}
  {combine_script id='thumbnails.loader' path='themes/default/js/thumbnails.loader.js' require='jquery.ajaxmanager' load='footer'}
  {/if}
		<li>
			<span class="wrap1">
				<span class="wrap2 {if !($stripped.showThumbLegend)}wrap2full{/if}">
					<a href="{$thumbnail.URL}"><div class="thumbframe"><div class="thumbpos">
						<img class="thumbnail" {if $derivative->is_cached()}src="{$derivative->get_url()}"{else}src="{$ROOT_URL}{$themeconf.icon_dir}/img_small.png" data-src="{$derivative->get_url()}"{/if} alt="{$thumbnail.TN_ALT}" title="{$thumbnail.TN_TITLE}">
						{if (isset($stripped.imagePreload) & isset($stripped.imagePreloadThumbs))}
							{assign var=preload value=$pwg->derivative($stripped.imageSize, $thumbnail.src_image)}
							<div class="preload" style="display:none;">{$preload->get_url()}</div>
						{/if}
					</div></div></a>
				</span>
				<span class="thumbLegend {if !($stripped.showThumbLegend)}noLegend{/if}">
					<span class="thumbCaption">{if isset($thumbnail.NAME)}{$thumbnail.NAME}{/if}</span>
					{if !empty($thumbnail.icon_ts)}
						<img title="{$thumbnail.icon_ts.TITLE}" src="{$ROOT_URL}{$themeconf.icon_dir}/recent.png" class="icon" alt="(!)">
					{/if}
					<div class="thumbStats">
						{if isset($thumbnail.NB_COMMENTS)}
							<span class="{if 0==$thumbnail.NB_COMMENTS}zero {/if}nb-comments">
								{$thumbnail.NB_COMMENTS|translate_dec:'%d comment':'%d comments'}
							</span>
						{/if}
						{if isset($thumbnail.NB_HITS)}
							<span class="{if 0==$thumbnail.NB_HITS}zero {/if}nb-hits">
								{$thumbnail.NB_HITS|translate_dec:'%d hit':'%d hits'}
							</span>
						{/if}
					</div>
				</span>
			</span>
		</li>
	{/foreach}
</ul>
{/strip}{/if}
