<form class="form-signin" method="post">

  <img class="mb-4" src="/img/logo.svg" alt="" width="72" height="72">
  <h1 class="h3 mb-3 font-weight-normal">Log in</h1>
    {{ flashSession.output() }}
    {{ flash.output() }}
    {{ content() }}
  <label for="email" class="sr-only">Email address</label>
    {{ form.render('email') }}
  <label for="inputPassword" class="sr-only">Password</label>
    {{ form.render('password') }}
    {{ form.render('csrf', ['value': security.getToken()]) }}
    {{ form.render('Login') }}
</form>
