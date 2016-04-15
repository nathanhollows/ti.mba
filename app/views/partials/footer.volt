</div>

<!-- AJAX modal for misc forms -->
<div class="modal fade" id="modal-ajax">
    <div class="modal-dialog">
        <div class="modal-content">
        </div>
    </div>
</div>


<footer class="footer">
    Open sourced under the GNU scheme.
    {{link_to('privacy','Privacy Policy')}} |
    {{link_to('terms','Terms of Use')}}
    © {{ date('Y') }} Nathan Hollows.
</footer>

{{ assets.outputJS('footer') }}

  </body>
</html>