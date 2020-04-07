<div class="modal-content">
	<div class="modal-header">
		<h5 class="modal-title">{% if pageTitle is defined %}{{ pageTitle }}{% endif %}</h5>
		<button type="button" class="close" data-dismiss="modal" aria-label="Close">
			<span aria-hidden="true">&times;</span>
		</button>
	</div>
	<div class="modal-body">
		{{ content() }}
	</div>
	<div class="modal-footer">
		<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
		<button type="submit" id="modal-save" class="btn btn-primary">Save</button>
	</div>
</div>
