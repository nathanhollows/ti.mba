<!doctype html>
<html>
<head>
	<script>
		function subst() {
			var vars={};
			var x=window.location.search.substring(1).split('&');
			for (var i in x) {var z=x[i].split('=',2);vars[z[0]] = unescape(z[1]);}
				var x=['frompage','topage','page','webpage','section','subsection','subsubsection'];
			for (var i in x) {
				var y = document.getElementsByClassName(x[i]);
				for (var j=0; j<y.length; ++j) y[j].textContent = vars[x[i]];
			}
	}
</script>
</head>
<body style="border:0; margin: 0;" onload="subst()">
	<table style="border-bottom: none; width: 100%; background: #224725; color: white; height: 10.5mm; padding: 0 15mm 0 15mm; font-size: 3mm;">
		<tr>
			<td class="section"></td>
			<td style="text-align:right">
				<b> Page <span class="page"></span> - <span class="topage"></span> <b>
			</td>
		</tr>
	</table>
</body></html>
