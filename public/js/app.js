<div class="container">
    <div class="row">
        <div class="col">
            <h3>Search</h3>
            <form class="" action="/search/" method="post">
                <div class="input-group">
                    <input type="text" class="form-control" name="q" value="{{ query }}" autocomplete="off" autofocus="true" accesskey="s">
                    <span class="input-group-append">
                        <button class="btn btn-primary" type="submit">Go!</button>
                    </span>
                </div>
            </form>
            {{ content() }}
            {{ flashSession.output() }}
            {% if not noResults %}

            {% set custl = customers|length %}
            {% set contl = contacts|length %}
            {% if custl >= contl %}{% set active = "pills-customers" %}
            {% elseif contl >= custl %}{% set active = "pills-contacts" %}
            {% endif %}

            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
                <li class="nav-item ml-n3">
                    <strong class="nav-link">Filter Results</strong>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" id="pills-customers-tab" data-toggle="pill" href="#pills-customers" role="tab" aria-controls="pills-customers" aria-selected="true">Customers <span class="badge badge-primary">{{ customers|length }}</span></a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" id="pills-contacts-tab" data-toggle="pill" href="#pills-contacts" role="tab" aria-controls="pills-contacts" aria-selected="false">Contacts <span class="badge badge-primary">{{ contacts|length }}</span></a>
                </li>
            </ul>
            <div class="tab-content" id="pills-tabContent">
                <div class="tab-pane fade show active" id="pills-customers" role="tabpanel" aria-labelledby="pills-customers-tab">
                    <h4>Customers</h4>
                    <ul class="list-group shadow-sm">
                        {% for customer in customers %}
                        <li class="list-group-item">
                            {% if customer._highlightResult is defined %}
                                {{ link_to('customers/view/' ~ customer.customerCode, customer._highlightResult.name.value | raw) }}
                            {% else %}
                                {{ link_to('customers/view/' ~ customer.customerCode, customer.name) }}
                            {% endif %}
                            <span class="float-right">
                                <a href="tel:{{ customer.phone|stripspace }}" class="tel-link">{{ customer.phone }}</a>
                            </span>
                        </li>
                        {% endfor %}
                    </ul>
                </div>
                <div class="tab-pane fade" id="pills-contacts" role="tabpanel" aria-labelledby="pills-contacts-tab">
                    <h4>Contacts</h4>
                    <div class="card card-sm shadow-sm">
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
                                        {% if contact._highlightResult is defined %}
                                            {{ link_to('contacts/view/' ~ contact.id, contact._highlightResult.name.value | raw) }}
                                        {% else %}
                                            {{ link_to('contacts/view/' ~ contact.id, contact.name) }}
                                        {% endif %}
                                    </td>
                                    <td>
                                        {% if contact._highlightResult is defined %}
                                            {{ contact._highlightResult.company.value | raw }}
                                        {% else %}
                                            {{ contact.company.name }}
                                        {% endif %}
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
            </div>
            {% endif %}
        </div>
    </div>
    <div class="row">
        <div class="col">
            {% if not noTerm and noResults %}
            <h4>Nothing found for <code>{{ query|e }}</code></h4>
            {% endif %}
        </div>
    </div>
</div>
<style>
    body {
        overflow-y: scroll;
    }
	table em, ul em {
		text-decoration: underline;
		font-style: normal;
	}
</style>
<script>
    $( document ).ready(function() {
        $('#pills-tab a[href="#{{ active }}"]').tab('show') // Select tab by name
    });
</script>
