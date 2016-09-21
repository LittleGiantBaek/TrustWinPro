<style>
/* @import url(http://fonts.googleapis.com/css?family=Open+Sans:400,700); */
@keyframes bake-pie {
  from {
    transform: rotate(0deg) translate3d(0,0,0);
  }
}

body {
  font-family: "Open Sans", Arial;
  background: #dcd6d3;
}
.main_div{
  width: 400px;
  margin: 10px auto;
}
section {
  margin-top: 10px;
}
.pieID {
  display: inline-block;
  vertical-align: top;
}
.pie {
  height: 200px;
  width: 200px;
  position: relative;
  margin: 0 30px 30px 0;
}
.pie::before {
  content: "";
  display: block;
  position: absolute;
  z-index: 1;
  width: 100px;
  height: 100px;
  background: #EEE;
  border-radius: 50%;
  top: 50px;
  left: 50px;
}
.pie::after {
  content: "";
  display: block;
  width: 120px;
 /*  height: 2px; */
  height: 0px;
  background: rgba(0,0,0,0.1);
  border-radius: 50%;
 /*  box-shadow: 0 0 3px 4px rgba(0,0,0,0.1); */
  margin: 220px auto;
  
}
.slice {
  position: absolute;
  width: 200px;
  height: 200px;
  clip: rect(0px, 200px, 200px, 100px);
  animation: bake-pie 1s;
}
.slice span {
  display: block;
  position: absolute;
  top: 0;
  left: 0;
  background-color: black;
  width: 200px;
  height: 200px;
  border-radius: 50%;
  clip: rect(0px, 200px, 200px, 100px);
}
.legend {
  list-style-type: none;
  padding: 0;
  margin: 0;
  background: #FFF;
  padding: 15px;
  font-size: 13px;
  box-shadow: 1px 1px 1px 1px #DDD,
              2px 2px 0 #BBB;
}
.legend li {
  width: 110px;
  height: 1.25em;
  margin-bottom: 0.7em;
  padding-left: 0.5em;
  border-left: 1.25em solid black;
}
.legend em {
  font-style: normal;
}
.legend span {
  float: right;
}	
</style>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%-- <%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%> --%>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
<script src="//code.jquery.com/jquery.min.js"></script>

<div class="dropdown" style="font-size:13px; width:99%; padding:2;  line-height:2;">
  <button onclick="statusWindowPie()" class="dropbtn" style="float:right">•••</button>
</div>
<!-- <div  style="width:99%; height:6px; font-size:0; line-height:2; padding:2;" >
<a href="#a" onclick="statusWindowPie()"><input type="image" src="/TrustWinPro/action/image/setting.png" style="width:20px; height:20px; float:right;"/></a>
</div> -->
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
    background: #fff;">
	<div class="main_div">
	  <!-- <h1>Event Names</h1> -->
	  <section>
	    <div class="pieID pie">
	    </div>
	    <ul class="pieID legend" id="pieChartData">
	    </ul>
	  </section>
	</div>
</div>

<div class="chart_div_S" id="piechart_div_S" style = "position: relative;
    width: 99%;
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
	Device[] dev = DFunc.searchDevice(null,null,null,null,null);
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
			<div class="bottom" style="float:right">
				<a href="#" title="Enroll" onclick="statusPie()"class="button yellow" ><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/soket_logo.png" style="height:20px; width:17.5px"></span>submit</a>
			</div>
		</div>
	</form>
</div>


<script>

$( document ).ready(function() {
	document.getElementById("piechart_div_S").style.display = "none";	
	drawPiechart();
}); 

function drawPiechart(){
	var data = null;
	var table_data = null;
	$.ajax({
		url:'/TrustWinPro/action/ajax/pieChartProc.jsp',
		data:{},
		cache: false,
		success: function(res){
			table_data = eval("(" + res + ")");
			
			for(var i = 1; i < table_data.length; i++)	
				$( "#pieChartData" ).append( "<li><em>"+table_data[i][0]+"</em><span>"+table_data[i][1]+"</span></li>" );
			createPie(".pieID.legend", ".pieID.pie");
		},
	     error : function(xhr, status, error) {
             alert("Chart Error!");
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
	     cache: false,
	     success: function(res) {
        	   location.reload();
	     },
	     error : function(xhr, status, error) {
                alert("Save Error!");
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


function sliceSize(dataNum, dataTotal) {
	  return (dataNum / dataTotal) * 360;
	}
	function addSlice(sliceSize, pieElement, offset, sliceID, color) {
	  $(pieElement).append("<div class='slice "+sliceID+"'><span></span></div>");
	  var offset = offset - 1;
	  var sizeRotation = -179 + sliceSize;
	  $("."+sliceID).css({
	    "transform": "rotate("+offset+"deg) translate3d(0,0,0)"
	  });
	  $("."+sliceID+" span").css({
	    "transform"       : "rotate("+sizeRotation+"deg) translate3d(0,0,0)",
	    "background-color": color
	  });
	}
	function iterateSlices(sliceSize, pieElement, offset, dataCount, sliceCount, color) {
	  var sliceID = "s"+dataCount+"-"+sliceCount;
	  var maxSize = 179;
	  if(sliceSize<=maxSize) {
	    addSlice(sliceSize, pieElement, offset, sliceID, color);
	  } else {
	    addSlice(maxSize, pieElement, offset, sliceID, color);
	    iterateSlices(sliceSize-maxSize, pieElement, offset+maxSize, dataCount, sliceCount+1, color);
	  }
	}
	function createPie(dataElement, pieElement) {
	  var listData = [];
	  $(dataElement+" span").each(function() {
	    listData.push(Number($(this).html()));
	  });
	  var listTotal = 0;
	  for(var i=0; i<listData.length; i++) {
	    listTotal += listData[i];
	  }
	  var offset = 0;
	  var color = [
	    "cornflowerblue", 
	    "olivedrab", 
	    "orange", 
	    "tomato", 
	    "crimson", 
	    "purple", 
	    "gray", 
	    "turquoise", 
	    "navy", 
	    "forestgreen"
	  ];
	  for(var i=0; i<listData.length; i++) {
	    var size = sliceSize(listData[i], listTotal);
	    iterateSlices(size, pieElement, offset, i, 0, color[i]);
	    $(dataElement+" li:nth-child("+(i+1)+")").css("border-color", color[i]);
	    offset += size;
	  }
	}

</script>