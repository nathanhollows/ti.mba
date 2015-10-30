{{ form('session/start', 'class': 'form-signin' ) }}

<h2 class="form-signin-heading">Please sign in</h2>
 
    <label for="inputEmail" class="sr-only">Email address</label>
    {{ email_field('email', 'placeholder': 'Email address', 'class': 'form-control', 'id': 'inputEmail', 'required': '', 'autofocus': '')}}
 
    <label for="inputPassword" class="sr-only">Password</label>
    {{ password_field('password', 'placeholder': 'Password', 'class': 'form-control', 'id': 'inputEmail', 'required': '')}}

    <div class="checkbox">
      <label>
        <input type="checkbox" value="remember-me"> Remember me
      </label>
    </div>
  
  {{ submit_button('Sign in', 'class': 'btn btn-lg btn-primary btn-block')}}

</form>
