<div class="login-page">
    {{ flashSession.output() }}
    {{ content() }}
    <div class="form">
        <h1 class="form-signin-heading">Forgot your password?</h1>
        <form class="login-form" method="post">
            {{ form.render('Email') }}
            {{ form.render('Send') }}
            <p class="message">{{ link_to("login", "Login instead", 'tabindex': '-1') }}</p>
        </form>
    </div>
</div>
