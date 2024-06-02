<div class="container">
<br />
    {% if not token %}
        <h1>Reset Password</h1>
        {{ content() }}
    {% else %}
    	<h2 class="form-signin-heading">Reset Password</h2>
        {{ content() }}
        <br />
    	<p>Enter your new password twice and you're good to go.</p>
        <br />

    	<div class="form-group">
            <label for="password">Password</label>
            {{ password_field('password', 'class': 'form-control') }}
    	</div>

    	<div class="form-group">
            <label for="password2">Repeat Password</label>
            {{ password_field('password2', 'class': 'form-control') }}
    	</div>

    	<div class="form-group">
            {{ submit_button('Submit', 'class': 'btn btn-primary') }}
    	</div>
    {% endif %}

</div>

<style media="screen">
.container {
    max-width: 426px;
}
</style>
