<div class="row">
    <div class="col-hidden-xs col-hidden-sm col-md-6 col-lg-6 col-md-offset-3 col-lg-offset-3">
        <h3>Search</h3>
        <form class="" action="/search/" method="post">
            <div class="input-group">
                <input type="text" class="form-control" name="q" value="{{ query }}" autocomplete="off" autofocus="true" accesskey="s">
                <span class="input-group-btn">
                    <button class="btn btn-default" type="submit">Go!</button>
                </span>
            </div>
        </form>
        {{ content() }}
        {{ flashSession.output() }}
        {% if not noResults %}
            <strong>Filter Results</strong>
            <ul class="nav" id="tab-nav">
                <li class="active"><a data-toggle="tab" href="#customers">Customers <span class="badge">{{ customers|length }}</span></a></li>
                <li><a data-toggle="tab" href="#contacts">Contacts <span class="badge">{{ contacts|length }}</span></a></li>
                <li><a data-toggle="tab" href="#quotes">Quotes <span class="badge">{{ quotes|length }}</span></a></li>
            </ul>
        {% endif %}
    </div>
</div>
<div class="row">
    <div class="col-xs-12 col-md-12 col-md-12 col-lg-6 col-lg-offset-3 tab-content">
    {% if not noResults %}
        <div id="customers" class="tab-pane fade in active">
            <h4>Customers</h4>
            <ul class="list-group">
                {% for customer in customers %}
                <li class="list-group-item">{{ link_to('customers/view/' ~ customer.customerCode, customer.name) }}
				<span class="pull-right"><a href="tel:{{ customer.phone|stripspace }}" class="tel-link">{{ customer.phone }}</a></span> 
				</li>
                {% endfor %}
            </ul>
        </div>
        <div class="tab-pane fade" id="contacts">
            <h4>Contacts</h4>
            <div class="well well-sm">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Name</th>
                            <th>Branch</th>
                            <th class="hidden-xs">Phone</th>
                            <th class="hidden-xs">Email</th>
                        </tr>
                    </thead>
                    <tbody>
                    {% for contact in contacts %}
                    <tr>
                        <td>
                            {{ link_to('contacts/view/' ~ contact.id, contact.name) }}
                        </td>
                        <td>
                            {{ link_to('customers/view/' ~ contact.company.customerCode, contact.company.name) }}
                        </td>
                        <td class="hidden-xs">
                            <a href="tel:{{ contact.directDial|stripspace }}" class="tel-link">{{ contact.directDial|escape }}</a>
                        </td>
                        <td class="hidden-xs">
                            <a href="mailto:{{ contact.email }}">{{ contact.email|escape }}</a>
                        </td>
                    </tr>
                    {% endfor %}
                </tbody>
                </table>
            </div>
        </div>
        <div class="tab-pane fade" id="quotes">
            <h4>Quotes</h4>
            <ul class="list-group">
                {% for quote in quotes %}
                <li class="list-group-item">{{ link_to('quotes/view/'~ quote.quoteId, quote.quoteId) }} - {{ quote.reference|escape }} - {{ quote.customer.name|escape }}</li>
                {% endfor %}
            </ul>
        </div>
    {% else %}
        {% if noTerm %}

        {% else %}
            <h4>Nothing found for <code>{{ query|e }}</code></h4>
        {% endif %}
    {% endif %}
    </div>
</div>
<style media="screen">
#tab-nav {
    display: inline-block;
}
#tab-nav>li {
    display: inline-block;
}
#tab-nav>li>a {
    position: relative;
    display: block;
    padding: 10px 10px;
    color: #4f8cde;
}
li.active a {
    border-bottom: 3px solid;
}
.badge, .label {
    background-color: #4f8cde;
}
#tab-nav>li>a:focus, #tab-nav>li>a:hover {
    background: none;
}
</style>
<script type="text/javascript">
    $( document ).ready(function() {
        $('.collapse-btn').click(function() {
            $( this ).toggleClass('inactive');
        });
    })
</script>
