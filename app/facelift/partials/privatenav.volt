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

				<a href="/search" class="navbar-brand pull-right visible-xs"><i class="fa fa-icon fa-search"></i></a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            {{ elements.getPrivateMenu() }}
                <form class="navbar-form navbar-right hidden-xs" role="search" action="/search/" method="post" target="_blank">
                    <div id="search">
                        <div class="form-group search">
                            <input type="text" class="form-control search" placeholder="Search" name="q" autocomplete="off">
                        </div>
                        <button type="submit" class="btn btn-primary search"><i class="fa fa-icon fa-search"></i></button>
                    </div>
                </form>
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
    <div class="clear"></div>
    {% if pageSubheader is not empty %}
        <div class="header-links">
        {% for i in pageSubheader %}
            <span class="subinfo">
                {% if i['icon'] %}
                    <i class="fa fa-icon fa-{{ i['icon'] }}"></i>
                {% endif %}
                {% if i['link'] is defined %}
                    <a href="{{ i['link'] }}" {% if i['link-class'] is defined %} class="{{ i['link-class'] }}"{% endif %}>
                {% endif %}
                {% if i['text'] %}
                    {{ i['text'] }}
                {% endif %}
                {% if i['link'] is defined %}
                    </a>
                {% endif %}
            </span>
        {% endfor %}
        </div>
    {% endif %}
</div>
{% else %}
<div class="header-padding"></div>
</div>
{% endif %}
<div class="container-fluid">
