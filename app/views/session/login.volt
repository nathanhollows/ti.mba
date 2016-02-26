<div class="container">

	{{ form('class': 'form-signin') }}
		{{ flashSession.output() }}
		{{ content() }}
		<h2 class="form-signin-heading">Please sign in</h2>

		{{ form.label('email', ['class': 'sr-only']) }}
		{{ form.render('email') }}
		{{ form.label('password', ['class': 'sr-only']) }}
		{{ form.render('password') }}

		<div class="checkbox">
			<label>
				{{ form.render('remember') }} Remember me
			</label>
		</div>

		{{ form.render('csrf', ['value': security.getToken()]) }}
		{{ form.render('Login') }}

		<br>

		{{ link_to("forgotpassword", "Forgot your password?", 'tabindex': '-1') }}
		
	</form>

</div>