</div>
    <!-- jQuery -->
    <script src="{{ static_url( "js/jquery.js" ) }}"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="{{ static_url( "js/bootstrap.min.js" ) }}"></script>

	<footer class="footer">
		Made with love by the Avaunt team
		{{link_to('privacy','Privacy Policy')}} |
		{{link_to('terms','Terms of Use')}}
		© {{ date('Y') }} Avaunt Team.
	</footer>

  </body>
</html>