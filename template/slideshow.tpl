{html_head}
{literal}
<style>#footer {display: none;}</style>
{/literal}
{/html_head}
{assign var=derivative value=$pwg->derivative($stripped.imageSize, $current.src_image)}
{assign var='size' value=$derivative->get_size()}
{literal}
<script type="text/javascript">
var image_w = {/literal}{$size[0]}{literal}
var image_h = {/literal}{$size[1]}{literal}
</script>
{/literal}
<div id="light_slideshow">

	<div class="titrePage" id="imageHeaderBar">
		<div class="browsePath">
			&nbsp;
		</div>
	    <ul class="randomButtons">
			<li id="imageToolBar">
				{include file='picture_nav_buttons.tpl'|@get_extent:'picture_nav_buttons'}
			</li>
		</ul>
		<div style="clear: both;"></div>
	</div> <!-- imageHeaderBar -->

	<div id="content">
		{assign var='display_description_tab' value=false}
		{if (empty($stripped.showDescriptionInsteadOfTitle) && isset($COMMENT_IMG))}
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
			<div id="theImageBox">
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
						{$COMMENT_IMG|strip_tags:false}
					{/if}
					{if ($stripped.imageCaption == 'title' )}
						{$current.TITLE}
					{/if}
				</div></div>
			{/if}
		</div> <!-- theImage -->
		<div style="clear: both;"></div>
	</div>

</div>