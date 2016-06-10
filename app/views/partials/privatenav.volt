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

		</div>
		<div id="navbar" class="collapse navbar-collapse">
			{{ elements.getPrivateMenu() }}
		</div><!--/.nav-collapse -->
	</div>
</nav>
{% if noHeader is empty %}
<div class="page-header">

  <h2>
  {% if pageTitle is not empty %}
  	{{ pageTitle }}
  {% else %}
  	{{ router.getControllerName()|capitalize }} 
  {% endif %}
  
  {% if pageSubtitle is not empty %}
  	<small>{{ pageSubtitle }}</small>
  {% else %}
  	<small>{{ router.getActionName()|capitalize }}</small>
  {% endif %}

{% if headerButton is not empty %}
	{{ headerButton }}
{% endif %}

  </h2>
</div>
{% endif %}
<div class="container-fluid">