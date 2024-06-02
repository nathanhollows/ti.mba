<div class="container">
	<div class="row">
		<div class="col text-center">
			<h1 class="error-code">501</h1>
			<h2 class="font-bold">Something has gone wrong</h2>
			<code>{{ content() }}</code>
			<br>
			<a class="btn btn-primary text-white" onclick="event.preventDefault(); window.history.back()">Go Back</a>
		</div>
	</div>
</div>

<style type="text/css">
    .error {
      margin: 0 auto;
      text-align: center;
    }

    .error-code {
      bottom: 60%;
      color: #2d353c;
      font-size: 96px;
      line-height: 100px;
    }
</style>
