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
            </p>
            <strong>{{ packet.lastRecord.linealTally }}m
                <br />
                {{ packet.lastRecord.width }} x {{ packet.lastRecord.thickness }}
                {{ packet.lastRecord.grade }} {{ packet.lastRecord.treatment }} {{ packet.lastRecord.dryness }} {{ packet.lastRecord.finish }}
            </strong>
            {% if packet.tallies|length > 0 %}
            <strong>Tally</strong>
            <table class="table table-striped ">
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
    <div class="row" >
        <div class="col-sm-12">
            <strong>History</strong>
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
