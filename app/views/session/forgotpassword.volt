<div class="container">

	{{ form('class': 'form-signin') }}
	{{ content() }}
	<h2 class="form-signin-heading">Forgot your password?</h2>
	<p>No worries! Just enter your email address below and we'll let you know what to do next!</p>

	<div class="form-group">
		{{ form.label('Email' )}}
		{{ form.render('Email') }}
	</div>

	<div class="form-group">
		{{ form.render('Send') }}
	</div>		
</form>

</div>