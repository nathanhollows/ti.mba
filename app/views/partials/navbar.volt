<nav class="navbar navbar-expand-lg navbar-dark bg-dark mb-3">
    <div class="container">
        <a class="navbar-brand" href="{{ url('dashboard') }}">
            <img src="/img/logo.svg" width="30" height="30" class="d-inline-block align-top" alt="">
            <span class="d-none d-sm-inline">
            {{ constant('SITE_TITLE') }}
            </span>
        </a>
        
        <form class="search-form form-inline my-2 my-lg-0 d-lg-none d-sm-block" style="flex-grow: 0.5;" action="/search/q/" method="post" autocomplete="off">
            <input type="search" class="search-nav form-control w-100" placeholder="Search" aria-label="Search" name="query" style="background: rgba(255, 255, 255, 0.1); color: white; border: 1px solid rgba(255, 255,255, 0.2);">

            <button type="submit" style="color: white; margin-left: -3em;" class="btn btn-sm">
                {{ emicon('search') }}
            </button>
        </form>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse justify-content-between" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                {{ elements.getNavLeft() }}
            </ul>
            <ul class="navbar-nav">
                {{ elements.getNavRight() }}
            </ul>
        </div>
    </div>
</nav>
<ul id="search-results" class="list-group shadow d-md-none"></ul>

