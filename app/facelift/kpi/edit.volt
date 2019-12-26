<div class="header py-3">
	<div class="container">
		<div class="row header-body">
			<div class="col">
				<h6 class="header-pretitle">Record</h6>
				<h4 class="header-title">Production KPI's</h4>
			</div>
			<div class="col text-right">
			</div>
		</div>
		<hr class="w-100">
	</div>
</div>

<ul class="pager">
	<li>{{ link_to('kpi/' ~ yesterday, 'Previous') }}</li>
	<li>{{ link_to('kpi/', 'Today') }}</li>
    <li><a id="datebutton"><input type="text" name="" id="datepicker" class="form-control" value="{{ date('Y/m/d', strtotime(date)) }}" required="required" pattern="" title="" hidden="true" data-date-format='yyyy/mm/dd'><i class="fa fa-icon fa-calendar"></i> Select Date</a></li>
	<li>{{ link_to('kpi/' ~ tomorrow, 'Next') }}</li>
</ul>

{{ flashSession.output() }}

{{ content() }}
<div class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-md-offset-3 col-lg-offset-3">

<h2>{{ date( 'l dS M', strtotime(date) ) }}</h2>

<form action="/kpi/save" method="POST" role="form">

	<div class="form-group">
	{{ hidden_field('date', 'test', 'value': date ) }}
	{% for element in form %}
		{{ element.label() }}
		{{ element.render() }}
	{% endfor %}
	</div>

	<button type="submit" class="btn btn-primary">Submit</button>
</form>
</div>

<style type="text/css">
    .datepicker.datepicker-dropdown.dropdown-menu {
        background: white;
    }
    input#datepicker {
        height: 0px;
        width: 0px;
        padding: 0;
        border: none;
        visibility: hidden;
        display: inline;
        margin-top: 10px;
    }
</style>
<script type="text/javascript">
    $(function () {
        $("#datepicker")
            .datepicker({
              dateFormat: "yy/mm/dd",
              onSelect: function(dateText) {
                $(this).change();
              }
            })
            .change(function() {
              window.location.href = "/kpi/" + this.value;
            });
            $('#datebutton').click(function() {
                  $('#datepicker').datepicker('show');
            });
    });
</script>
