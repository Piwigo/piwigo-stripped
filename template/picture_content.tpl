{assign var=derivative value=$pwg->derivative($stripped.imageSize, $current.src_image)}

{if ((!isset($stripped.HDlightbox)) or ($stripped.HDlightbox))}
	{assign var='HDlightbox' value=true}
{/if}

{if isset($HDlightbox)}
	{if ($stripped.hdSize == 'original')}
		{if isset($U_ORIGINAL)}
			{assign var='displayHD' value=true}
			{assign var='HD_url' value=$U_ORIGINAL}
		{else}
			{foreach from=$current.unique_derivatives item=deriv key=derivative_type}
				{if ($deriv->get_type() == 'Original')}
					{assign var='HD_url' value=$deriv->get_url()}
					{if ($deriv->get_size() != $derivative->get_size())}
						{assign var='displayHD' value=true}
					{/if}
				{/if}
			{/foreach}
		{/if}
	{else}
		{assign var='HDderivative' value=$pwg->derivative($stripped.hdSize, $current.src_image)}
		{assign var='HD_url' value=$HDderivative->get_url()}
		{if (($HDderivative->get_size() != $derivative->get_size()) or ($stripped.hdSize == $stripped.imageSize))}
			{assign var='displayHD' value=true}
		{/if}
	{/if}
	{if ($stripped.forceLightboxOn)}
		{assign var='displayHD' value=true}
		{if !isset($HD_url)}
			{assign var='HD_url' value=$derivative->get_url()}
		{/if}
	{/if}
	{if isset($displayHD)}
		{if ($HDShadowbox_loaded)}
			{assign var='pwghigh' value=true}
		{else}
			{assign var='winhigh' value=true}
		{/if}
	{/if}
{/if}

<div id="theImg" {if ($stripped.imageFrame)}class="img_frame"{/if}>
	{if isset($displayHD)}
		{if isset($pwghigh)}<a href="{$HD_url}" rel="shadowbox" class="hd_link">&nbsp;</a>{/if}
		{if isset($winhigh)}<div onclick="openDisplayHigh('{$HD_url}');" class="hd_link">&nbsp;</div>{/if}
		{if ($stripped.imagePreloadHD)}<div class="preload" style="display:none;">{$HD_url}</div>{/if}
	{/if}
	{if ($stripped.imageArrows) }
		{if isset($U_UP)}
			<a href="{$U_UP}" class="img_nav cat_up" alt="{'Thumbnails'|@translate}">&nbsp;</a>
		{/if}
		{if isset($previous)}
			<a href="{$previous.U_IMG}" class="img_nav img_prev" alt="{$previous.TITLE}">&nbsp;</a>
		{/if}
		{if isset($next)}
			<a href="{$next.U_IMG}" class="img_nav img_next" alt="{$next.TITLE}">&nbsp;</a>
		{/if}
	{/if}
	<img src="{$derivative->get_url()}" {$derivative->get_size_htm()} alt="{$ALT_IMG}" id="theMainImage" class="hideTabs">
</div>
