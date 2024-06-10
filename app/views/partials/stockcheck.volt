{% set params = {
"width": line["width"],
"thickness": line["thickness"],
"treatment": line["treatment"],
"grade": line["grade"]
} %}
{% if length is defined %}
{% set params["length"] = pieces %}
{% endif %}
{% if pieces is defined %}
{% set params["pieces"] = pieces %}
{% endif %}
{% if random is defined %}
{% set params["random"] = random %}
{% endif %}


{% set queryString = "" %}
{% for key, value in params %}
{% if loop.first %}
{% set queryString = "?" ~ key ~ "=" ~ value %}
{% else %}
{% if value is null %}
{% continue %}
{% endif %}
{% set queryString = queryString ~ "&" ~ key ~ "=" ~ value %}
{% endif %}
{% endfor %}

<span data-url="{{ url('stock/checkinstock' ~ queryString) }}" class="stock-check">
    {% if pieces is defined %}
    {{ pieces }}
    {% else %}
    {{ random }}m
    {% endif %}
</span>