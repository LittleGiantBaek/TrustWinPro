<!DOCTYPE HTML>
<html>

<head>
<title>CanvasJS Chart jQuery Plugin</title>
<!-- <script type="text/javascript" src="/assets/script/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/assets/script/jquery.canvasjs.min.js"></script>
 -->
<script type="text/javascript" src="/TrustWinPro/action/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/canvasjs.min.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/jquery.canvasjs.min.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/material-charts.js"></script>
<script type="text/javascript">
window.onload = function () {

//Better to construct options first and then pass it as a parameter
	var options = {
		title: {
			text: "Casdsauery Plugin"
		},
                animationEnabled: true,
		data: [
		{
			type: "column", //change it to line, area, bar, pie, etc
			dataPoints: [
				{ x: 10, y: 10 },
				{ x: 20, y: 11 },
				{ x: 30, y: 14 },
				{ x: 40, y: 16 },
				{ x: 50, y: 19 },
				{ x: 60, y: 15 },
				{ x: 70, y: 12 },
				{ x: 80, y: 10 }
			]
		}
		]
	};

	$("#chartContainer").CanvasJSChart(options);

}

$(document).ready(function() {
	var exampleBarChartData = {
		"datasets": {
			"values": [5, 10, 30, 50, 20],
			"labels": [
				"Apples", 
				"Oranges", 
				"Berries", 
				"Peaches", 
				"Bananas"
			],
			"color": "blue"
		},
		"title": "Example Bar Chart",
		"noY": true,
		"height": "300px",
		"width": "500px",
		"background": "#FFFFFF",
		"shadowDepth": "1"
	};

	MaterialCharts.bar("#bar-chart-example", exampleBarChartData)
</script>
</head>
<body>
<div id="chartContainer" style="height: 300px; width: 100%;"></div>
</body>

</html>
