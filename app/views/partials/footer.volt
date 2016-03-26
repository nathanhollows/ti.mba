</div>

<!-- AJAX modal for misc forms -->
<div class="modal fade" id="modal-ajax">
    <div class="modal-dialog">
        <div class="modal-content">
        </div>
    </div>
</div>
    <!-- Bootstrap Core JavaScript -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    {{ javascript_include("js/to-markdown.js") }}
    {{ javascript_include("js/bootstrap-markdown.js") }}
    {{ javascript_include("js/markdown.js") }}
    <!-- DataTables -->
    <script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.10/js/jquery.dataTables.min.js"></script>
    <script type="text/javascript" language="javascript" src="//cdn.datatables.net/1.10.10/js/dataTables.bootstrap.min.js"></script>
    <!-- Chartist -->
    <script src="//cdn.jsdelivr.net/chartist.js/latest/chartist.min.js"></script>
    <!-- Select2 -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.2-rc.1/js/select2.min.js"></script>
    {{ javascript_include("js/app.js") }}
    <footer class="footer">
        Open sourced under the GNU scheme.
        {{link_to('privacy','Privacy Policy')}} |
        {{link_to('terms','Terms of Use')}}
        © {{ date('Y') }} Nathan Hollows.
	</footer>

  </body>
</html>