<h2> Sign up </h2>

{{ form("auth/register") }}

 	<legend>Sign up</legend>
 
 	<div class="form-group">
 		<label for="name">Name</label>
 		{{ text_field('name', 'placeholder': 'Joe Bloggs', 'class': 'form-control')}}
 	</div> 

 	<div class="form-group">
 		<label for="email">Email</label>
 		{{ email_field('email', 'placeholder': 'joe.bloggs@example.com', 'class': 'form-control')}}
 	</div>
 
 	<div class="form-group">
 		<label for="password">Password</label>
 		{{ password_field('password', 'placeholder': '****', 'class': 'form-control')}}
 	</div>
 	
 	{{ submit_button('Submit', 'class': 'btn btn-primary')}}

 </form>