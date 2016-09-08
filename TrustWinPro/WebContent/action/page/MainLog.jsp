<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%
	
	String Num = "20";
	LanguageFunc Lanfunc = new LanguageFunc();
	EventFunc Evtfunc = new EventFunc();
	
	if(request.getParameter("Num")!=null){
		if(!request.getParameter("Num").equals("")){
			Num = (String)request.getParameter("Num");
		}
	}
	String lan = (String)session.getAttribute("nation");
	
	String STime = "";
	String ETime = "";
	
%>
<script type="text/javascript">
$(window).load(function() {
	$(".notcheck").css("display", "none");
	refresh();
}); 

function eventSort(){
	document.getElementById("postitMainEventSort").style.display = "block";
	document.getElementById("postitMainEventSort").style.top = "200px";
}

function eventExcel(){
	document.getElementById("postitMainEventExcel").style.display = "block";
	//document.getElementById("postitMainEventExcel").style.top = "200px";
}


function refresh(){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/LogB.jsp",   
	    data: "num=<%=Num%>",
	    success:function(args){   
	        $(".tablebor").html(args);      
	    },   
	    error:function(e){  
	        //alert(e.responseText);  
	    }  
	});  
}


/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}

function optionSubmit(){
	var count = 0;
	var array = "";
	var arrayName = "";
	var check = document.colorO.check;
	var name = document.colorO.colorName;
	for(var i = 0; i< check.length; i++){
		if(check[i].checked){
			array = array + "1" + check[i].value + ",";
			arrayName = arrayName + name[i].value + ",";
			count++;
		}else{
			array = array + "0" + check[i].value + ","
			arrayName = arrayName + name[i].value + ",";
		}
	}
	
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/ColorOption.jsp",   
	    data: "array=" + array + "&color="+arrayName,
	    success:function(args){   
	    	document.getElementById("colorO").submit();
	    },   
	    error:function(e){  
	        //alert(e.responseText);  
	    }  
	});  
	
}

function closeColor(){
	document.getElementById("colorOption").style.display = "none";
}

function openColor(){
	if(document.getElementById("colorOption").style.display == "none"){
		document.getElementById("colorOption").style.display = "block";	
	}else{
		document.getElementById("colorOption").style.display = "none";
	}
	
	
}

function printPage(){
	 var initBody;
	 window.onbeforeprint = function(){
	  initBody = document.body.innerHTML;
	  document.body.innerHTML =  document.getElementById('logdata').innerHTML;
	 };
	 window.onafterprint = function(){
	  document.body.innerHTML = initBody;
	 };
	 window.print();
	 return false;
	}




//refresh();
$(document).attr("timer",setInterval(refresh,1000));

</script>


<div id="userdata">
	<div class="colorOption" id="colorOption">
	<form action="/TrustWinPro/action/index.jsp" name="colorO" id="colorO" method="post">

		<table cellspacing="0"  class="titleEx1">
			<colgroup>
				<col width="20%">
				<col width="40%">
				<col width="40%">
			</colgroup>
			<tr>
				<th>Type</th>
				<th>Display</th>
				<th>Color</th>
			</tr>
		</table>
		<table cellspacing="0"  class="ex1">
			<colgroup>
				<col width="20%">
				<col width="40%">
				<col width="40%">
			</colgroup>
			<tbody>
<%
	EventOption[] eo = Evtfunc.selOption();
	for(int i=0; i < eo.length;i++){
%>
			<tr>
				<td><%=eo[i].getType() %></td>
				<td><input type="checkbox" value="<%=eo[i].getIdx()%>" name="check" <%=eo[i].getDisplay().equals("1")?"checked":"" %>></td>
				<td><input class="color" name="colorName" value="<%=eo[i].getColor() %>"></td>
			</tr>
<%
	}
%>
			</tbody>
		</table>

		<div class="button" id="web-buttons-idrmij3">
			<a href="#"  onclick="closeColor();"><%=Lanfunc.language(lan, 185)%></a>
			<a href="#"  onclick="optionSubmit();"><%=Lanfunc.language(lan, 92)%></a>
		</div>
	</form>
	</div>

<div class="dropdown" style="margin-left:1%; font-size:13px; width:96%">
  <button onclick="myFunction()" class="dropbtn">•••</button>
  <div id="myDropdown" class="dropdown-content">
  <!--ieExecWB();  -->
    <a href="#" onclick="printPage();">Print</a>
    <a href="#" onclick="eventExcel();">Excel</a>
    <a href="#" onclick="eventSort();">Sort</a>
  </div>
</div>
	<div class = "tablebor" style = "width: 96%; margin:3px">
		<div id="logdata">
		</div>
	</div>
</div>

<div class="postitEventExcel" id="postitMainEventExcel" style="display:none; width:65%; top:0%; left:20%;">
		<jsp:include page="MainEventExcel.jsp" flush="true">
			<jsp:param name="EventType" value=""/>
			<jsp:param name="EventDate" value=""/>
			<jsp:param name="EventTime" value=""/>
			<jsp:param name="EventPlace" value=""/>
			<jsp:param name="EventName" value=""/>
			<jsp:param name="searchUser" value=""/>
			<jsp:param name="searchName" value=""/>
			<jsp:param name="Num" value="<%=Num%>"/>
			<jsp:param name="EventDoorState" value=""/>
			<jsp:param name="EventCompanyID" value=""/>
			<jsp:param name="searchStartDate" value=""/>
			<jsp:param name="searchEndDate" value=""/>
			<jsp:param name="searchEndTime" value=""/>
			<jsp:param name="searchStartHour" value=""/>
			<jsp:param name="searchStartMinute" value=""/>
			<jsp:param name="searchStartSec" value=""/>
			<jsp:param name="searchEndHour" value=""/>
			<jsp:param name="searchEndMinute" value=""/>
			<jsp:param name="searchEndSec" value=""/>
		</jsp:include>
		</div>
		 
<div class="postitMainEventSort" id="postitMainEventSort" style="display:none;">
		<jsp:include page="MainEventSort.jsp" flush="true">
			<jsp:param name="EventType" value=""/>
			<jsp:param name="EventDate" value=""/>
			<jsp:param name="EventTime" value=""/>
			<jsp:param name="EventPlace" value=""/>
			<jsp:param name="EventName" value=""/>
			<jsp:param name="searchUser" value=""/>
			<jsp:param name="searchName" value=""/>
			<jsp:param name="Num" value="<%=Num%>"/>
			<jsp:param name="EventDoorState" value=""/>
			<jsp:param name="EventCompanyID" value=""/>
			<jsp:param name="searchStartDate" value=""/>
			<jsp:param name="searchEndDate" value=""/>
			<jsp:param name="searchEndTime" value=""/>
			<jsp:param name="searchStartHour" value=""/>
			<jsp:param name="searchStartMinute" value=""/>
			<jsp:param name="searchStartSec" value=""/>
			<jsp:param name="searchEndHour" value=""/>
			<jsp:param name="searchEndMinute" value=""/>
			<jsp:param name="searchEndSec" value=""/>
		</jsp:include>
</div>	


	