<html>
<head>
    <title>ATS Dashboard - Summary</title>
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
<link href="https://fonts.googleapis.com/css?family=Oswald:400,700|Quattrocento+Sans" rel="stylesheet" type="text/css">
<style type="text/css">
h1, h2, h3, h4, h5, h6 {
    font-family: 'Oswald', sans-serif;
}
body {
    font-family: 'Quattrocento Sans', sans-serif;
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
h1 {
    line-height: 9vh;
}
h2 {
    line-height: 2vh;
}
#month-container {
    height: 100vh;
    float: left;
    display: block;
    width: 100vw;
}
.summary {
    background: #5f5f5f;
    height: 54vh;
    width: 100vw;
    float: right;
}
#sales-summary {
    width: 50vw;
    height: 46vh;
    display: block;
    background: #f36363;
    float: left;
}
#chargeout-summary {
    width: 50vw;
    height: 46vh;
    display: block;
    background: rgb(99, 150, 243);
    float: left;
}
.figure-item {
    font-size: 4vh;
    color: whitesmoke;
    font-family: 'Quattrocento Sans', sans-serif;
    padding-top: 9%;
    width: 24%;
    float: left;
    text-align: center;
}
span.number {
    display: block;
    font-size: 150%;
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
sub {
    font-size: 60%;
}
</style>
</head>
<body>
    <div id="month-container">
        <div id="chargeout-summary">
            <div class="sub-header">
                <h2>Charge Out</h2>
            </div>
            <span class="big-number">{{ chargeOut / budget }}</span>
            <span class="context"> Day{% if ((data.chargeOut - base * sales|length)/base)|number|positive is not 1 %}s{% endif %} {% if ((data.chargeOut - base * sales|length)/base) > 0 %}Ahead{% else %}Behind{% endif %} </span>
        </div>
        <div id="sales-summary">
            <div class="sub-header">
                <h2>Sales</h2>
            </div>
            <span class="big-number">2</span>
            <span class="context"> Days Ahead </span>
        </div>
        <div class="summary">
            <div class="sub-header">
                <h2>November Summary</h2>
            </div>
            <div class="figures">
                <div class="figure-item">
                    <span class="number">{{ onsite|round }}<sub>m3</sub></span>
                    Sent Onsite
                </div>
                <div class="figure-item">
                    <span class="number">{{ offsite|round }}<sub>m3</sub></span>
                    Sent Offsite
                </div>
                <div class="figure-item">
                    <span class="number">{{ ordersSent}}</span>
                    Orders Sent
                </div>
                <div class="figure-item">
                    <span class="number">{{ biggestSale.agent.name }}</span>
                    Biggest Order
                </div>
            </div>
        </div>
    </div>



</body>
</html>
