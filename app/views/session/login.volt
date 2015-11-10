</div>

<div class="jumbotron">
	<div class="container">
		<h1>Login</h1>
	</div>
</div>

<div class="container">

{{ content() }}

{{ form() }}

	<div class="form-group">
		{{ form.label('email') }}
		{{ form.render('email') }}
	</div>
	
	<div class="form-group">
		{{ form.label('password') }}
		{{ link_to("forgotpassword", "Forgot your password?", 'tabindex': '-1') }}
		{{ form.render('password') }}
	</div>

	{{ form.render('Login') }}

	<div align="center" class=" form-group remember">
		{{ form.render('remember') }}
		{{ form.label('remember') }}
	</div>
	
	{{ form.render('csrf', ['value': security.getToken()]) }}

</form>