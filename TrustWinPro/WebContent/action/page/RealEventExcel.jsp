<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Access.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Timezone.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
CategoryFunc func = new CategoryFunc();
LanguageFunc Lanfunc = new LanguageFunc();

String lan = (String)session.getAttribute("nation");

String EventType = (String)request.getParameter("EventType");
System.out.println(EventType);
if(EventType != null){
	EventType = new String(EventType .getBytes("8859_1"), "UTF-8");	
}

String EventDate = (String)request.getParameter("EventDate");
if(EventDate != null){
	EventDate = new String(EventDate .getBytes("8859_1"), "UTF-8");	
}

String EventTime = (String)request.getParameter("EventTime");
if(EventTime != null){
	EventTime = new String(EventTime .getBytes("8859_1"), "UTF-8");	
}

String EventPlace = (String)request.getParameter("EventPlace");
if(EventPlace != null){
	EventPlace = new String(EventPlace .getBytes("8859_1"), "UTF-8");	
}

String EventName = (String)request.getParameter("EventName");
if(EventName != null){
	EventName = new String(EventName .getBytes("8859_1"), "UTF-8");	
}


String searchUser = (String)request.getParameter("searchUser");
if(searchUser != null){
	searchUser = new String(EventDate .getBytes("8859_1"), "UTF-8");	
}

String searchName = (String)request.getParameter("searchName");
if(searchName != null){
	searchName = new String(searchName .getBytes("8859_1"), "UTF-8");	
}

String EventDoorState= (String)request.getParameter("EventDoorState");
if(EventDoorState != null){
	EventDoorState = new String(EventDoorState .getBytes("8859_1"), "UTF-8");	
}


String EventCompanyID= (String)request.getParameter("EventCompanyID");
if(EventCompanyID != null){
	EventCompanyID = new String(EventCompanyID .getBytes("8859_1"), "UTF-8");	
}

String searchStartDate= (String)request.getParameter("searchStartDate");
if(searchStartDate != null){
	searchStartDate = new String(searchStartDate .getBytes("8859_1"), "UTF-8");	
}

String searchEndDate= (String)request.getParameter("searchEndDate");
if(searchEndDate != null){
	searchEndDate = new String(searchEndDate .getBytes("8859_1"), "UTF-8");	
}

String searchEndTime= (String)request.getParameter("searchEndTime");
if(searchEndTime != null){
	searchEndTime = new String(searchEndTime .getBytes("8859_1"), "UTF-8");	
}

int top = 0;
if((String)request.getParameter("Num")!=null){
		top = Integer.parseInt((String)request.getParameter("Num"));
}
%>

<script type="text/javascript">
var change = 0;


var change = 0;
function allDeviceCheck(){
	//var check = document.devicelist1.check;
	var check = document.getElementsByName("info");
	if(change == 0){
		for(var i = 0 ; i < check.length;i++ ){
			check[i].checked = true;	
		}
			
		change = 1;
	}else{
		for(var i = 0 ; i < check.length;i++ ){
			check[i].checked = false;
		}
		
		change = 0;
	}
	
	
}



function accessDevice(){
	document.getElementById("AccessDevice").submit();
}

function accessDeviceClose(){
	document.getElementById("postitRealEventExcel").style.display = "none";
}

</script>
<div class="deviceSortPop">
<form name="userlist1" id="userlist1" method="post" action="">
<div class="selectBox">
<!-- <div class="printPage"> -->
	<div class="Title" style="text-align:center;color:white;padding-top:5px;height:30px;font-size:15px;background-color:#a49c9e">Event Excel
	<a href="#EventInfo" onclick="accessDeviceClose();" style="float:right"><img src="/TrustWinPro/action/image/interface/delete.png"></a>	
	</div >
	<!-- <hr width="100%"> -->
	<!-- <div id="DeviceList" class="tableList"> -->
	<table border="1" cellspacing="0" class="titleEx2" style="text-align:center">
			<colgroup>
					<col width="10%">
					<col width="30%">
			</colgroup>
				<tbody>
				<tr>
					<th>Select  <input type="checkbox" name="allcheck" onclick="allDeviceCheck();"></th>
					<th>Column</th>
				</tr>
		</tbody>
	</table>
	<table cellspacing="0" class="ex1">
	<colgroup>
		<col width="10%">
		<col width="30%">
		<col width="20%">
		<col width="20%">
		<col width="20%">
		<col width="20%">
		<col width="20%">
		<col width="20%">
		<col width="20%">
	</colgroup>
	<tbody>

<tr class="odd">
<td><input type="checkbox" name="info" value="EventType/72" id="1" ></td>
<td >EventType</td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="EventDate/73" id="2" ></td>
<td >EventDate</td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="EventTime/74" id="3" ></td>
<td >EventTime</td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="EventPlace/75" id="4" ></td>
<td >EventPlace</td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="EventName/76" id="5" ></td>
<td> EventName</td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="EventUserID/77" id="6" ></td>
<td >EventUserID</td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="EventUserName/78" id="7" ></td>
<td >EventUserName</td>
</tr>
<tr>
<td ><input type="checkbox" name="info" value="EventDoorState/79" id="8" ></td>
<td >EventDoorState</td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="EventCompanyID/80" id="9" ></td>
<td >EventCompanyID</td>
</tr>
</tbody>
</table>
<div class="buttom" >
<a href="#EventInfo" onclick="RealEventExcel(document.getElementById('userlist1'),'<%=searchStartDate%>','<%=searchEndDate%>','<%=EventTime%>','<%=searchEndTime%>', '<%=searchName %>', '<%=searchUser %>', '<%=top %>');" class="button gray"><span class="icon-check"></span>Excel</a>
</div>

</div>
</form>
<!-- 	</div> -->
</div>
</div>