<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />


<script type="text/javascript">
$(document).ready(function() {
	document.getElementById("chart_div_S").style.display = "none";	
	drawChart();
});

function drawChart(){
	var data = null;
    var table_data = null;
    var values2 =[];
    var labels2 = [];
    $.ajax({
        url:'/TrustWinPro/action/ajax/barChartProc.jsp',
        data: 'idx=',
        cache: false,
        success: function(res) {
       		table_data = eval("(" + res + ")");
			for(var i = 1; i < table_data.length; i++)	{
				values2.push(table_data[i][1]);
				labels2.push(table_data[i][0]);
			}
			var exampleBarChartData = {
					"datasets": {
						"values": values2,
						"labels": labels2,
						"color": "blue"
					},
					"title": "ÃâÀÔ ÀÎ¿ø",
					"noY": false,
					"height": "300px",
					"width": "1300px",
					"background": "#FFFFFF",
				};

				MaterialCharts.bar("#bar-chart-example", exampleBarChartData);
        }
   });

	
	
}


function statusBar()
{
	var array = document.barChart.check;
	var val = "";
	for(var i=0;i<array.length;i++){
		if(array[i].checked == true){
			val = val + array[i].value + ",";
			
		}
	}
     $.ajax({
         url:'/TrustWinPro/action/ajax/barStatusProc.jsp',
         data: 'val='+val,
         cache: false,
         success: function(res) {
      	  /* alert("StatusBar : " +val); */
      	  location.reload();
        	  document.getElementById("barChart").submit();
         }
    });
}


function statusWindowBar(){
	if(document.getElementById("chart_div").style.display == "none"){
		document.getElementById("chart_div").style.display = "block";	
		document.getElementById("chart_div_S").style.display = "none";	
	}else{
		document.getElementById("chart_div").style.display = "none";
		document.getElementById("chart_div_S").style.display = "block";	
	}
}

</script>


<div  style="width:100%; height:6px; font-size:0;  padding:2;" >
	<a href="#" onclick="statusWindowBar()"><input type="image" src="/TrustWinPro/action/image/setting.png" style="width:20px; height:20px; float:right"/></a>
</div>
<br>
<div>
	<section style = "overflow: hidden;border: 2px solid #46bebe; border-radius: 6px;-webkit-box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.15);
		box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.15);background: #fff; width: 100%; ">
	
		<ul style = "height: 45px;
		border-bottom: 1px solid #f2f2f2;
		position: relative;
		height: 44px;
		background: #72c8cd;
		list-style: none;
		margin: 0;
		padding: 0;
		color: #5a5a5a;
		font: normal 12px/0.9 Roboto, 'Nanum Gothic', 'µ¸¿ò', Dotum, '±¼¸²', Gulim, sans-serif;
		letter-spacing: 0.03em;">
		</ul>

		<div id="chart_div" >
					
			<div id="bar-chart-example"></div>
					
		</div>
	</section>
</div>

<div class="chart_div_S" id="chart_div_S" style = "position: relative;
    width: 100%;
    height: 200px;
    padding: 0 0 20px 0;
    margin: 0 0 20px 0;
    border: 1px solid #b4b4b4;
    border-radius: 6px;
    -webkit-box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.15);
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.15);
    background: #fff;">
	<form action="/TrustWinPro/action/index.jsp" name="barChart" id="barChart" method="post">
		<div class="chart_table">
			<table cellspacing="0"  class="titleEx1">
				<colgroup>
					<col width="50%">
					<col width="50%">
				</colgroup>
				<tr>
					<th>DeviceName</th>
					<th>Select</th>
				</tr>
			</table>
			<table cellspacing="0"  class="ex1">
				<colgroup>
					<col width="50%">
					<col width="50%">
				</colgroup>
				<tbody>
<%
	DeviceFunc DFunc = new DeviceFunc();
	Device[] dev = DFunc.searchDevice(null,null,null,null,null);
	EventFunc EFunc = new EventFunc();
	String barchart = EFunc.barChartVal();
	String[] barcharts = barchart.split(",");
	for(int i=0;i<dev.length;i++){
		String status = "";
		for(int j=0;j<barcharts.length;j++){
			if(dev[i].getID().equals(barcharts[j])){
				status = "checked";
				break;
			}
		}
%>
					<tr>
						<td><%=dev[i].getControllerName()%></td>
						<td><input type="checkbox" id="check" name="check" value="<%=dev[i].getID() %>" <%=status %>></td>
					</tr>
<%
	}
%>
				</tbody>
			</table>
			<div class="bottom" style="float:right">
				<a href="#" title="Enroll" onclick="statusBar()"class="button yellow" ><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/soket_logo.png" style="height:20px; width:17.5px"></span>submit</a>
			</div>
		</div>
	</form>
</div>
