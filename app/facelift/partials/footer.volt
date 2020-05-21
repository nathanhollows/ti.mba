<button type="button" data-toggle="modal" data-target="#feedbackModal" style="position: fixed;right: 0;bottom: 0;margin: 1em; z-index: 4;" class="btn btn-danger shadow">Give Feedback</button>

<!-- Feedback Modal -->
<div class="modal fade" id="feedbackModal" tabindex="-1" role="dialog" aria-labelledby="feedbackModal" aria-hidden="true">
	<div class="modal-dialog" role="document">
		<div class="modal-content">
			<div class="modal-header">
				<h5 class="modal-title" id="exampleModalLabel">Your Feedback</h5>
				<button type="button" class="close" data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">&times;</span>
				</button>
			</div>
			<div class="modal-body">
				<form id="feedbackForm">
					<p class="mb-4">Your feedback is appreciated and will help me get the CRM looking good and working better.</p>
					<p>What is your opinion of this page?</p>
					<div class="btn-group btn-group-toggle w-100" data-toggle="buttons">
						<label class="btn btn-light btn-lg">
							<input type="radio" name="opinion" value="frown" autocomplete="off"> 
							<img src="{{ url('/img/icons/frown.svg') }}"></img>
						</label>
						<label class="btn btn-light btn-lg">
							<input type="radio" name="opinion" value="meh" autocomplete="off"> 
							<img src="{{ url('/img/icons/meh.svg') }}"></img>
						</label>
						<label class="btn btn-light btn-lg">
							<input type="radio" name="opinion" value="smile" autocomplete="off">
							<img src="{{ url('/img/icons/smile.svg') }}"></img>
						</label>
					</div>
					<input type="hidden" name="uri" value="{{ router.getRewriteUri() }}"></input>
					<label for="feedback-input" class="mt-4">(Optional) Please write your feedback here</label>
					<textarea id="feedback-input" name="feedback" class="form-control w-100"></textarea>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
				<button type="button" id="youDontNeedToDoThis" class="btn btn-primary" onClick="submitFeedback()">Send</button>
			</div>
		</div>
	</div>
</div>

<!-- AJAX modal for misc forms -->
<div class="modal fade" id="modal-ajax" tabindex="-1" role="dialog" aria-labelled-by"modal-ajax" aria-hidden="true">
	<div class="modal-dialog" role="document">
	</div>
</div>

<!-- Confirm delete modal -->
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="confirm-delete" aria-hidden="true">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <h5 class="modal-title" id="exampleModalLabel">Delete</h5>
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
				You are about to delete this record. It cannot be undone. Are you sure?
      </div>
      <div class="modal-footer">
        <button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
				<a id="YouDontNeedToDoThis" class="btn btn-danger text-white" role="button">Delete</a>
      </div>
    </div>
  </div>
</div>

<script>
	function submitFeedback() {
		let post = $.post('/feedback/new', $('#feedbackForm').serialize());
		// I should do error checking
		$('#feedbackButton').html('Thank you');
		window.setTimeout(function () {
			$('#feedbackModal').modal('hide');
			$("#feedbackButton").html('Send');
			$(':input','#feedbackForm')
				.not(':button, :submit, :reset, :hidden')
				.val('')
				.prop('checked', false)
				.prop('selected', false);
		}, 1000);
	}
$("a.open-modal").click(function(ev) {
	ev.preventDefault();
	var target = $(this).attr("href");

	$("#modal-ajax .modal-dialog").load(target, function() {
		$("#modal-ajax").modal("show");
	});
});
$( document ).on( "click", ".confirm-delete", function(e) {
	e.preventDefault();
	$("#YouDontNeedToDoThis").attr("href",$(this).attr("href"));
	$('#confirm-delete').modal('show');
});
$(document).on("click", "#modal-save", function(e) {
	var form = $("#modal-ajax form");
	// Loop over them and prevent submission
	var validation = Array.prototype.filter.call(form, function(form) {
		if (form.checkValidity() === true) {
			form.submit();
		}
		form.classList.add('was-validated');
	});
});
$(document).ready(function() {
	$.fn.editable.defaults.mode = 'inline';
	$('#username').editable();
});
</script>

<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js" integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1" crossorigin="anonymous"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js" integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM" crossorigin="anonymous"></script>
<script type="text/javascript" src="https://cdn.datatables.net/v/bs4/dt-1.10.20/datatables.min.js"></script>
<script type="text/javascript" src="/js/instantpage.min.js" type="module" defer></script>
<script type="text/javascript" src="/js/useUCA.js"></script>
<script type="text/javascript" src="/js/bootstrap-editable.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14/dist/js/bootstrap-select.min.js"></script>

<style>
.dropdown-toggle::after {
	transition: transform 0.15s linear;
}

.show.dropdown .dropdown-toggle::after {
	transform: translateY(3px);
}
#modal-ajax .modal-body .btn[type="submit"] {
	display: none;
}
</style>
</body>

</html>
