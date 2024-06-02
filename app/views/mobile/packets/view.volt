<div class="container">
    <div class="row">
        <div class="col-sm-12">
            <p>
            {% if packet.current is 0 %}
                <span class="badge badge-warning">Dead</span>
            {% else %}
                <span class="badge badge-info">Current</span>
                {% if packet.lastRecord.offsite is 1 %}
                    <span class="badge badge-warning">Offsite</span>
                {% else %}
                    <span class="badge badge-info">Onsite</span>
                {% endif %}
            {% endif %}
                <span class="badge badge-danger">FSC 100%</span>
            </p>
            <h2>{{ packet.lastRecord.linealTally }}m
                <br />
                {{ packet.lastRecord.width }} x {{ packet.lastRecord.thickness }}
                {{ packet.lastRecord.grade }} {{ packet.lastRecord.treatment }} {{ packet.lastRecord.dryness }} {{ packet.lastRecord.finish }}
            </h2>
            {% if packet.tallies|length > 0 %}
            <h2>Tally</h2>
            <table class="table table-striped table-responsive">
                {% set counts = [] %}
                {% set lengths = [] %}
                {% for tally in packet.tallies %}
                    {% set lengths[loop.index] = tally.length %}
                    {% set counts[loop.index] = tally.count %}
                {% endfor %}
                <thead>
                    <tr>
                        {% for length in lengths %}
                            <th>{{ length }}</th>
                        {% endfor %}
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        {% for count in counts %}
                            <td type="number" contenteditable="true">{{ count }}
                        {% endfor %}
                    </tr>
                </tbody>
                <tfoot class="collapse" id="split">
                    <tr>
                        {% for i in counts %}
                            <th class="input">
                                <input type="number" placeholder="{{0}}">
                            </th>
                        {% endfor %}
                    </tr>
                    <tr>
                        <th colspan="{{ counts|length }}" contenteditable="true">Packet</th>
                    </tr>
                </tfoot>
            </table>
            {% endif %}
        </div>
    </div>
    {% if packet.current %}
    <div class="row">
        <div class="col-sm-12">
            <button class="btn btn-info" data-toggle="collapse" data-target="#split" aria-expanded="false" aria-controls="split">Split</button>
            <button class="btn btn-info">Process</button>
            <button class="btn btn-warning" {% if (8 in packet.lastRecord.grade) or (10 in packet.lastRecord.grade) %}disabled="disabled"{% endif %}>Verify</button>
            <button class="btn btn-warning">Attach to Order</button>
        </div>
    </div>
    {% endif %}
    <div class="row" >
        <div class="col-sm-12">
            <h2>History</h2>
            <table class="table table-hover table-striped">
                <thead>
                    <th>Date</th>
                    <th>Move</th>
                    <th>Comment</th>
                    <th>Cube</th>
                    <th>Tally</th>
                </thead>
                <tbody>
                    {% for history in packet.history %}
                    <tr>
                        <td>{{ date("d M y", strtotime(history.dateIn)) }}</td>
                        <td>{{ history.operation }}</td>
                        <td {% if history.operation in ["TPO", "CPP", "ATP"] %} class="link" {% endif %}>{{ history.comment }}</td>
                        <td>{{ history.netCube }}</td>
                        <td>{{ history.linealTally }}</td>
                    </tr>
                    {% endfor %}
                </tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript">
$(document).ready(function() {
    $(".link").each(function() {
        $(this).html($(this).text().replace(/\s(\w+)$/g, ' <a href="/p/$1">$1</a>'));
    });
});
</script>

<style type="text/css">
.collapse.in {
    display: table-footer-group;
}
input[type="number"] {
    border: none;
    background: transparent;
    margin: 0;
    padding: 8px;
    max-width: 50px;
}
th.input {
    padding: 0px !important;
}
</style>
