</div>
<div class="jumbotron">
	<div class="container">
		<h1>Forgot your password?</h1>
		<p>We'll send you a new one.. for free!</p>
	</div>
</div>

<div class="container">

{{ content() }}

{{ form() }}

	<div class="form-group">
		{{ form.label('Email' )}}
		{{ form.render('Email') }}
	</div>

	<div class="form-group">
		{{ form.render('Send') }}
	</div>

</form>