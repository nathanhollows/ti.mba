{#
    This report cycles through the 6 queries from the controller
    As each column in each row is printed a total is calculated
    The `total` variable is then reset for the next loop
    Other variables are defined for calculating the percentages for the year, for example
#}

<div class="header py-3 no-print">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h4 class="header-title">Annual Sales Report</h4>
			</div>
			<div class="col text-right">
				<div class="btn-group">
					<a href="/reports/annual/{{ date("Y", strtotime("- 1 YEAR", strtotime(start)))}}" class="btn btn-info">{{ emicon("arrow-left") }} {{ date("Y", strtotime("- 1 YEAR", strtotime(start)))}}</a>
					<a href="/reports/annual/{{ date("Y", strtotime("+ 1 YEAR", strtotime(start)))}}" class="btn btn-info">{{ date("Y", strtotime("+ 1 YEAR", strtotime(start)))}} {{ emicon("arrow-right") }}</a>
				</div>
				<div class="btn-group pull-right">
					<button type="button" class="btn btn-primary" onclick="window.print();">
						{{ emicon("printer") }}
						Print
					</button>
				</div>
			</div>
			</ hr>
		</div>
	</div>
</div>

<div class="container no-print">
	<div class="row">
		<div class="col">
			{{ content() }}
		</div>
	</div>
</div>

<div class="container-fluid">
<div class="row">
<div class="col">
<table class="table table-hover table-sm shadow-sm bg-white w-100 table-striped" id="report">
    <thead>
        <th style="text-align: left">
			Sales Report Apr {{ date ("Y", strtotime(start)) }} - Mar {{ date("Y", strtotime(start ~ " + 1 YEAR")) }}
        </th>
        {% for i in 1..12 %}
            <th>{{ date('M', strtotime( start ~ ' + ' ~ loop.index0 ~ ' MONTHS')) }}</th>
        {% endfor %}
        <th>Total</th>
    </thead>
    <tbody>
        <tr>
            <td class="table-header">
                Days in Month
            </td>
            {% set total = 0 %}
            {% for i in 0..11 %}
                <td>
                    {% if budget|length > i %}
                        <a href="#" class="xedit" id="days" data-type="text" data-placement="bottom" data-pk="{{ budget[i]['date'] }}" data-url="/budget/update/" data-title="Days in Month">{{ budget[i]['days'] }}</a>
                        {% set total += budget[i]['days'] %}
                    {% else %}
                        <a href="#" class="xedit" id="days" data-type="text" data-placement="bottom" data-url="/budget/update/" data-pk="{{ date("Y-m-d", strtotime(start ~ " + " ~ i ~ " MONTHS")) }}" data-title="Days in Month"></a>
                    {% endif %}
                </td> 
            {% endfor %}
            <td>
                <b>{{ total }}</b>
            </td>
            {% set total = 0 %}
        </tr>
        <tr>
            <td class="table-header">
                Sales
            </td>
            {% for i in 1..13 %}
                <td></td>
            {% endfor %}
        </tr>

        <tr>
            <td>
                Monthly Budget
            </td>
            {% for i in 0..11 %}
                <td>
                    {% if budget|length > i %}
                        $<a href="#" class="xedit" id="budget" data-type="text" data-placement="bottom" data-pk="{{ budget[i]['date'] }}" data-url="/budget/update/" data-title="Budget">
                            {% if budget[i]['budget'] == 0 %} {% else %}{{ budget[i]['budget']|number }}
                            {% endif %}
                        </a>
                        {% set total += budget[i]['budget'] %}
                    {% else %}
                        <a href="#" class="xedit" id="budget" data-type="text" data-placement="bottom" data-url="/budget/update/" data-pk="{{ date("Y-m-d", strtotime(start ~ " + " ~ i ~ " MONTHS")) }}" data-title="Budget"></a>
                    {% endif %}
                </td> 
            {% endfor %}
            <td>
                <b>${{ total|number }}</b>
            </td>
            {% set total = 0 %}
        </tr>

        <tr>
            <td>
                YTD Budget
            </td>
            {% set total = 0 %}
            {% for key, i in budget %}
                {% set total += i['budget'] %}
                <td>${{ total|number }}</td>
                {% if key is salesOut|length - 1 %}
                    {% set budgetYTDnow = total %}
                {% endif %}
            {% endfor %}
            {% if budget|length != 12 %}
                {% for i in 1..12 - budget|length %}
                    <td class="null-value">-</td>
                {% endfor %}
            {% endif %}
            <td class="null-value">-</td>
            {% set total = 0 %}

        </tr>

        <tr>
            <td>
                Order Count
            </td>
            {% set total = 0 %}
            {% for i in orderCount %}
                <td>
                    {% if i.count > 0 %}{{ i.count }}{% else %}-{% endif %}
                </td>
                {% set total += i.count %}
            {% endfor %}
            {% if orderCount|length != 12 %}
                {% for i in 1..12 - orderCount|length %}
                    <td class="null-value">-</td>
                {% endfor %}
            {% endif %}
            <td>
                <b>{{ total|number }}</b>
            </td>
            {% set totalOrderCount = total %}
            {% set total = 0 %}
        </tr>

        <tr>
            <td>
                Sales In
            </td>
            {% for i in orderCount %}
                <td>
                    {% if i.sumatory > 0 %}${{ i.sumatory|number }}{% else %}-{% endif %}
                </td>
                {% set total += i.sumatory %}
            {% endfor %}
            {% if orderCount|length != 12 %}
                {% for i in 1..12 - orderCount|length %}
                    <td class="null-value">-</td>
                {% endfor %}
            {% endif %}
            <td>
                <b>${{ total|number }}</b>
            </td>
        </tr>

        <tr>
            <td>
                Average Order Value
            </td>
            {% for i in orderCount %}
                <td>
                    {% if i.average > 0 %}
                    ${{ i.average|number }}
                    {% else %}-{% endif %}
                </td>
            {% endfor %}
            <td>
                {% if orderCount|length == 0 %}
                    <b>$0</b>
                {% else %}
                    <b>${{ (total / totalOrderCount)|number }}</b>
                {% endif %}
            </td>
            {% set total = 0 %}
        </tr>

        <tr>
            <td>
                Sales Out
            </td>
            {% set salesYTD = [] %}
            {% for i in 0..11 %}
				{% if salesOut[i] is defined %}
					<td>${{ salesOut[i].salesOut|number }}</td>
					{% set total += salesOut[i].salesOut %}
					{% set salesYTD[loop.index] = salesOut[i].salesOut %}
				{% else %}
                    <td class="null-value">-</td>
				{% endif %}
            {% endfor %}
            <td>
                <b>${{ total|number }}</b>
            </td>
        </tr>

        <tr>
            <td>
                Sales Out YTD
            </td>
            {% set YTD = 0 %}
            {% for i, k in salesYTD %}
                {% set YTD = YTD + k %}
                <td>${{ YTD|number }}</td>
            {% endfor %}
            {% if salesOut|length != 12 %}
                {% for i in 1..12 - salesOut|length %}
                    <td class="null-value">-</td>
                {% endfor %}
            {% endif %}
            <td class="null-value">-</td>
            {% set salesYTDnow = total %}
            {% set total = 0 %}
        </tr>

        <tr>
            <td>
                Monthly Budget Variance %
            </td>
            {% set var = 0 %}
            {% for i, k in salesOut %}
                {% if k.salesOut == 0 or budget[loop.index0]['budget'] == 0 %}
                <td>-</td>
                {% else %}
                <td>{{ ((k.salesOut / budget[loop.index0]['budget'] * 100) - 100 )|number }}%</td>
                {% endif %}
            {% endfor %}
            {% if salesOut|length != 12 %}
                {% for i in 1..12 - salesOut|length %}
                    <td class="null-value">-</td>
                {% endfor %}
            {% endif %}
            <td>
                {% if salesYTDnow != 0 and budgetYTDnow != 0 %}
                    <b>{{ ((salesYTDnow / budgetYTDnow * 100) - 100)|number }}%</b>
                {% else %}
                    <b>-</b>
                {% endif %}
            </td>
            {% set total = 0 %}
        </tr>

        <tr>
            <td class="table-header">
                Quotes
            </td>
            {% for i in 1..13 %}
                <td></td>
            {% endfor %}
        </tr>

        <tr>
            <td>Quotes Presented</td>
            {% for i in quotesPresented %}
			{% if i.year == date("Y") and i.month > date("m") 
				or i.year > date("Y") %}
					<td>-</td>
					{% continue %}
				{% endif %}
                <td>{{ i.count }}</td>
                {% set total += i.count %}
            {% endfor %}
            <td>
                <b>{{ total|number }}</b>
            </td>
            {% set presented = total %}
            {% set total = 0 %}
        </tr>

        <tr>
            <td>Quotes Won</td>
			{% for i in quotesWon %}
				{% if i.year == date("Y") and i.month > date("m") 
					or i.year > date("Y") %}
					<td>-</td>
					{% continue %}
				{% endif %}
				<td>{{ i.count }}</td>
				{% set total += i.count%}
			{% endfor %}
            <td>
                <b>{{ total|number }}</b>
				{% set won = total %}
            </td>
        </tr>

        <tr>
            <td>Percentage Won</td>
			{% for i in 0..11 %}
				{% if quotesPresented[i].count == 0 or quotesWon[i].count == 0 %}
					<td class="null-value">-</td>
				{% else %}
					<td>{{ (quotesWon[i].count / quotesPresented[i].count * 100)|number }}%</td>
				{% endif %}
			{% endfor %}
            <td>
                {% if won == 0 or presented == 0 %}
                <b>-</b>
                {% else %}
                <b>{{ (won / presented * 100)|number }}%</b>
                {% endif %}
            </td>
            {% set total = 0 %}
        </tr>

        <tr>
            <td class="table-header">
                Sales by Agent
            </td>
            {% for i in 1..13 %}
                <td></td>
            {% endfor %}
        </tr>
        {% set excess = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0} %}
        {% for key, i in sales %}
        {% set monthcounter = date('n', strtotime(start)) %}
        {% if year == 2018 %}
            {% if key in ['Brad Simmons', 'Dave Hollows', 'Jan Roberts', 'Courtney Lawry'] %}
                {% for m, n in i %}
                    {% set excess[m - 1] += n %}
                {% endfor %}
                {% continue %}
            {% endif %}
            {% if key == 'Fax' %}
                <tr>
                    <td>{{ key }}</td>
                    {% for j in 1..12 %}
                        {% if monthcounter == 13 %}
                            {% set monthcounter = 1 %}
                        {% endif %}
                        {% if i[monthcounter] is defined %}
                            <td>${{ (i[monthcounter] + excess[monthcounter - 1])|number }}</td>
                            {% set total += i[monthcounter] + excess[monthcounter - 1] %}
                        {% else %}
                            <td class="null-value">-</td>
                        {% endif %}
                        {% set monthcounter = monthcounter + 1 %}
                    {% endfor %}
                    <td><b>${{ total|number }}</b></td>
                    {% set total = 0 %}
                </tr>
                {% continue %}
            {% else %}
            <tr>
                <td>{{ key }}</td>
                {% for j in 1..12 %}
                    {% if monthcounter == 13 %}
                        {% set monthcounter = 1 %}
                    {% endif %}
                    {% if i[monthcounter] is defined %}
                        <td>${{ i[monthcounter]|number }}</td>
                        {% set total += i[monthcounter] %}
                    {% else %}
                        <td class="null-value">-</td>
                    {% endif %}
                    {% set monthcounter = monthcounter + 1 %}
                {% endfor %}
                <td><b>${{ total|number }}</b></td>
                {% set total = 0 %}
            </tr>
            {% endif %}
        {% else %}
        <tr>
            <td>{{ key }}</td>
            {% for j in 1..12 %}
                {% if monthcounter == 13 %}
                    {% set monthcounter = 1 %}
                {% endif %}
                {% if i[monthcounter] is defined %}
                    <td>${{ i[monthcounter]|number }}</td>
                    {% set total += i[monthcounter] %}
                {% else %}
                    <td class="null-value">-</td>
                {% endif %}
                {% set monthcounter = monthcounter + 1 %}
            {% endfor %}
            <td><b>${{ total|number }}</b></td>
            {% set total = 0 %}
        </tr>
        {% endif %}
        {% endfor %}

    </tbody>
</table>
</div>
</div>
</div>
<div class="no-print">

<style>
#report {
	font-size: 0.9em;
}
.table-sm td, .table-sm th {
    padding: 0.4rem 0.3em;
}
#report tr td:nth-child(1n+2) {
    text-align: right;
}
#report tr td:nth-child(1):not(.table-header) {
    padding-left: 24px;
}
#report td.table-header {
    text-transform: uppercase;
    font-weight: bold;
}
#report tr td:nth-child(1) {
    color: black;
    background: rgba(0, 0, 0, 0.05);
    white-space: nowrap;
}
#report th {
    text-align: right;
}
.datepicker.datepicker-dropdown.dropdown-menu {
    background: white;
}
@media print {
    @page {
        size: landscape
    }
    .no-print {
        display: none;
    }
    table#report  * {
        visibility: visible;
    }
    .table>tbody>tr>td, .table>tbody>tr>th, .table>tfoot>tr>td, .table>tfoot>tr>th, .table>thead>tr>td {
        padding: 8px 3px 8px 3px;
    }
    table#report  {
        position: absolute;
        left: 0;
        top: 0;
        font-size: 10px;
    }
    tr {
        background-color: yellow;
        -webkit-print-color-adjust: exact;
    }
    .xedit {
        background: none;
        border-bottom: none;    
	}
	.editable-click, a.editable-click, a.editable-click:hover {
		color: inherit;
		border: none;
	}
}
</style>

<script>
	$(document).ready(function() {
        $('.xedit').editable();
    });
</script>
