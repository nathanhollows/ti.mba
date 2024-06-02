<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">
            {{ record.reference }}
            <button type="button" data-record="{{ record.id }}" class="pull-right toggle-status btn btn-info btn-sm {% if record.completed is not null %}btn-success{% endif %}">Mark Complete</button>
        </h3>
    </div>
    <div class="panel-body">
        <strong>Company: </strong> <strong>{{ link_to('customers/view/' ~ record.company.customerCode, record.company.name ) }}</strong> <br />
        {% if record.person %}
            <strong>Contact: </strong> {{ record.person.name }} <br />
        {% endif %}
        <br />
        <strong>Type:</strong> {{ record.type.name }} <br />
        <strong>Date Created: &nbsp;&nbsp; </strong> {{ date("j M Y", strtotime(record.date)) }} <br />
        <strong>Follow Up Date:</strong>
        <span id="date" class="xedit editable editable-pre-wrapped editable-click editable-empty" data-title="Follow Up Date" data-type="date" data-pk="{{ record.id }}" data-url="/followup/newdate" data-placement="bottom" data-value="{{ record.followUpDate }}" data-onblur="submit">{{ date("j M Y", strtotime(record.followUpDate)) }}</span>
        <br />
        <br />
        <span id="details" class="xedit editable editable-pre-wrapped editable-click editable-empty" data-title="Details" data-type="textarea" data-mode="inline" data-pk="{{ record.id }}" data-url="/followup/ajaxupdate" data-onblur="submit">{{ parser.parse(record.details) }}</span>
    </div>
</div>

{% if record.quote is not null %}
{% set quote = record.quote %}
<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Quote Summary
            <div class="btn-group btn-group-sm pull-right">
                <a class="btn btn-info" href="/quotes/turntosale/{{ quote.quoteId }}" role="button">Job Won</a>
                <a class="btn btn-danger" href="/quotes/quotelost/{{ quote.quoteId }}" role="button">Job Lost</a>
            </div>
        </h3>
    </div>
    <div class="panel-body">
        <strong>Quote {{ link_to('quotes/view/' ~ quote.quoteId, quote.quoteId ~ ' ' ~ quote.reference) }}</strong> <br />
        <strong>Date</strong> {{ date('jS M Y', strtotime( quote.date )) }} <br />
        <strong>Value:</strong> ${{ quote.value|number }}<br />
        {% if quote.moreNotes %}
            <strong>Private Notes</strong> <br />
            {{ quote.moreNotes }} <br />
        {% endif %}
        {% if quote.notes %}
            <strong>Public Notes</strong> <br />
            {{ quote.notes }}
        {% endif %}
        <hr>
        {% for item in quote.items %}
            <strong>{{ loop.index }}.</strong> {{ item.width }} x {{ item.thickness }} {{ item.gra.name }} {{ item.treatment }} {{ item.dryness }} {% if item.fin %}{{ item.fin.name }}{% endif %}<br />
        {% endfor %}
    </div>
</div>
{% endif %}

<div class="panel panel-default">
    <div class="panel-heading">
        <h3 class="panel-title">Contacts</h3>
    </div>
    <div class="panel-body">
        {% if record.person %}
            {% set contact = record.person.id %}
            <strong>{{ record.person.name }}</strong>
            <br />
            {% if record.person.directDial %}
                <a href="tel:{{ record.person.directDial|stripspace }}" class="tel-link">{{ record.person.directDial }}</a>  <br />
            {% endif %}
            {% if record.person.email %}
                <a href="mailto:{{ record.person.email }}">{{ record.person.email }}</a>  <br />
            {% endif %}
            <hr>
        {% endif %}

        {% if record.quote %}
            {% if record.quote.customerContact %}
                {% if not record.person %}
                    {% set contact = 0 %}
                {% endif %}
                {% if record.quote.customerContact.id is not contact %}
                    <strong>{{ record.quote.customerContact.name }}</strong> <br />
                    {% if record.quote.customerContact.directDial %}
                        <a href="tel:{{ record.quote.customerContact.directDial|stripspace }}" class="tel-link">{{ record.quote.customerContact.directDial }}</a> <br />
                    {% endif %}
                    {% if record.quote.customerContact.email %}
                        <a href="mailto:{{ record.quote.customerContact.email }}">{{ record.quote.customerContact.email }}</a>  <br />
                    {% endif %}
                    <hr>
                {% endif %}
            {% elseif record.quote.attention %}
                <strong>{{ record.quote.attention }}</strong> <br />
                No details available
                <hr>
            {% endif %}
        {% endif %}

        <strong>{{ record.company.name }}</strong> <br />
        {% if record.company.phone %}
        <a href="tel:{{ record.company.phone|stripspace }}" class="tel-link">{{ record.company.phone }}</a>
        {% endif %} <br />
        {% if record.company.email %}
        <a href="mailto:{{ record.company.email }}">{{ record.company.email }}</a>
        {% endif %} <br />
    </div>
</div>
