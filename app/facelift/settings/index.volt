<form method="POST">
    <div class="header py-3">
        <div class="container">
            <div class="row header-body">
                <div class="col">
                    <h4 class="header-title">Sales Areas</h4>
                </div>
                <div class="col text-right">
                    <input type="submit" class="btn btn-primary mb-2" value="Save all changes">
                </div>
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col">
                {{ content() }}
                {{ flash.output() }}
                {{ flashSession.output() }}
            </div>
        </div>
    </div>
    <div class="container">
        <div class="row">
            <div class="col">
                <div class="panel panel-default">
                    <div class="panel-body">
                        <table class="table table-hover">
                            <thead>
                                <tr>
                                    <th>Region</th>
                                    {% for rep in reps %}
                                    <th class="text-center">{{ rep.name }}</th>
                                    {% endfor %}
                                </tr>
                            </thead>
                            <tbody>
                                {% for area in salesAreas %}
                                <tr>
                                    <th>{{ area.name }}</th>
                                    {% for rep in reps %}
                                    <td class="radio text-center">
                                        <label>
                                            <input type="radio" name="area{{ area.id }}" value="{{ rep.id }}" {% if area.rep.id is defined and area.rep.id == rep.id%}checked{% endif %}>
                                        </label>
                                    </td>
                                    {% endfor %}
                                </tr>
                                {% endfor %}
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <input type="submit" class="btn btn-primary mb-2" value="Save all changes">
    </div>
</form>

<style>
    .table td.radio {
        padding: 0;
        line-height: 0;
    }
    .radio label {
        width: 100%;
        height: 2.6em;
        display: block;
        margin: 0;
        line-height: 0;
        padding: 1em;
    }
</style>    