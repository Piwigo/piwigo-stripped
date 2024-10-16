<div class="titrePage">
	<div class="browsePath">
		<h2>{'Search rules'|@translate}</h2>
	</div>
	<div class="categoryActionsContainer">
		<ul class="categoryActions">
			<li><a href="#" onclick="window.close();" title="{'Close this window'|@translate}" class="pwg-state-default pwg-button">
				<span class="pwg-icon pwg-icon-close">&nbsp;</span><span class="pwg-button-text">{'Close this window'|@translate}</span>
			</a></li>
		</ul>
	</div>
</div>
<div id="content">
	<div id="content_cell">
		<div class="content_block">
			{if isset($INTRODUCTION) }
				<p>{$INTRODUCTION}</p>
			{/if}
			<ul>
				{if isset($search_words) }
					{foreach from=$search_words item=v}
						<li>{$v}</li>
					{/foreach}
				{/if}
				{if isset($SEARCH_TAGS_MODE) }
					<li>
						<p>{if 'AND'==$SEARCH_TAGS_MODE}{'At least one tag must match'|@translate}{else}{'At least one tag must match'|@translate}{/if}</p>
						<ul>
							{foreach from=$search_tags item=v}
								<li>{$v}</li>
							{/foreach}
						</ul>
					</li>
				{/if}
				{if isset($DATE_CREATION) }
					<li>{$DATE_CREATION}</li>
				{/if}
				{if isset($DATE_AVAILABLE) }
					<li>{$DATE_AVAILABLE}</li>
				{/if}
				{if isset($search_categories) }
					<li>
						<p>{'Categories'|@translate}</p>
						<ul>
							{foreach from=$search_categories item=v}
								<li>{$v}</li>
							{/foreach}
						</ul>
					</li>
				{/if}
			</ul>
		</div>
	</div>
</div> <!-- content -->
