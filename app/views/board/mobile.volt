<!DOCTYPE html>
<html>
<head>
    <title>ATS & VidaSpace Dashboard</title>
    <!-- Compiled and minified CSS -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/css/materialize.min.css">

    <!-- Compiled and minified JavaScript -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/materialize/0.100.2/js/materialize.min.js"></script>

    <!--Let browser know website is optimized for mobile-->
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
</head>

<body class="blue-grey darken-4 blue-grey-text text-lighten-5">
    <div class="container">
    <h1>ATS</h1>
        <p>Sales In</p>
            <div>
                <span class="left-align">0</span>
                <span class="center-align"><strong>${{ data['atsSales']['value']|number }}</strong></span>
                <span class="right-align">${{ budget|number }}</span>
            </div>
            <div class="progress blue-grey darken-3">
                <div class="determinate pink" style="width: {{ data['atsSales']['rotation'] }}%"></div>
            </div>
        <p>Sales Out</p>
            <p>
                <span class="left-align">0</span>
                <span class="center-align"><strong>${{ atsChargeOut|number }}</strong></span>
                <span class="right-align">${{ budget|number }}</span>
            </p>
            <div class="progress blue-grey darken-3">
                <div class="determinate blue" style="width: 70%"></div>
            </div>
        <p>Follow Ups</p>
            <p>
                <span class="left-align">0</span>
                <span class="center-align">0</span>
                <span class="right-align">{{ atsLeads }}</span>
            </p>
            <div class="progress blue-grey darken-3">
                <div class="determinate light-green" style="width: 70%"></div>
            </div>
    <h1>ATS Architectural</h1>
        <p>Sales In</p>
            <p>
                <span class="left-align">0</span>
                <span class="center-align">0</span>
                <span class="right-align">0</span>
            </p>
            <div class="progress blue-grey darken-3">
                <div class="determinate pink" style="width: 70%"></div>
            </div>
        <p>Sales Out</p>
            <p>
                <span class="left-align">0</span>
                <span class="center-align">0</span>
                <span class="right-align">0</span>
            </p>
            <div class="progress blue-grey darken-3">
                <div class="determinate blue" style="width: 70%"></div>
            </div>
        <p>Leads</p>
            <p>
                <span class="left-align">0</span>
                <span class="center-align">0</span>
                <span class="right-align">0</span>
            </p>
            <div class="progress blue-grey darken-3">
                <div class="determinate light-green" style="width: 70%"></div>
            </div>
    <h1>VidaSpace</h1>
        <p>Sales In</p>
            <p>
                <span class="left-align">0</span>
                <span class="center-align">0</span>
                <span class="right-align">0</span>
            </p>
            <div class="progress blue-grey darken-3">
                <div class="determinate pink" style="width: 70%"></div>
            </div>
        <p>Sales Out</p>
            <p>
                <span class="left-align">0</span>
                <span class="center-align">0</span>
                <span class="right-align">0</span>
            </p>
            <div class="progress blue-grey darken-3">
                <div class="determinate blue" style="width: 70%"></div>
            </div>
        <p>Leads</p>
            <p>
                <span class="left-align">0</span>
                <span class="center-align">0</span>
                <span class="right-align">0</span>
            </p>
            <div class="progress blue-grey darken-3">
                <div class="determinate light-green" style="width: 70%"></div>
            </div>
        </div>
        <div class="row">
            <div class="section header">
                <span class="header">ATS Timber</span>
            </div>
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
                <span class="header">Architectural</span>
            </div>
            <div class="section">
                <span class="title">Sales In</span>
                <div class="ct-chart ct-major-seventh sales-in" id="chart4"></div>
                <div class="figures">
                    <span class="actual">$<span class="figure" data-value="0">0</span><small><br>???</small></span>
                </div>
            </div>
            <div class="section">
                <span class="title">Sales Out</span>
                <div class="ct-chart ct-major-seventh sales-out" id="chart5"></div>
                <div class="figures">
                    <span class="actual">$<span class="figure" data-value="0">0</span><small><br>???</small></span>
                </div>
            </div>
            <div class="section">
                <span class="title">Leads</span>
                <div class="ct-chart ct-major-seventh leads" id="chart6"></div>
                <div class="figures">
                    <span class="actual">$<span class="figure" data-value="0">0</span><small><br>???</small></span>
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

// ATS Timber Sales Out
$('#atsSalesOut .figure').countTo({
    from: parseInt($('#atsSales .figure').text().replace(',', '')),
    to: data.atsChargeOut.value,
    formatter: format
});
// ATS Timber Leads
$('#atsLeads .figure').countTo({
    from: parseInt($('#atsLeads .figure').text().replace(',', '')),
    to: data.atsLeads.value,
    formatter: format
});
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

    <!--Import jQuery before materialize.js-->
    <script type="text/javascript" src="https://code.jquery.com/jquery-3.2.1.min.js"></script>


</body>
</html>
