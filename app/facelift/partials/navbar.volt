<nav class="navbar navbar-expand-lg navbar-light bg-white border-bottom mb-3">
    <div class="container">
        <a class="navbar-brand" href="{{ url('dashboard') }}">
            <img src="/img/logo.svg" width="30" height="30" class="d-inline-block align-top" alt="">
            {{ constant('SITE_TITLE') }}
        </a>
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

