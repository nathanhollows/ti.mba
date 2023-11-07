<div class="header py-3">
	<div class="container">
		<div class="row">
			<div class="col-lg-8 offset-lg-2">
				<div class="row header-body">
					<div class="col">
						{% if quote is not null %}
						<h4 class="header-title">
							Duplicating Quote {{ quote.quoteId }}
						</h4>
						{% else %}
						<h4 class="header-title">New Quote</h4>
						{% endif %}
					</div>
					<div class="col text-right">
					</div>
					<hr class="w-100"/>
				</div>
			</div>
		</div>
	</div>
</div>

<div class="container">
	{{ content() }}
	{{ flashSession.output() }}
	{{ form("quotes/create", "method":"post", "autocomplete" : "off") }}
	{{ form.render('duplicate') }}
	<div class="row">
		<div class="col-lg-8 offset-lg-2">
			<div class="row">
				<div class="col">
					<div class="form-group">
						{{ form.label('customerCode') }}
						{{ form.render('customerCode') }}
					</div>
				</div>
				<div class="col">
					<div class="form-group">
						{{ form.label('contact') }}
						{{ form.render('contact') }}
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="form-group">
						{{ form.label('reference') }}
						{{ form.render('reference') }}
					</div>
				</div>
				<div class="col">
					<div class="form-group">
						{{ form.label('date') }}
						{{ form.render('date') }}
					</div>
				</div>
				<div class="col">
					<div class="form-group">
						{{ form.label('user') }}
						{{ form.render('user') }}
					</div>
				</div>
			</div>
			<div class="row">
				<div class="col">
					<div class="form-group">
						{{ form.label('notes') }}
						{{ form.render('notes') }}
					</div>
					<div class="form-group">
						{{ form.label('moreNotes') }}
						{{ form.render('moreNotes') }}
					</div>
					{% if ajax is false %}
					<div class="form-group">
						{{ form.render('Submit') }}
					</div>
				</div>
				{% endif %}
				</form>
			</div>
		</div>
	</div>
</div>


<script type="text/javascript">
	$(document).ready(function(){
		$('#customerCode').change(function () {
			var customerCode = $(this).find("option:selected").val();
			if(customerCode){
				$.ajax({
					type:'POST',
					url:'/customers/getcontacts/'+customerCode,
					data: null,
					success:function(html){
						$('#contact').empty();
						$('#contact').html(html);
					}
				});
			}
		});
	});
</script>

<style>
.bootstrap-select .dropdown-toggle {
	border: 1px solid #ced4da;
	background: white;
}
</style>
