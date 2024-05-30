<div class="container">
    <div class="row">
      <h4 class="py-3 pl-3">Committed Stock</h4>
      <div class="col-md-12 bg-white rounded p-0 rounded-lg ">
        <table class="table table-hover table-bordered m-0">
          <thead class="thead-dark sticky-top">
            <tr>
              <th scope="col">Treat</th>
              <th scope="col">Size</th>
              <th scope="col">Random</th>
              <th scope="col">Other</th>
              <th scope="col">3.6m</th>
              <th scope="col">4.8m</th>
              <th scope="col">6.0m</th>
              <th scope="col">7.2m</th>
              <th scope="col">Order</th>
              <th scope="col">Customer</th>
              <th scope="col">Date</th>
            </tr>
          </thead>
          <tbody>
            {% for grade, lines  in grades %}
            <tr class="table-secondary sticky-top {% if loop.first %}shadow-sm{% endif %}" style="top: 3em;">
              <th scope="row" colspan="11">{{ grade }}</th>
            </tr>
            {% if lines|length == 0 %}
              <tr class="table-active">
                <td colspan="11" class="text-center">Nothing on order</td>
              </tr>
            {% endif %}

            {% set border = 1 %}
            {% set size = "" %}

            {% for line in lines %}
              {% set line["size"] = line["width"] ~ "x" ~ line["thickness"] %}

              {% if size != line["size"] %}
                {% set border *= -1 %}
                {% set size = line["size"] %}
              {% endif %}

              <tr class="
                {% if line['treatment'] == "H6" %}table-warning{% endif %}
                {% if border > 0 %}size-border{% set border *= -1%}{% endif %}
                ">
                <th scope="row">
                  {{ line["treatment"]}}
                </th>
                <td>{{ line["width"] }}x{{ line["thickness"] }}</td>
                <td class="text-right">
                  {% if line["random"] != 0 %}
                    {{ line["random"] }}m
                  {% endif %}
                </td>
                <td>{{ line["other"] }}</td>
                <td class="text-center">
                  {% if line["3.6m"] != 0 %}
                    {{ line["3.6m"] }}
                  {% endif %}
                </td>
                <td class="text-center">
                  {% if line["4.8m"] != 0 %}
                    {{ line["4.8m"] }}
                  {% endif %}
                </td>
                <td class="text-center">
                  {% if line["6.0m"] != 0 %}
                    {{ line["6.0m"] }}
                  {% endif %}
                </td>
                <td class="text-center">
                  {% if line["7.2m"] != 0 %}
                    {{ line["7.2m"] }}
                  {% endif %}
                </td>
                <td>{{ linkTo("/orders/?order=" ~ line["orderNumber"], line["orderNumber"]) }}</td>
                <td>{{ linkTo("/customers/view/" ~ line["customerCode"], line["customer"]) }}</td>
                <td>
                  {% if line["age"] > 100 %}
                  <span class="text-danger" title="Ordered {{ line['date']|timeAgoDate }}">{{ line['formattedDate'] }}</span>
                  {% else %}
                  {{ line['formattedDate'] }}
                  {% endif %}
                </td>
              </tr>
            {% endfor %}
            {% endfor %}
          </tbody>
        </table>
      </div>
    </div>
</div>

<style>
  th, td {
    border-top: none;
    border-bottom: none;
  }
  .size-border th, .size-border td {
    border-top: 3px solid #dee2e6;
  }
  .dropdown-menu {
    z-index: 1021;
  }
  .table-secondary:hover, .table-secondary:hover td, .table-secondary:hover th{
    background-color: #d6d8db !important;
  }
  .table-active, .table-active > td, .table-active > th {
    background-color: rgba(0, 0, 0, 0.04);
  }
  .table-hover .table-active:hover > td, .table-hover .table-active:hover > th {
    background-color: unset;
  }
</style>