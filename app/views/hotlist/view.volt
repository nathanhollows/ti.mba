{{ form("", "autocomplete" : "off") }}
<div class="modal-body">
    {{ content() }}

    <p>
        <strong>
            <a href="#" class="xedit" id="category" data-type="select" data-placement="bottom" data-pk="{{ quote.id }}" data-url="/hotlist/update" data-title="Type of Quote" data-source="[{% for category in categories %}{% if loop.index0 is not 0 %},{% endif %}{value: {{ category.id }}, text: '{{ category.name }}'}{% endfor %}]" data-value="{{ quote.group.id }}">{{ quote.group.name }}</a>
        </strong>
         quoted via 
        <strong>
            <a href="#" class="xedit" id="type" data-type="select" data-placement="bottom" data-pk="{{ quote.id }}" data-url="/hotlist/update" data-source="[{% for type in types %}{% if loop.index0 is not 0 %},{% endif %}{value: {{ type.id }}, text: '{{ type.name }}'}{% endfor %}]" data-title="Quoted Via" data-value="{{ quote.origin.id }}">{{ quote.origin.name }}</a>
        </strong>
         estimated 
        <strong>
            $<a href="#" class="xedit" id="value" data-type="number" data-placement="bottom" data-pk="{{ quote.id }}" data-url="/hotlist/update" data-title="Estimated Value" data-value="{{ quote.value }}">{{ quote.value|number }}</a>
        </strong>
         for 
        <strong>
            <a href="#" class="xedit" id="customer" data-type="text" data-placement="bottom" data-pk="{{ quote.id }}" data-url="/hotlist/update" data-title="Customer" data-value="{{ quote.customer }}">{{ quote.customer }}</a>
        </strong>
    </p>
    <p>
        <a href="#" class="xedit" id="description" data-type="textarea" data-mode="inline" data-pk="{{ quote.id }}" data-url="/hotlist/update" data-title="Vailidity" data-onblur="submit">{{ quote.description|escape }}</a>
    </p>
    <br>
    <p>
        {% for note in quote.notes %}
            {{ note.comment }} {{ note.timestamp|timeAgo }}
        {% endfor %}
    </p>


</div>
</div>
