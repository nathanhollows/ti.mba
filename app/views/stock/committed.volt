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
          {% for grade, lines in grades %}
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
                {% if line['treatment'] == " H6" %}table-warning{% endif %} {% if border> 0 %}size-border{% set border
            *= -1%}{% endif %}
            ">
            <th scope="row">
              {{ line["treatment"]}}
            </th>
            <td>
              {{ line["width"] ~ "x" ~ line["thickness"] }}
            </td>
            <td class="text-center">
              {% if line["random"] != 0 %}
              {{ partial("stockcheck", {"line": line, "random": line["random"]}) }}
              {% endif %}
            </td>
            <td>{{ line["other"] }}</td>
            <td class="text-center">
              {% if line["3.6"] != 0 %}
              {{ partial("stockcheck", {"line": line, "length": "3.6", "pieces": line["3.6"]}) }}
              {% endif %}
            </td>
            <td class="text-center">
              {% if line["4.8"] != 0 %}
              {{ partial("stockcheck", {"line": line, "length": "4.8", "pieces": line["4.8"]}) }}
              {% endif %}
            </td>
            <td class="text-center">
              {% if line["6.0"] != 0 %}
              {{ partial("stockcheck", {"line": line, "length": "6.0", "pieces": line["6.0"]}) }}
              {% endif %}
            </td>
            <td class="text-center">
              {% if line["7.2"] != 0 %}
              {{ partial("stockcheck", {"line": line, "length": "7.2", "pieces": line["7.2"]}) }}
              {% endif %}
            </td>
            <td>{{ linkTo("/orders/?order=" ~ line["orderNumber"], line["orderNumber"]) }}</td>
            <td>{{ linkTo("/customers/view/" ~ line["customerCode"], line["customer"]) }}</td>
            <td>
              {% if line["age"] > 100 %}
              <span class="text-danger" title="Ordered {{ line['date']|timeAgoDate }}">{{ line['formattedDate']
                }}</span>
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



<script>
  document.addEventListener('DOMContentLoaded', () => {
    // Function to check stock status and append class if in stock
    async function checkStockStatus() {
      const maxConcurrentRequests = 10;
      let currentRequests = 0;
      const queue = [];

      // Select all anchor elements with the class 'stock-check'
      const stockCheckLinks = document.querySelectorAll('span.stock-check');

      // Function to process a single link
      const processLink = async (link) => {
        try {
          const url = link.getAttribute('data-url');
          const response = await fetch(url);
          const data = await response.json();

          if (data.inStock === "1") {
            link.classList.add('text-success');
          }
        } catch (error) {
          console.error('Error fetching stock status:', error);
        } finally {
          currentRequests--;
          if (queue.length > 0) {
            const nextLink = queue.shift();
            processLink(nextLink);
          }
        }
      };

      // Iterate over each link and manage concurrency
      stockCheckLinks.forEach((link) => {
        if (currentRequests < maxConcurrentRequests) {
          currentRequests++;
          processLink(link);
        } else {
          queue.push(link);
        }
      });
    }

    // Call the function to check stock status
    checkStockStatus();
  });
</script>