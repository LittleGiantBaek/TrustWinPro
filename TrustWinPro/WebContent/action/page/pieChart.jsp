<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
<script src="//code.jquery.com/jquery.min.js"></script>
<script type="text/javascript">
	// 구글 파이차트 실시간 출력
	
	$( document ).ready(function() {
		document.getElementById("piechart_div_S").style.display = "none";	
		//google.charts.load('current', {'packages':['corechart']});
		google.charts.setOnLoadCallback(drawPiechart);
	}); 

	//google.charts.load('current', {'packages':['corechart']});
	//google.charts.setOnLoadCallback(drawInit);
	
	function drawChart(dataFromAjax){
		var data = google.visualization.arrayToDataTable(dataFromAjax);
		var option = {title: 'Event Name',is3D: false,};
		var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, option);
	}
	
	function drawPiechart(){
		var data = null;
		var table_data = null;
		$.ajax({
			url:'/TrustWinPro/action/ajax/pieChartProc.jsp',
			data:{},
			success: function(res){
				table_data = eval("(" + res + ")");
				drawChart(table_data);
			}
		});
	}
	
	function statusPie()
    {
    	var array = document.pieChart.check;
    	var val = "";
    	for(var i=0;i<array.length;i++){
    		if(array[i].checked == true){
    			val = val + array[i].value + ",";
    		}
    	}

    	$.ajax({
		     url:'/TrustWinPro/action/ajax/pieStatusProc.jsp',
		     data: 'val='+val,
		     success: function(res) {
		    	 //document.getElementById("pieChart").submit();
	        	   location.reload();
	        	   
		     }
		});
    }
    
    function statusWindowPie(){
    	if(document.getElementById("piechart_div_S").style.display == "none"){
    		document.getElementById("piechart_div_S").style.display = "block";	
    		document.getElementById("piechart_3d").style.display = "none";	
    	}else{
    		document.getElementById("piechart_div_S").style.display = "none";
    		document.getElementById("piechart_3d").style.display = "block";	
    	}
    }
	

	//google.setOnLoadCallback(drawInit);
	// drawInit(); 
	
</script>
<div  style="width:99%; height:6px; font-size:0; line-height:2; padding:2;" >

<a href="#a" onclick="statusWindowPie()"><input type="image" src="/TrustWinPro/action/image/setting.png" style="width:20px; height:20px; float:right;"/></a>
</div>
<br>
<div id="piechart_3d" style = "position: relative;
    width: 99%;
    height: 200px;
    padding: 0 0 20px 0;
    margin: 0 0 20px 0;
    border: 1px solid #b4b4b4;
    border-radius: 6px;
    -webkit-box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.15);
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.15);
    background: #fff;"></div>

<div class="chart_div_S" id="piechart_div_S" style = "position: relative;
    width: 97%;
    height: 200px;
    padding: 0 0 20px 0;
    margin: 0 0 20px 0;
    border: 1px solid #b4b4b4;
    border-radius: 6px;
    -webkit-box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.15);
    box-shadow: 0 1px 3px 0 rgba(0, 0, 0, 0.15);
    background: #fff;">
	<form action="/TrustWinPro/action/index.jsp" name="pieChart" id="pieChart" method="post">
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
	Device[] dev = DFunc.searchDevice(null,null,null,null);
	EventFunc EFunc = new EventFunc();
	String piechart = EFunc.pieChartVal();
	String[] piecharts = piechart.split(",");
	for(int i=0;i<dev.length;i++){
		String status = "";
		for(int j=0;j<piecharts.length;j++){
			if(dev[i].getID().equals(piecharts[j])){
				status = "checked";
				break;
			}else{
				status = "";
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
			<div class="bottom" id="web-buttons-idrmij3">
				<a href="#" title="Enroll" onclick="statusPie()">submit</a>
			</div>
		</div>
	</form>
</div>
