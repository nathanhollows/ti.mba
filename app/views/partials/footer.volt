</div>

<!-- AJAX modal for misc forms -->
<div class="modal fade" id="modal-ajax">
	<div class="modal-dialog">
		<div class="modal-content">
		</div>
	</div>
</div>
<div class="modal fade" id="confirm-delete" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4>Delete<button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button></h4>
            </div>
            <div class="modal-body">
                You are about to delete this record. It cannot be undone. Are you sure?
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">Cancel</button>
                <a class="btn btn-danger btn-ok">Delete</a>
            </div>
        </div>
    </div>
</div>

{{ assets.outputJS('footer') }}

</body>

</html>
