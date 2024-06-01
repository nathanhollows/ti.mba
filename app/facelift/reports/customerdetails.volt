<META http-equiv="Content-type" content="text/html; charset=iso-8859-1">
<style type="text/css">
body {
  font-family: Helvetica, Arial, Sans-Serif;
  font-size: 10px;
}
table {
  font-size: 10px;
}
th {
  text-align: left;
}
.qr-wrapper {
	line-height: 1.5em;
  display: flex;
  align-items: flex-start;
  justify-content: space-around;
}
.qr-wrapper img {
  width: 25mm;
  height: 25mm;
}
@media print {
  footer {
    page-break-after: always;
  }
}
</style>

{{ content() }}
{% for customer in customers %}
  <h2>{{ customer.name }}</h2>
  <hr>
  <table width="100%">
    <tbody>
      <tr>
        <td width="50%">
          <table width="100%">
            <tbody>
              <tr>
                <th>Phone</th>
                <td>{{ customer.phone }}</td>
              </tr>
              <tr>
                <th>Status</th>
                <td>{{ customer.state.name }}</td>
              </tr>
              <tr>
                <th>Fax</th>
                <td>{{ customer.fax }}</td>
              </tr>
              <tr>
                <th>Area</th>
                <td>
                  {% if customer.salesarea.name is defined %}
                    {{ customer.salesarea.name }}
                  {% else %}
                    <em>Not set</em>
                  {% endif %}
                </td>
              </tr>
              <tr>
                <th>Email</th>
                <td>{{ customer.email }}</td>
              </tr>
              <tr>
                <th>Account Manager</th>
                <td>
                  {% if customer.salesarea.rep.name is defined %}
                    {{ customer.salesarea.rep.name }}
                  {% else %}
                    <em>Not set</em>
                  {% endif %}
                </td>
              </tr>
            </tbody>
          </table>
        </td>
        <td width="50%">
              {% for address in customer.addresses %}
                {% if address.type.typeDescription == "Delivery" %}
                      <div class="qr-wrapper">
                        <div>
						<strong>Delivery Address</strong><br>
                          {% if address.line1 %}{{ address.line1 }}<br>{% endif %}
                          {% if address.line2 %}{{ address.line2 }}<br>{% endif %}
                          {% if address.line3 %}{{ address.line3 }}<br>{% endif %}
                          {% if address.city %}{{ address.city }}{% if address.zipCode %}, {{ address.zipCode }}{% endif %}{% endif %}
                        </div>
                        <img src="{{ address.getQRUrl() }}" alt="QR Code to Map">
                      </div>
                {% endif %}
              {% endfor %}
        </td>
      </tr>
    </tbody>
  </table>
  <hr>
  <table width="100%">
    <thead>
      <tr>
        <th>Contact Name</th>
        <th>Position</th>
        <th>Direct Dial</th>
        <th>Email</th>
      </tr>
    </thead>
    <tbody>
      {% for contact in customer.contacts %}
        <tr>
          <td>{{ contact.name }}</td>
          <td>
            {% if contact.position is not null and contact.position is not numeric %}
              {{ contact.position }}
            {% else %}
              {% if contact.job.name %} {{ contact.job.name }} {% endif %}
            {% endif %}
          </td>
          <td>{{ contact.directDial }}</td>
          <td>{{ contact.email }}</td>
        </tr>
      {% endfor %}
    </tbody>
  </table>
  {% if not loop.last %}
    <footer></footer>
  {% endif %}
{% endfor %}
<script type="text/javascript">
  window.print();
</script>
