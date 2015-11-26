<nav class="navbar navbar-inverse navbar-fixed-top">
	<div class="container-fluid">
		<div class="navbar-header">
			<button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
				<span class="sr-only">Toggle navigation</span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
				<span class="icon-bar"></span>
			</button>
			{{ link_to('dashboard', constant('SITE_TITLE'), 'class': 'navbar-brand')}}
			<ul class="nav navbar-nav">
				<li class="dropdown">
					{{ link_to('customers', 'Customers <span class="caret"></span>', 'class': 'dropdown-toggle', 'data-toggle': 'dropdown', 'role': 'button', 'aria-haspopup': 'true', 'aria-expanded': 'true')}}
					<ul class="dropdown-menu">
						<li>{{ link_to('customers','Search')}}</li>
						<li role="separator" class="divider"></li>
						<li>{{ link_to('customers\Search','View')}}</li>
					</ul>
				</li>
				<li class="dropdown">
					{{ link_to('orders', 'Orders <span class="caret"></span>', 'class': 'dropdown-toggle', 'data-toggle': 'dropdown', 'role': 'button', 'aria-haspopup': 'true', 'aria-expanded': 'true')}}
					<ul class="dropdown-menu">
						<li>{{ link_to('orders','Search')}}</li>
						<li role="separator" class="divider"></li>
						<li>{{ link_to('orders\Search','View')}}</li>
					</ul>
				</li>
			</ul>

		</div>
		<div id="navbar" class="collapse navbar-collapse">
			<ul class="nav navbar-nav navbar-right">
				<li class="dropdown">
					<a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">{{ auth.getname() }} <span class="caret"></span></a>
					<ul class="dropdown-menu">
						<li>{{ link_to('preferences','Preferences')}}</li>
						<li role="separator" class="divider"></li>
						<li>{{ link_to('logout','Logout')}}</li>
					</ul>
				</li>
			</ul>
		</div><!--/.nav-collapse -->
	</div>
</nav>
<div class="container-fluid">