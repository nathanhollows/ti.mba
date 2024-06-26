<div class="container">
    <div class="row">
        <div class="col">
            <h1 class="page-header">Stock search</h1>
        </div>
    </div>
    <div class="row">
        <div class="col-lg-12">
            <form class="form-inline">
                <div class="form-group">
                    <label class="sr-only" for="width">Width</label>
                    <input type="number" class="form-control size" placeholder="Width" data-column="1" autofocus="true">
                </div>
                <div class="form-group">
                    <label class="sr-only" for="thickness">Password</label>
                    <input type="number" class="form-control size" placeholder="Thickness" data-column="2">
                </div>
                <div class="btn-group" role="group" aria-label="...">
                    <button type="button" class="btn btn-default filter-dryness" data-dryness="0">Wet</button>
                    <button type="button" class="btn btn-default filter-dryness" data-dryness="1">Dry</button>
                </div>
                <div class="btn-group" role="group" aria-label="...">
                    <button type="button" class="btn btn-default filter-finish" data-finish="0">Sawn</button>
                    <button type="button" class="btn btn-default filter-finish" data-finish="1">Machined</button>
                </div>
                <div class="btn-group" role="group" aria-label="...">
                    <button type="button" class="btn btn-info filter-onsite" data-onsite="1">Onsite</button>
                    <button type="button" class="btn btn-default filter-onsite" data-onsite="0">Offsite</button>
                </div>
                <button type="button" class="btn btn-danger pull-right" id="clear">Clear Filters</button>
            </form>
        </div>
<div class="table-responsive">
            <table id="stock" class="table table-bordered table-striped table-hover dataTable"
                data-source="{{ url('stock/index') }}">
        <thead>
            <tr>
                <th>Packet</th>
                <th>Width</th>
                <th>Thickness</th>
                <th>Grade</th>
                <th>Treatment</th>
                <th>Dryness</th>
                <th>Finish</th>
                <th>Lineal</th>
                <th>Cube</th>
            </tr>
        </thead>
        <tfoot>
            <tr>
                <th>Packet</th>
                <th>Width</th>
                <th>Thickness</th>
                <th>Grade</th>
                <th>Treatment</th>
                <th>Dryness</th>
                <th>Finish</th>
                <th>Lineal</th>
                <th>Cube</th>
            </tr>
        </tfoot>
        <tbody>
        </tbody>
    </table>
</div>
    </div>
</div>

<span id="data"></span>
<style type="text/css">
.size {
    max-width: 100px;
}

    .table-responsive .row:first-of-type {
    display: none;
}

.btn-group {
    margin-left: 1rem;
}
</style>
