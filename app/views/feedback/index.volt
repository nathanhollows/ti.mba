<div class="header py-3">
    <div class="container">
        <div class="row header-body">
            <div class="col">
                <h4 class="header-title">Feedback</h4>
            </div>
            <div class="col text-right">
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col">
            {% for f in feedback %}
            <div class="card my-5 shadow-lg">
                <div class="card-body">
                    {% if f.opinion %}{{ f.opinion }}{% endif %}
                    <blockquote class="blockquote">
                        <p class="mb-0">{{ f.feedback }}</p>
                        <footer class="blockquote-footer">{{ f.rep.name }}</footer>
                    </blockquote>
                    Created {{ f.time|timeAgo() }}
                    <strong>
                        {{ linkTo(f.uri, f.uri) }}
                    </strong>
                </div>
            </div>
            {% endfor %}
        </div>
    </div>
</div>

{{ content() }}