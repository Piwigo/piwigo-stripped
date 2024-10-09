<div class="titrePage">
	<h2>stripped Theme - Configuration</h2>
</div>

<form method="post" class="properties" action="" ENCTYPE="multipart/form-data" name="form" class="properties">
	<div>
		<fieldset>
			<legend>{'Interface options'|@translate}</legend>
			<ul>
				<li><label>
					<span class="property">{'Interface style'|@translate}</span>&nbsp;
					<select name="f_themeStyle" style="min-width:200px;">
						<option value="original" {if ($options.themeStyle=="original")}selected{/if}>original</option>
						<option value="black" {if ($options.themeStyle=="black")}selected{/if}>black</option>
						<option value="white" {if ($options.themeStyle=="white")}selected{/if}>white</option>
					</select>
				</label></li>
				<li><label>
					<span class="property">{'Hide menu by default on category page'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_hideMenu" {if $options.hideMenu}checked{/if}>
				</label></li>
				<li><label>
					<span class="property">{'Animate menu'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_animatedMenu" {if $options.animatedMenu}checked{/if}>
				</label></li>
				<li><label>
					<span class="property">{'Force text to lowercase'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_forceLowercase" {if !($options.noLowercase)}checked{/if}>
				</label></li>
				<li><label>
					<span class="property">{'Album list layout'|@translate}</span>&nbsp;
					<select name="f_albumType" style="min-width:150px;">
						<option value="small" {if ($options.albumType=="small")}selected{/if}>{'5 albums per row (no album description)'|@translate}</option>
						<option value="3perline" {if ($options.albumType=="3perline")}selected{/if}>{'3 albums per row (description below thumbnail)'|@translate}</option>
						<option value="2perline" {if ($options.albumType=="2perline")}selected{/if}>{'2 albums per row (description beside thumbnail)'|@translate}</option>
						<option value="1perline" {if ($options.albumType=="1perline")}selected{/if}>{'1 album per row (description beside thumbnail)'|@translate}</option>
					</select>
				</label></li>
				<li><label>
					<span class="property">{'Display frame around albums'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_albumFrame" {if $options.albumFrame}checked{/if}>
				</label></li>
				<li><label>
					<span class="property">{'Display frame around thumbnails'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_thumbFrame" {if $options.thumbFrame}checked{/if}>
				</label></li>
				<li><label>
					<span class="property">{'Show thumbnail caption'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_showThumbLegend" {if $options.showThumbLegend}checked{/if}>
				</label></li>
			</ul>
		</fieldset>
		<fieldset>
			<legend>{'Picture page options'|@translate}</legend>
			<ul>
				<li><label>
					<span class="property">{'Show image title on top of the page (after browse path)'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_showTitleOnBrowsePath" {if $options.showTitleOnBrowsePath}checked{/if}>
				</label></li>
				<li><label>
					<span class="property">{'Display frame around image'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_imageFrame" {if $options.imageFrame}checked{/if}>
				</label></li>
				<li><label>
					<span class="property">{'Use navigation arrows on picture'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_imageArrows" {if $options.imageArrows}checked{/if}>
				</label></li>
				<li><label>
					<span class="property">{'Use navigation arrows outside picture'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_navArrows" {if $options.navArrows}checked{/if}>
				</label></li>
				<li><label>
					<span class="property">{'Property to display below picture'|@translate}</span>&nbsp;
					<select name="f_imageCaption" style="min-width:200px;">
						<option value="none">-----</option>
						<option value="title" {if ($options.imageCaption=="title")}selected{/if}>{'Title'|@translate}</option>
						<option value="description" {if ($options.imageCaption=="description")}selected{/if}>{'Description'|@translate}</option>
					</select>
				</label></li>
				<li><label>
					<span class="property">{'Activate HD picture lightbox'|@translate}</span>&nbsp;
					<select name="f_lightboxOptions" style="min-width:200px;">
						<option value="never" {if !($options.HDlightbox)}selected{/if}>{'never'|@translate}</option>
						<option value="hdonly" {if (($options.HDlightbox) &! ($options.forceLightboxOn))}selected{/if}>{'if HD picture available'|@translate}</option>
						<option value="always" {if (($options.HDlightbox) && ($options.forceLightboxOn))}selected{/if}>{'always'|@translate}</option>
					</select>
				</label></li>
				<li><label>
					<span class="property">{'HD picture default display'|@translate}</span>&nbsp;
					<select name="f_defaultZoomSize" style="min-width:200px;">
						<option value="fit" {if ($options.defaultZoomSize=="fit")}selected{/if}>{'fit to screen'|@translate}</option>
						<option value="full" {if ($options.defaultZoomSize=="full")}selected{/if}>{'full size'|@translate}</option>
					</select>
				</label></li>
				<li><label>
					<span class="property">{'Default tab to be displayed'|@translate}</span>&nbsp;
					<select name="f_defaultTab" style="min-width:200px;">
						<option value="none">-----</option>
						<option value="last" {if ($options.defaultTab=="last")}selected{/if}>{'Last displayed'|@translate}</option>
						<option value="caption" {if ($options.defaultTab=="caption")}selected{/if}>{'Description'|@translate}</option>
						<option value="tags" {if ($options.defaultTab=="tags")}selected{/if}>{'Tags'|@translate}</option>
						<option value="meta0" {if ($options.defaultTab=="meta0")}selected{/if}>{'Metadata'|@translate}</option>
						<option value="info" {if ($options.defaultTab=="info")}selected{/if}>{'Informations'|@translate}</option>
						<option value="comments" {if ($options.defaultTab=="comments")}selected{/if}>{'Comments'|@translate}</option>
					</select>
				</label></li>
				<li><label>
					<span class="property">{'Animate tabs on picture page'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_animatedTabs" {if $options.animatedTabs}checked{/if}>
				</label></li>
				<li><label>
					<span class="property">{'Show Information tab only to admins'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_infoTabAdminOnly" {if $options.infoTabAdminOnly}checked{/if}>
				</label></li>
			</ul>
		</fieldset>
		<fieldset>
			<legend>{'Photo sizes'|@translate}</legend>
			<ul>
				<li><label>
					<span class="property">{'Album thumbnail size'|@translate}</span>&nbsp;
					<select name="f_albumSize" style="min-width:200px;">
						<option value="square" {if ($options.albumSize=="square")}selected{/if}>{'square'|@translate}</option>
						<option value="thumb" {if ($options.albumSize=="thumb")}selected{/if}>{'thumb'|@translate}</option>
						<option value="2small" {if ($options.albumSize=="2small")}selected{/if}>{'2small'|@translate}</option>
						<option value="xsmall" {if ($options.albumSize=="xsmall")}selected{/if}>{'xsmall'|@translate}</option>
						<option value="small" {if ($options.albumSize=="small")}selected{/if}>{'small'|@translate}</option>
						<option value="medium" {if ($options.albumSize=="medium")}selected{/if}>{'medium'|@translate}</option>
						<option value="large" {if ($options.albumSize=="large")}selected{/if}>{'large'|@translate}</option>
						<option value="xlarge" {if ($options.albumSize=="xlarge")}selected{/if}>{'xlarge'|@translate}</option>
						<option value="xxlarge" {if ($options.albumSize=="xxlarge")}selected{/if}>{'xxlarge'|@translate}</option>
					</select>
				</label></li>
				<li><label>
					<span class="property">{'Thumbnail size'|@translate}</span>&nbsp;
					<select name="f_thumbSize" style="min-width:200px;">
						<option value="square" {if ($options.thumbSize=="square")}selected{/if}>{'square'|@translate}</option>
						<option value="thumb" {if ($options.thumbSize=="thumb")}selected{/if}>{'thumb'|@translate}</option>
						<option value="2small" {if ($options.thumbSize=="2small")}selected{/if}>{'2small'|@translate}</option>
						<option value="xsmall" {if ($options.thumbSize=="xsmall")}selected{/if}>{'xsmall'|@translate}</option>
						<option value="small" {if ($options.thumbSize=="small")}selected{/if}>{'small'|@translate}</option>
						<option value="medium" {if ($options.thumbSize=="medium")}selected{/if}>{'medium'|@translate}</option>
						<option value="large" {if ($options.thumbSize=="large")}selected{/if}>{'large'|@translate}</option>
						<option value="xlarge" {if ($options.thumbSize=="xlarge")}selected{/if}>{'xlarge'|@translate}</option>
						<option value="xxlarge" {if ($options.thumbSize=="xxlarge")}selected{/if}>{'xxlarge'|@translate}</option>
					</select>
				</label></li>
				<li><label>
					<span class="property">{'Image size'|@translate}</span>&nbsp;
					<select name="f_imageSize" style="min-width:200px;">
						<option value="square" {if ($options.imageSize=="square")}selected{/if}>{'square'|@translate}</option>
						<option value="thumb" {if ($options.imageSize=="thumb")}selected{/if}>{'thumb'|@translate}</option>
						<option value="2small" {if ($options.imageSize=="2small")}selected{/if}>{'2small'|@translate}</option>
						<option value="xsmall" {if ($options.imageSize=="xsmall")}selected{/if}>{'xsmall'|@translate}</option>
						<option value="small" {if ($options.imageSize=="small")}selected{/if}>{'small'|@translate}</option>
						<option value="medium" {if ($options.imageSize=="medium")}selected{/if}>{'medium'|@translate}</option>
						<option value="large" {if ($options.imageSize=="large")}selected{/if}>{'large'|@translate}</option>
						<option value="xlarge" {if ($options.imageSize=="xlarge")}selected{/if}>{'xlarge'|@translate}</option>
						<option value="xxlarge" {if ($options.imageSize=="xxlarge")}selected{/if}>{'xxlarge'|@translate}</option>
					</select>
				</label></li>
				<li><label>
					<span class="property">{'HD Image size'|@translate}</span>&nbsp;
					<select name="f_hdSize" style="min-width:200px;">
						<option value="square" {if ($options.hdSize=="square")}selected{/if}>{'square'|@translate}</option>
						<option value="thumb" {if ($options.hdSize=="thumb")}selected{/if}>{'thumb'|@translate}</option>
						<option value="2small" {if ($options.hdSize=="2small")}selected{/if}>{'2small'|@translate}</option>
						<option value="xsmall" {if ($options.hdSize=="xsmall")}selected{/if}>{'xsmall'|@translate}</option>
						<option value="small" {if ($options.hdSize=="small")}selected{/if}>{'small'|@translate}</option>
						<option value="medium" {if ($options.hdSize=="medium")}selected{/if}>{'medium'|@translate}</option>
						<option value="large" {if ($options.hdSize=="large")}selected{/if}>{'large'|@translate}</option>
						<option value="xlarge" {if ($options.hdSize=="xlarge")}selected{/if}>{'xlarge'|@translate}</option>
						<option value="xxlarge" {if ($options.hdSize=="xxlarge")}selected{/if}>{'xxlarge'|@translate}</option>
						<option value="original" {if ($options.hdSize=="original")}selected{/if}>{'original'|@translate}</option>
					</select>
				</label></li>
			</ul>
		</fieldset>
		<fieldset>
			<legend>{'Image autosize options'|@translate}</legend>
			<ul>
				<li><label>
					<span class="property" >{'Resize image to fit window'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_imageAutosize" {if $options.imageAutosize}checked{/if}>
				</label></li>
			</ul>
			<fieldset style="width:80%; margin:auto;">
				<ul>
					<li>
						<label for="imageAutosizeMargin"><span class="property">{'Additional bottom margin after resize'|@translate}</span>&nbsp;</label>
						<input type="text" id="imageAutosizeMargin" name="f_imageAutosizeMargin" size="1" maxlength="3" value="{$options.imageAutosizeMargin}" style="text-align:center;">&nbsp;px
					</li>
					<li>
						<label for="imageAutosizeMinHeight"><span class="property">{'Minimum image height after resize'|@translate}</span>&nbsp;</label>
						<input type="text" id="imageAutosizeMinHeight" name="f_imageAutosizeMinHeight" size="1" maxlength="3" value="{$options.imageAutosizeMinHeight}" style="text-align:center;">&nbsp;px
					</li>
				</ul>
			</fieldset>
		</fieldset>
		<fieldset>
			<legend>{'Image preloading options'|@translate}</legend>
			<ul>
				<li><label>
					<span class="property" >{'Activate image preloading'|@translate}</span>&nbsp;
					<input type="checkbox" name="f_imagePreload" {if $options.imagePreload}checked{/if}>
				</label></li>
			</ul>
			<fieldset style="width:80%; margin:auto;">
				<ul>
					<li><label>
						<span class="property">{'On picture page, number of next images to preload'|@translate}</span>&nbsp;
						<select name="f_imagePreloadNb" style="min-width:150px;">
							<option value=1 {if ($options.imagePreloadNb==1)}selected{/if}>1</option>
							<option value=2 {if ($options.imagePreloadNb==2)}selected{/if}>2</option>
							<option value=3 {if ($options.imagePreloadNb==3)}selected{/if}>3</option>
							<option value=4 {if ($options.imagePreloadNb==4)}selected{/if}>4</option>
							<option value=5 {if ($options.imagePreloadNb==5)}selected{/if}>5</option>
							<option value=6 {if ($options.imagePreloadNb==6)}selected{/if}>6</option>
							<option value=7 {if ($options.imagePreloadNb==7)}selected{/if}>7</option>
							<option value=8 {if ($options.imagePreloadNb==8)}selected{/if}>8</option>
							<option value=9 {if ($options.imagePreloadNb==9)}selected{/if}>9</option>
							<option value=10 {if ($options.imagePreloadNb==10)}selected{/if}>10</option>
						</select>
					</label></li>
					<li><label>
						<span class="property">{'Preload images on thumbnails page'|@translate}</span>&nbsp;
						<input type="checkbox" name="f_imagePreloadThumbs" {if $options.imagePreloadThumbs}checked{/if}>
					</label></li>
				</ul>
			</fieldset>
		</fieldset>
	</div>
	<p><input class="submit" type="submit" value="{'Submit'|@translate}" name="submit_stripped" /></p>
</form>
