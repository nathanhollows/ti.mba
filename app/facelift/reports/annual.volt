{#
    This report cycles through the 6 queries from the controller
    As each column in each row is printed a total is calculated
    The `total` variable is then reset for the next loop
    Other variables are defined for calculating the percentages for the year, for example
#}
{{ content() }}
<div class="row no-print">
    <div class="col-xs-12 col-sm-12 col-md-12 col-lg-12">
        <div class="btn-group">
        <a href="/reports/annual/{{ date("Y", strtotime("- 1 YEAR", strtotime(start)))}}" class="btn btn-info"><i class="fa fa-arrow-left"></i> {{ date("Y", strtotime("- 1 YEAR", strtotime(start)))}}</a>
        <a href="/reports/annual/{{ date("Y", strtotime("+ 1 YEAR", strtotime(start)))}}" class="btn btn-info">{{ date("Y", strtotime("+ 1 YEAR", strtotime(start)))}} <i class="fa fa-arrow-right"></i></a>
        </div>
        <div class="btn-group pull-right">
            <button type="button" class="btn btn-default" onclick="window.print();">
                <i class="fa fa-icon fa-print"></i>
                Print
            </button>
        </div>
    </div>
</div>
<table class="table table-hover table-condensed table-responsive table-striped" id="report">
    <thead>
        <th style="text-align: left">
            Sales Report {{ date("Y", strtotime(start ~ " + 1 YEAR")) }}
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
                        <a href="#" class="xedit" id="budget" data-type="text" data-placement="bottom" data-pk="{{ budget[i]['date'] }}" data-url="/budget/update/" data-title="Budget">${{ budget[i]['budget']|number }}</a>
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
                <td>{{ i.count }}</td>
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
            {% set total = 0 %}
        </tr>

        <tr>
            <td>
                Sales In
            </td>
            {% for i in orderCount %}
                <td>${{ i.sumatory|number }}</td>
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
            {% set total = 0 %}
        </tr>

        <tr>
            <td>
                Average Order Value
            </td>
            {% for i in orderCount %}
                <td>${{ i.average|number }}</td>
                {% set total += i.average %}
            {% endfor %}
            {% if orderCount|length != 12 %}
                {% for i in 1..12 - orderCount|length %}
                    <td class="null-value">-</td>
                {% endfor %}
            {% endif %}
            <td>
                {% if orderCount|length == 0 %}
                    <b>$0</b>
                {% else %}
                    <b>${{ (total / orderCount|length)|number }}</b>
                {% endif %}
            </td>
            {% set total = 0 %}
        </tr>

        <tr>
            <td>
                Sales Out
            </td>
            {% set salesYTD = [] %}
            {% for i in salesOut %}
                <td>${{ i.salesOut|number }}</td>
                {% set total += i.salesOut %}
                {% set salesYTD[loop.index] = i.salesOut %}
            {% endfor %}
            {% if salesOut|length != 12 %}
                {% for i in 1..12 - salesOut|length %}
                    <td class="null-value">-</td>
                {% endfor %}
            {% endif %}
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
            {% if orderCount|length != 12 %}
                {% for i in 1..12 - orderCount|length %}
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
                <td>{{ ((k.salesOut / budget[loop.index0]['budget'] * 100) - 100 )|number }}%</td>
            {% endfor %}
            {% if salesOut|length != 12 %}
                {% for i in 1..12 - salesOut|length %}
                    <td class="null-value">-</td>
                {% endfor %}
            {% endif %}
            <td>
                {% if budgetYTDnow is defined %}
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
            {% set quotes = [] %}
            {% for i in quotesPresented %}
                <td>{{ i.count }}</td>
                {% set quotes[loop.index]['presented'] = i.count %}
                {% set total += i.count %}
            {% endfor %}
            {% if quotes|length != 12 %}
                {% for i in 1..12 - quotesPresented|length %}
                    <td class="null-value">-</td>
                {% endfor %}
            {% endif %}
            <td>
                <b>{{ total|number }}</b>
            </td>
            {% set total1 = total %}
            {% set total = 0 %}
        </tr>

        <tr>
            <td>Quotes Won</td>
            {% for i in quotesWon %}
                <td>{{ i.count }}</td>
                {% set quotes[loop.index]['won'] = i.count %}
                {% set total += i.count %}
            {% endfor %}
            {% if quotes|length != 12 %}
                {% for i in 1..12 - quotesWon|length %}
                    <td class="null-value">-</td>
                {% endfor %}
            {% endif %}
            <td>
                <b>{{ total|number }}</b>
            </td>
        </tr>

        <tr>
            <td>Percentage Won</td>
            {% for i in quotes %}
                <td>
                    {% if i['won'] is not defined %}
                        <td class="null-value">-</td>
                        {% break %}
                    {% endif %}
                    {% if i['presented'] is not defined %}
                        <td class="null-value">-</td>
                        {% break %}
                    {% endif %}
                    {{ (i['won'] / i['presented'] * 100)|number }}%</td>
            {% endfor %}
            {% if quotes|length != 12 %}
                {% for i in 0..(10 - quotes|length) %}
                    <td class="null-value">-</td>
                {% endfor %}
            {% endif %}
            <td>
                {% if total1 is not 0 %}
                <b>{{ (total / total1 * 100)|number }}%</b>
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
                    <td>${{ i[monthcounter]}}</td>
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

<style>
table:hover .editable-click, li:hover a.editable-click, li:hover a.editable-click:hover {
    background: #fff9b9;
    border-bottom: 1px dashed #f6bb42;
    margin-bottom: -1px;
}
table .xedit {
    color: #434A54;
    border: none;
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
.table-hover>tbody>tr:hover {
    background-color: #e2e2e2;
}
.datepicker.datepicker-dropdown.dropdown-menu {
    background: white;
}
input#datepicker {
    height: 0px;
    width: 0px;
    padding: 0;
    border: none;
    visibility: hidden;
    display: inline;
    margin-top: 10px;
}
#report {
    font-size: 14px;
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
        border-bottom: none;    }
}
</style>
