<style type="text/css">
    body {
        background: #EAEAEA;
        font-size: 40px;
        margin: 0;
        padding: 0;
        font-family: Arial,"Helvetica Neue",Helvetica,sans-serif
    }
    .panel {
        background: white;
        margin: 0.5em 0em 0.5em 0.5em;
        display: block;
        width: 15.3333em;
        height: auto;
        float: left;
        height: 26em;
    }

    .header {
        background: #F5F5F5;
        margin-top: -1.35em;
        color: #6D6D6D;
    }
    h1 {
        font-size: 1.5em;
        line-height: 2em;
        text-shadow: -1px 2px 2px white;
    }
</style>


<div class="panel">
    <div class="header">
        <h1> Statistics </h1>
    </div>
    <div class="graph sales">
        <div class="graph-header">
            <h2>Sales vs Budget</h2>
        </div>
    </div>
    <div class="graph chargeout">
        <div class="graph-header">
            <h2>Sales vs Budget</h2>
        </div>
    </div>
</div>
<div class="panel">
    Sales for {{ date }} are ${{ data.sales }}
    Truck time is {{ data.truckTime }}
</div>
<div class="panel">
    Onsite dispatch is {{ data.onsiteDispatch }}
    Offsite dispatch is {{ data.offsiteDispatch }}
</div>