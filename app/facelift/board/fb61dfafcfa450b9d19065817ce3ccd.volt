{{ content() }}

<!DOCTYPE html>
<html>
<head>
    <title>ATS Dashboard</title>
    <link rel="stylesheet" type="text/css" href="//cdn.jsdelivr.net/chartist.js/latest/chartist.min.css">
    <style type="text/css">
        /* http://meyerweb.com/eric/tools/css/reset/
           v2.0 | 20110126
           License: none (public domain)
           */

           html, body, div, span, applet, object, iframe,
           h1, h2, h3, h4, h5, h6, p, blockquote, pre,
           a, abbr, acronym, address, big, cite, code,
           del, dfn, em, img, ins, kbd, q, s, samp,
           small, strike, strong, sub, sup, tt, var,
           b, u, i, center,
           dl, dt, dd, ol, ul, li,
           fieldset, form, label, legend,
           table, caption, tbody, tfoot, thead, tr, th, td,
           article, aside, canvas, details, embed,
           figure, figcaption, footer, header, hgroup,
           menu, nav, output, ruby, section, summary,
           time, mark, audio, video {
            margin: 0;
            padding: 0;
            border: 0;
            font-size: 100%;
            font: inherit;
            vertical-align: baseline;
        }
        /* HTML5 display-role reset for older browsers */
        article, aside, details, figcaption, figure,
        footer, header, hgroup, menu, nav, section {
            display: block;
        }
        body {
            line-height: 1;
            overflow: hidden;
        }
        ol, ul {
            list-style: none;
        }
        blockquote, q {
            quotes: none;
        }
        blockquote:before, blockquote:after,
        q:before, q:after {
            content: '';
            content: none;
        }
        table {
            border-collapse: collapse;
            border-spacing: 0;
        }
    </style>
    <link href='https://fonts.googleapis.com/css?family=Oswald:400,700|Quattrocento+Sans' rel='stylesheet' type='text/css'>
    <style type="text/css">
        h1, h2, h3, h4, h5, h6 {
            font-family: 'Oswald', sans-serif;
        }
        body {
            font-family: 'Quattrocento Sans', sans-serif;
        }
        #month-container {
            height: 100%;
            float: left;
            display: block;
            width: 75%;
        }
        #daily-container {
            height: 100%;
            float: left;
            display: block;
            width: 25%;
            text-align: center;
        }
        #weather-container {
            height: 45vh;
            float: left;
            display: block;
            width: calc(100%/3);
            background: #5f5f5f;
        }
        .header {
            background: #efefef;
            height: 10vh;
            text-align: center;
            display: table;
            width: 100%;
        }
        .header h1 {
            display: table-cell;
            vertical-align: middle;
            font-size: 3vh;
        }
        .sub-header {
            display: block;
            height: 8vh;
            width: 100%;
            text-align: center;
            background: rgba(0, 0, 0, 0.2);
            margin: 0%;
        }
        .sub-header h2 {
            display: block;
            text-align: center;
            color: white;
            font-size: 4vh;
            padding-top: 3vh;
        }
        #sales-container {
            background: #5f5f5f;
            height: 45vh;
        }
        h1 {
            line-height: 9vh;
        }
        h2 {
            line-height: 2vh;
        }
        #sales-summary {
            width: 37.5vw;
            height: 46vh;
            display: block;
            background: #f36363;
            float: left;
        }
        #chargeout-summary {
            width: 37.5vw;
            height: 46vh;
            display: block;
            background: rgb(99, 150, 243);
            float: left;
        }
        .list-item {
            padding: 8%;
            border-bottom: 0.2vh solid #e2e2e2;
        }
        .list-header {
            font-family: 'Oswald', sans-serif;
            font-size: 4vh;
            color: #4c4c4c;
        }
        .list-content {
            font-size: 4vh;
            font-family: 'Quattrocento Sans', sans-serif;
            padding-top: 8%;
        }
        span.big-number {
    font-size: 31vh;
    color: whitesmoke;
    width: 100%;
    display: block;
    text-align: center;
    margin-top: 2vh;
}
span.context {
    width: 100%;
    display: block;
    text-align: center;
    color: whitesmoke;
    font-size: 3vh;
    margin-top: -4vh;
}
.ct-series-a .ct-bar, .ct-series-a .ct-line, .ct-series-a .ct-point, .ct-series-a .ct-slice-donut {
    stroke: #ffffff;
    stroke-width: 0.5vh;
}
.ct-series-b .ct-bar, .ct-series-b .ct-line, .ct-series-b .ct-point, .ct-series-b .ct-slice-donut {
    stroke: #f36363;
    stroke-width: 2vh;
}
.ct-series-c .ct-bar, .ct-series-c .ct-line, .ct-series-c .ct-point, .ct-series-c .ct-slice-donut {
    stroke: #6396f3;
    stroke-width: 2vh;
}
line.ct-point {
    stroke-width: 1.5vh !important;
}
    </style>
</head>
{% set base = ( budget.budget / budget.days )|round %}
<body>
    <div id="month-container">
        <div class="header">
            <h1>Overview</h1>
        </div>
        <div id="sales-container">
            <div class="sub-header">
                <h2>Sales / Charge Out vs Budget</h2>
            </div>
            <div>
                <div class="ct-chart"></div>
            </div>
        </div>
        <div id="sales-summary">
            <div class="sub-header">
                <h2>Sales</h2>
            </div>
            <span class="big-number">{{ ((totalSales - base * sales|length)/base)|round|number|positive }}</span>
            <span class="context"> Day{% if ((totalSales - base * sales|length)/base)|number|positive is not 1 %}s{% endif %} {% if ((totalSales - base * sales|length)/base)|number > 0 %}Ahead{% else %}Behind{% endif %} </span>
        </div>
        <div id="chargeout-summary">
            <div class="sub-header">
                <h2>Charge Out</h2>
            </div>
            <span class="big-number">{{ ((data.chargeOut - base * sales|length)/base)|round|number|positive }}</span>
            <span class="context"> Day{% if ((data.chargeOut - base * sales|length)/base)|number|positive is not 1 %}s{% endif %} {% if ((data.chargeOut - base * sales|length)/base) > 0 %}Ahead{% else %}Behind{% endif %} </span>
        </div>
    </div>

    <div id="daily-container">
        <div class="header">
            <h1>Daily</h1>
        </div>
        <div class="list">
            <div class="list-item" {% if daySales < base %}style="background: #efefef;" {% endif %}>
                <div class="list-header">
                    Sales
                </div>
                <div class="list-content">
                    ${{ daySales|number }}
                </div>
            </div>
            <div class="list-item" {% if data.onsiteDispatch < 20 %}style="background: #efefef;" {% endif %}>
                <div class="list-header">
                    Onsite Freight
                </div>
                <div class="list-content">
                    {{ data.onsiteDispatch }}m3
                </div>
            </div>
            <div class="list-item">
                <div class="list-header">
                    Offsite Freight
                </div>
                <div class="list-content">
                    {{ data.offsiteDispatch }}m3
                </div>
            </div>
            <div class="list-item" {% if date("H:i",strtotime(data.truckTime)) > date("H:i", strtotime("04:30")) %}style="background: #efefef;" {% endif %}>
                <div class="list-header">
                    Truck Time
                </div>
                <div class="list-content">
                    {{ date("H:i", strtotime(data.truckTime)) }} pm
                </div>
            </div>
            <div class="list-item">
                <div class="list-header">
                    Orders Sent
                </div>
                <div class="list-content">
                    {{ data.ordersSent }}
                </div>
            </div>
        </div>





    </div>

{{ assets.outputJs('dashfooter') }}
<script>
{% set counter = 0 %}
var chart = new Chartist.Line('.ct-chart', {
  labels: [{% for day in sales %}'Day {{ loop.index }}',{% endfor %}],
  // Naming the series with the series object array notation
  series: [{
    name: 'series-1',
    data: [{% for day in sales %}0,{% endfor %}],
  }, {
    name: 'series-2',
    data: [{% for day in sales %}{% set counter += day.sumatory %}{{ counter - base*loop.index }},{% endfor %} ]
  }, {
    name: 'series-3',
    data: [ {% for day in kpis %}{{ day.chargeOut - base*loop.index }},{% endfor %} ]
  }]
}, {

  fullWidth: true,
  width: '1430px',
  height: '400px',
  axisX: {
    showLabel: false,
    showGrid: false,
  },
  axisY: {
    showLabel: false,
    showGrid: true,
  },
  // Within the series options you can use the series names
  // to specify configuration that will only be used for the
  // specific series.
  series: {
    'series-1': {
      showPoint: false,
    },
    'series-2': {
        lineSmooth: Chartist.Interpolation.simple(),
        showArea: false,
    },
    'series-3': {
        lineSmooth: Chartist.Interpolation.simple(),
        showArea: false,
    }
  }
});
function refreshAt(hours, minutes, seconds) {
    var now = new Date();
    var then = new Date();

    if(now.getHours() > hours ||
       (now.getHours() == hours && now.getMinutes() > minutes) ||
        now.getHours() == hours && now.getMinutes() == minutes && now.getSeconds() >= seconds) {
        then.setDate(now.getDate() + 1);
    }
    then.setHours(hours);
    then.setMinutes(minutes);
    then.setSeconds(seconds);

    var timeout = (then.getTime() - now.getTime());
    setTimeout(function() { window.location.reload(true); }, timeout);
}
refreshAt(17,01,0);
</script>
</body>
</html>
