<nav class="navbar navbar-default navbar-fixed-top">
      <div class="container">
        <div class="navbar-header">
          <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar" aria-expanded="false" aria-controls="navbar">
            <span class="sr-only">Toggle navigation</span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
          </button>
          {{ link_to('', constant('SITE_TITLE'), 'class': 'navbar-brand')}}
        </div>
        <div id="navbar" class="collapse navbar-collapse">
          <ul class="nav navbar-nav">
            <li class="active">{{ link_to('', 'Home')}}</li>
            <li>{{ link_to('about', 'About')}}</li>
            <li>{{ link_to('contact', 'Contact')}}</li>
          </ul>
          <ul class="nav navbar-nav pull-right">
            {% if not(logged_in is empty) %}
               <li><li>{{ link_to('dashboard', 'Dashboard')}}</li>
               {{ link_to('logout','Logout', 'class': 'btn btn-default navbar-btn PULL-RIGHT')}}
            {% else %}
                {{ link_to('login','Sign In', 'class': 'btn btn-default navbar-btn')}}
            {% endif %}
          </ul>
        </div><!--/.nav-collapse -->
      </div>
    </nav>
    <div class="container">
    