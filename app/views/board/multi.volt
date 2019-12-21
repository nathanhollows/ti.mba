<!DOCTYPE html>
<html>
<head>
  <title>Multi Dashboard</title>
  <link href="https://fonts.googleapis.com/css?family=Roboto|Roboto+Condensed:300,400" rel="stylesheet">
  <link rel="stylesheet" type="text/css" href="https://cdnjs.cloudflare.com/ajax/libs/normalize/7.0.0/normalize.css">
  <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/chartist/0.11.0/chartist.min.css">
  <script src="https://code.jquery.com/jquery-3.2.1.min.js" integrity="ha256-hwg4gsxgFZhOsEEamdOYGBf13FyQuiTwlAQgxVSNgt4=" crossorigin="anonymous"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/chartist/0.11.0/chartist.min.js"></script>
  <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-countto/1.2.0/jquery.countTo.min.js"></script>
  <style type="text/css">
  body {
    background-color: #0f1416;
    color: white;
    font-family: 'Roboto Condensed', sans-serif;
    overflow: hidden;
  }
  .row {
    display: flex;
    flex-direction: row;
    height: 29vh;
    margin: 11vh 0 5vh;
  }
  .section {
    flex: 1;
  }
  .sales-in .ct-series-a .ct-slice-donut {
    stroke: #E91E63;
  }
  .sales-out .ct-series-a .ct-slice-donut {
    stroke: #00BCD4;
  }
  .leads .ct-series-a .ct-slice-donut {
    stroke: #CDDC39;
  }
  .ct-series-b .ct-slice-donut {
    stroke: #1d272b;
  }
  span.title {
    display: none;
    width: 100%;
    text-align: center;
    line-height: 2.15rem;
    font-size: xx-large;
    font-weight: 100;
    color: #607d8b;
  }
  span.header {
    font-size: 2rem;
    color: whitesmoke;
    width: 100%;
    display: block;
    text-align: right;
    margin-top: calc(42% - 1rem);
  }
  div.section.header {
    max-width: 14vw;
  }
  .figures {
    display: flex;
    flex-direction: row;
    color: white;
    margin-top: -9rem;
  }
  .figures span {
    flex: 1;
    text-align: center;
    z-index: 1;
  }
  span.actual small {
    color: grey;
    font-size: 70%;
  }
  span.actual {
    font-size: 2.3rem;
  }
  @keyframes pulsered {
    0% {
      stroke-width: 5px;
    }
    25% {
      stroke-width: 3px;
    }
    50% {
      stroke-width: 1px;
      stroke: #FF9800;
    }
    75% {
      stroke-width: 3px;
    }
    100% {
      stroke-width: 5px;
    }
  }
  @keyframes pulseblue {
    0% {
      stroke-width: 5px;
    }
    25% {
      stroke-width: 3px;
    }
    50% {
      stroke-width: 1px;
      stroke: #2196F3;
    }
    75% {
      stroke-width: 3px;
    }
    100% {
      stroke-width: 5px;
    }
  }
  @keyframes pulsegreen {
    0% {
      stroke-width: 5px;
    }
    25% {
      stroke-width: 3px;
    }HLL2375DW
    50% {
      stroke-width: 1px;
      stroke: #4CAF50;
    }
    75% {
      stroke-width: 3px;
    }
    100% {
      stroke-width: 5px;
    }
  }
  .pulsered {
    animation: pulsered 5.5s linear infinite;
  }
  .pulseblue {
    animation: pulseblue 5s linear infinite;
  }
  .pulsegreen {
    animation: pulsegreen 4.5s linear infinite;
  }
  span.legend.leads {
    background: -webkit-gradient(linear, left top, left bottom, from(#CDDC39), to(#8BC34A));
    -webkit-background-clip: text;
  }
  span.legend.sales-out {
    background: -webkit-gradient(linear, left top, left bottom, from(#00BCD4), to(#03A9F4));
    -webkit-background-clip: text;
  }
  span.legend.sales-in {
    background: -webkit-gradient(linear, left top, left bottom, from(#E91E63), to(#C2185B));
    -webkit-background-clip: text;
  }
  div.row.legend {
    height: 0vh;
    text-align: center;
    margin: 3rem 0 8rem;
  }
  span.legend {
    font-size: 2.5rem;
    font-weight: 300;
    -webkit-text-fill-color: transparent;
  }
  </style>
</head>
<body>
  <div class="container">
    <div class="row legend">
      <div class="section header">
      </div>
      <div class="section">
        <span class="legend sales-in">Sales In</span>
      </div>
      <div class="section">
        <span class="legend sales-out">Sales Out</span>
      </div>
      <div class="section">
        <span class="legend leads">Leads</span>
      </div>
    </div>
    <div class="row">
      <div class="section header">
        <span class="header">ATS Timber</span>
      </div>
      {% set atsDaily = atsBudget.budget/atsBudget.days%}
      <div class="section" id="atsSales">
        <span class="title">Sales In</span>
        <div class="ct-chart ct-major-seventh sales-in" id="chart1"></div>
        <div class="figures">
          <span class="actual">$<span class="figure" data-value="0">0</span><small><br>${{ (atsDaily)|number }}</small></span>
        </div>
      </div>
      <div class="section" id="atsSalesOut">
        <span class="title">Sales Out</span>
        <div class="ct-chart ct-major-seventh sales-out" id="chart2"></div>
        <div class="figures">
          <span class="actual">$<span class="figure" data-value="0">0</span><small><br>${{ atsDaily|number }}</small></span>
        </div>
      </div>
      <div class="section" id="atsLeads">
        <span class="title">Follow Ups</span>
        <div class="ct-chart ct-major-seventh leads" id="chart3"></div>
        <div class="figures">
          <span class="actual"><span class="figure" data-value="0">0</span><small><br>{{ atsLeads }}</small></span>
        </div>
      </div>
    </div>
    <div class="row-summary" style="display: none;">
      <div class="section" id="atsLeads">
        <span class="title">Follow Ups</span>
        <div class="ct-chart ct-major-seventh leads" id="chart3"></div>
        <div class="figures">
          <span class="actual"><span class="figure" data-value="0">0</span><small><br>{{ atsLeads }}</small></span>
        </div>
      </div>
      <div class="section" id="atsLeads">
        <span class="title">Follow Ups</span>
        <div class="ct-chart ct-major-seventh leads" id="chart3"></div>
        <div class="figures">
          <span class="actual"><span class="figure" data-value="0">0</span><small><br>{{ atsLeads }}</small></span>
        </div>
      </div>
      <div class="section" id="atsLeads">
        <span class="title">Follow Ups</span>
        <div class="ct-chart ct-major-seventh leads" id="chart3"></div>
        <div class="figures">
          <span class="actual"><span class="figure" data-value="0">0</span><small><br>{{ atsLeads }}</small></span>
        </div>
      </div>
    </div>
    <div class="row">
      <div class="section header">
        <span class="header">VidaSpace</span>
      </div>
      <div class="section" id="vsSales">
        <span class="title">Sales In</span>
        <div class="ct-chart ct-major-seventh sales-in" id="chart7"></div>
        <div class="figures">
          <span class="actual">$<span class="figure" data-value="0">0</span><small><br>$21,052</small></span>
        </div>
      </div>
      <div class="section">
        <span class="title">Sales Out</span>
        <div class="ct-chart ct-major-seventh sales-out" id="chart8"></div>
        <div class="figures">
          <span class="actual">$<span class="figure" data-value="0">0</span><small><br>???</small></span>
        </div>
      </div>
      <div class="section" id="vsLeads">
        <span class="title">Leads</span>
        <div class="ct-chart ct-major-seventh leads" id="chart9"></div>
        <div class="figures">
          <span class="actual">$<span class="figure" data-value="0">0</span><small><br>$57,692</small></span>
        </div>
      </div>
    </div>

  </div>

  <script>

var chart1 = new Chartist.Pie('#chart1', {
    series: [0, 100]
}, {
    donut: true,
    donutWidth: 5,
    startAngle: 270,
    total: 100,
    showLabel: false
});

var chart2 = new Chartist.Pie('#chart2', {
    series: [0, 100]
}, {
    donut: true,
    donutWidth: 5,
    startAngle: 270,
    total: 100,
    showLabel: false
});

var chart3 = new Chartist.Pie('#chart3', {
    series: [0, 100]
}, {
    donut: true,
    donutWidth: 5,
    startAngle: 270,
    total: 100,
    showLabel: false
});

var chart4 = new Chartist.Pie('#chart4', {
    series: [0, 100]
}, {
    donut: true,
    donutWidth: 5,
    startAngle: 270,
    total: 100,
    showLabel: false
});

var chart5 = new Chartist.Pie('#chart5', {
    series: [0, 100]
}, {
    donut: true,
    donutWidth: 5,
    startAngle: 270,
    total: 100,
    showLabel: false
});

var chart6 = new Chartist.Pie('#chart6', {
    series: [0, 100]
}, {
    donut: true,
    donutWidth: 5,
    startAngle: 270,
    total: 100,
    showLabel: false
});

var chart7 = new Chartist.Pie('#chart7', {
    series: [0, 100]
}, {
    donut: true,
    donutWidth: 5,
    startAngle: 270,
    total: 21052,
    showLabel: false
});

var chart8 = new Chartist.Pie('#chart8', {
    series: [0, 100]
}, {
    donut: true,
    donutWidth: 5,
    startAngle: 270,
    total: 100,
    showLabel: false
});

var chart9 = new Chartist.Pie('#chart9', {
    series: [0, 100]
}, {
    donut: true,
    donutWidth: 5,
    startAngle: 270,
    total: 57692,
    showLabel: false
});

var format = function(value, options) {
    value = value.toFixed(options.decimals);
    value = value.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
    return value;
}

var refreshATS = function() {
    $.ajax({
        cache: false,
        type: 'POST',
        url: "/board/refresh",
        data: {
            'atsLeads': {{ atsLeads }}
        },
        success: function(data) {
            // ATS Timber Sales In
            $('#atsSales .figure').countTo({
                from: parseInt($('#atsSales .figure').text().replace(',', '')),
                to: data.atsSales.value,
                formatter: format
            }).attr('data-value', data.atsSales.value);
            chart1.update({
                series: [
                    [data.atsSales.rotation]
                ]
            })

            // ATS Timber Sales Out
            $('#atsSalesOut .figure').countTo({
                from: parseInt($('#atsSales .figure').text().replace(',', '')),
                to: data.atsChargeOut.value,
                formatter: format
            });
            chart2.update({
                series: [
                    [data.atsChargeOut.rotation]
                ]
            })
            // ATS Timber Leads
            $('#atsLeads .figure').countTo({
                from: parseInt($('#atsLeads .figure').text().replace(',', '')),
                to: data.atsLeads.value,
                formatter: format
            });
            chart3.update({
                series: [
                    [data.atsLeads.rotation]
                ]
            })
            if (data.atsSales.rotation == 100) {
                $('#atsSales path.ct-slice-donut').addClass('pulsered');
            }
            if (data.atsChargeOut.rotation == 100) {
                $('#atsSalesOut path.ct-slice-donut').addClass('pulseblue');
            }
            if (data.atsLeads.rotation == 100) {
                $('#atsLeads path.ct-slice-donut').addClass('pulsegreen');
            }
        },
        error: function(ajaxContext) {
            alert(ajaxContext.responseText)
        }
    });
};

var refreshVidaSpaceSales = function() {
    $.ajax({
        cache: false,
        type: 'GET',
        url: "https://api.pipedrive.com/v1/pipelines/1/deals?filter_id=53&status=all_not_deleted&start=0&api_token=74d07c66ce3638e0b2d347b56bebb7ea0b4c7458",
        data: {
            "Accept": "application/json"
        },
        success: function(data) {
            vsSalesSum = 0
            for (var i = 0; i < data.data.length; i++) {
                vsSalesSum += data.data[i].value
            }
            // VidaSpace Sales In
            $('#vsSales .figure').countTo({
                from: 0,
                to: vsSalesSum,
                formatter: format
            });
            chart7.update({
                series: [
                    [vsSalesSum]
                ]
            })
            if (vsSalesSum > 21052) {
              $('#vsSales path.ct-slice-donut').addClass('pulsered');
            }
        },
        error: function(ajaxContext) {
            alert(ajaxContext.responseText)
        }
    });
};
var refreshVidaSpaceLeads = function() {
    $.ajax({
        cache: false,
        type: 'GET',
        url: "https://api.pipedrive.com/v1/pipelines/1/deals?filter_id=58&status=all_not_deleted&start=0&api_token=74d07c66ce3638e0b2d347b56bebb7ea0b4c7458",
        data: {
            "Accept": "application/json"
        },
        success: function(data) {
            sum = 0
            for (var i = 0; i < data.data.length; i++) {
                sum += data.data[i].value
            }
            // VidaSpace Sales In
            $('#vsLeads .figure').countTo({
                from: 0,
                to: sum,
                formatter: format
            });
            chart9.update({
                series: [sum]
            })
            if (sum > 21052) {
              $('#vsLeads path.ct-slice-donut').addClass('pulsegreen');
            }
        },
        error: function(ajaxContext) {
            alert(ajaxContext.responseText)
        }
    });
};

refreshATS();
refreshVidaSpaceLeads();
refreshVidaSpaceSales();

setInterval(function() {
    refreshVidaSpaceLeads();
    refreshVidaSpaceSales();
    refreshATS();
}, 300000);  </script>

</body>
</html>
