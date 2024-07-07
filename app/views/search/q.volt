<div class="container">
    <div class="row">
        <div class="col">
            <h3>Search</h3>
            <form class="" action="/search/" method="post" id="search-form">
                <div class="input-group">
                    <input type="text" class="form-control" name="q" value="{{ query }}" autocomplete="off" autofocus="true" accesskey="s">
                    <span class="input-group-append">
                        <button class="btn btn-primary" type="submit">{{ emicon('search') }}</button>
                    </span>
                </div>
            </form>
            {{ content() }}
            {{ flashSession.output() }}
            <div class="row mt-3">
                <div class="col-md-6">
                    <h4>Customers</h4>
                    <div class="list-group shadow-sm mb-4">
                        {% if customers|length == 0 %}
                        <div class="list-group list-group-item list-group-item-action">
                            <em>No customers found</em>
                            <div class="text-muted">Try searching for something else</div>
                        </div>
                        {% else %}
                        {% for customer in customers %}
                        <a href="{{ url('customers/view/' ~ customer.customerCode) }}" class="list-group-item list-group-item-action d-flex justify-content-between align-items-center">
                            <div>
                                {% if customer._highlightResult %}
                                <strong class="d-block">{{ customer._highlightResult.customerCode.value }}</strong>
                                <span>{{ customer._highlightResult.name.value }}</span>
                                {% else %}
                                <strong class="d-block">{{ customer.customerCode }}</strong>
                                <span>{{ customer.name }}</span>
                                {% endif %}
                            </div>
                            <span class="text-right text-muted">{{ customer.phone }}</span>
                        </a>
                        {% endfor %}
                        {% endif %}
                    </div>
                </div>
                <div class="col-md-6">
                    <h4>Contacts</h4>
                    <div class="list-group shadow-sm mb-4">
                        {% if contacts|length == 0 %}
                        <div class="list-group list-group-item">
                            <em>No contacts found</em>
                            <div class="text-muted">Try searching for something else</div>
                        </div>
                        {% else %}
                        {% for contact in contacts %}
                        <div class="list-group-item">
                            <div class="d-flex justify-content-between">
                                <div>
                                    {% if contact._highlightResult %}
                                    <strong>{{ contact._highlightResult.name.value }}</strong><br>
                                    <small class="text-muted">{{ contact._highlightResult.role.value }}</small><br>
                                    <small class="text-muted">{{ link_to('customers/view/' ~ contact.customerCode, contact._highlightResult.company.value) }}</small>
                                    {% else %}
                                    <strong>{{ contact.name }}</strong><br>
                                    <small class="text-muted">{{ contact.role }}</small><br>
                                    <small class="text-muted">Company: {{ link_to('customers/view/' ~ contact.customerCode, contact.company) }}</small>
                                    {% endif %}
                                </div>
                                <div class="text-right">
                                    <a href="tel:{{ contact.directDial|stripspace }}" class="tel-link">{{ contact.directDial }}</a><br>
                                    <a href="mailto:{{ contact.email }}">{{ contact.email }}</a>
                                </div>
                            </div>
                        </div>
                        {% endfor %}
                        {% endif %}
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<style>
    body {
        overflow-y: scroll;
    }
    table em, ul em, .list-group-item em {
        text-decoration: underline;
        font-style: normal;
    }
    .customer-code {
        min-width: 8ch;
    }
    .tel-link {
        color: #007bff;
    }
    .tel-link:hover {
        text-decoration: underline;
    }
    .list-group-item {
        padding: 1rem;
    }
    .list-group-item strong {
        font-size: 1.1rem;
    }
    .list-group-item .text-muted {
        font-size: 0.9rem;
    }
    .list-group-item .float-right {
        font-size: 0.9rem;
    }
</style>
<script>
    $(document).ready(function() {
        // Any JavaScript necessary for handling tabs or other interactive features can go here
    });
</script>
