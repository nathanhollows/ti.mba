<!doctype html>
<html>
<head>
</head>
<body style="border:0; margin: 0;" onload="subst()">
	<table style="border-bottom: none; width: 100%; color: white; height: 10.5mm; padding: 0 15mm 0 15mm; font-size: 3mm; font-weight: bold;">
		<tr style="background: #224725;">
			<td class="section"></td>
			<td style="text-align:right">
				<strong> Page <span class="page"></span> - <span class="topage"></span> </strong>
			</td>
		</tr>
	</table>
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
</body>
</html>
