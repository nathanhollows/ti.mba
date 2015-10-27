    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.3/jquery.min.js"></script>
    <!-- Include all compiled plugins (below), or include individual files as needed -->
	<!-- Latest compiled and minified JavaScript -->
	<script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
	</div>

<footer>
	Made with love by the Avaunt team
	<?php echo $this->tag->linkTo(array('privacy', 'Privacy Policy')); ?> |
	<?php echo $this->tag->linkTo(array('terms', 'Terms of Use')); ?>
	© <?php echo date('Y'); ?> Avaunt Team.
</footer>

  </body>
</html>