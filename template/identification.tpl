<div class="titrePage">
	<div class="browsePath">
		<h2>
			{if isset($MENUBAR)}
				<span id="menuswitcher" title="{'Show/hide menu'|@translate}">{'Menu'|@translate}</span><span class="arrow"> »</span>
			{/if}
			<a href="{$U_HOME}">{'Home'|@translate}</a>
			{$LEVEL_SEPARATOR}{'Identification'|@translate}
		</h2>
	</div>
</div>
<div id="content">
	{if isset($MENUBAR)}{$MENUBAR}{/if}
	<div id="content_cell">
		<div class="content_block">
			{include file='infos_errors.tpl'} 
			<form action="{$F_LOGIN_ACTION}" method="post" name="login_form">
				<fieldset>
					<legend>{'Connection settings'|@translate}</legend>
					<input type="hidden" name="redirect" value="{$U_REDIRECT|urlencode}">
					<ul>
						<li>
							<span class="property">
								<label for="username">{'Username'|@translate}</label>
							</span>
							<input tabindex="1" class="login" type="text" name="username" id="username" size="25">
						</li>
						<li>
							<span class="property">
								<label for="password">{'Password'|@translate}</label>
							</span>
							<input tabindex="2" class="login" type="password" name="password" id="password" size="25">
						</li>
						{if $authorize_remembering }
							<li>
								<span class="property">
									<label for="Auto login">{'Auto login'|@translate}</label>
								</span>
								<input tabindex="3" type="checkbox" name="remember_me" id="remember_me" value="1">
							</li>
						{/if}
					</ul>
				</fieldset>
				<p><input class="submit" tabindex="4" type="submit" name="login" value="{'Submit'|@translate}"></p>
				<p>
					{if isset($U_REGISTER) }
						<a href="{$U_REGISTER}" title="{'Register'|@translate}">{'Register'|@translate}</a>&nbsp;-
					{/if}
					<a href="{$U_LOST_PASSWORD}" title="{'Forgot your password?'|@translate}">{'Forgot your password?'|@translate}</a>
				</p>
			</form>
			<script type="text/javascript">
				<!--
				document.login_form.username.focus();
				//-->
			</script>
		</div>
	</div>
</div> <!-- content -->