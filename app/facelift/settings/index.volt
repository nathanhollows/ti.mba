{{ content() }}
<div class="row">
    <div class="col-xs-12 col-sm-12 col-md-3 col-lg-3">
        <div class="panel panel-default">
            <div class="panel-body">
            </div>
        </div>
    </div>
    <form method="POST">
        <div class="col-xs-12 col-sm-12 col-md-9 col-lg-9">
            <div class="panel panel-default">
                <div class="panel-heading">
                    <h3 class="panel-title">
                        Sales Areas
                    </h3>
                </div>
                <div class="panel-body">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Region</th>
                                {% for rep in reps %}
                                <th align="center">{{ rep.name }}</th>
                                {% endfor %}
                            </tr>
                        </thead>
                        <tbody>
                            {% for area in salesAreas %}
                            <tr>
                                <th>{{ area.name }}</th>
                                {% for rep in reps %}
                                <td align="center">
                                    <label>
                                        <input type="radio" name="area{{ area.id }}" value="{{ rep.id }}" {% if area.rep.id == rep.id%}checked{% endif %}>
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
        <input type="submit" class="btn btn-primary mb-2" value="Save all changes">
    </input>
</form>

