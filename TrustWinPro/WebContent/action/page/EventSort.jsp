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
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<%@page import="com.Trustwin.Admin.Project.Event.EventFunc"%>
<%
	CategoryFunc func = new CategoryFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	
	String lan = (String)session.getAttribute("nation");
	
	String EventType = (String)request.getParameter("EventType");
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
	
	String searchStartTime= (String)request.getParameter("searchStartTime");
	if(searchEndTime != null){
		searchEndTime = new String(searchEndTime .getBytes("8859_1"), "UTF-8");	
	}
	
	int top = 0;
	if((String)request.getParameter("top")!=null){
			top = Integer.parseInt((String)request.getParameter("top"));
	}
	
	String[] dev = {"1","2", "3", "4", "5", "6", "7", "8", "9"};
	EventFunc EFunc = new EventFunc();
	String device = EFunc.eventVal();
	String[] devices = device.split(",");
	String status1 = "";
	String status2 = "";
	String status3 = "";
	String status4 = "";
	String status5 = "";
	String status6 = "";
	String status7 = "";
	String status8 = "";
	String status9 = "";
		for(int i=0;i<dev.length;i++){
			for(int j=0;j<devices.length;j++){
				if(dev[0].equals(devices[j])){
					status1 = "checked";
				} else if(dev[1].equals(devices[j])) {
					status2 = "checked";
				} else if(dev[2].equals(devices[j])) {
					status3 = "checked";
				} else if(dev[3].equals(devices[j])) {
					status4 = "checked";
				} else if(dev[4].equals(devices[j])) {
					status5 = "checked";
				} else if(dev[5].equals(devices[j])) {
					status6 = "checked";
				} else if(dev[6].equals(devices[j])) {
					status7 = "checked";
				} else if(dev[7].equals(devices[j])) {
					status8 = "checked";
				} else if(dev[8].equals(devices[j])) {
					status9 = "checked";
				}
			}
		}
%>

<script type="text/javascript">

function EventSorts(form,SDate,EDate,STime,ETime,Name,User,Num){
	var arrayObj = "";
	var count = 0;
	for(i=0;i<form.info.length;i++){
		if(form.info[i].checked){
			arrayObj = arrayObj + form.info[i].value + ",";
			count++;
			console.log(arrayObj);
		}
	}
	if(count==0){
		alert("항목을 선택하세요");
		return false;
	}else{ 
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/PrintEventList.jsp",
		    data: "array=" + arrayObj + "&SDate="+SDate+"&EDate="+EDate+"&STime="+STime+"&ETime="+ETime+"&Name="+Name+"&User="+User+"&Num="+Num,
		    success:function(args){   
				$(".tablebor").html(args);
				statusEvent();
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		});
	 }
}
	
	
function statusEvent()
{
	var array = document.eventlist.info;
	var val = "";
	for(var i=0;i<array.length;i++){
		if(array[i].checked == true){
			val = val + array[i].id + ",";
			
		}
	}
     $.ajax({
         url:'/TrustWinPro/action/ajax/eventStatusProc.jsp',
         data: 'val='+val,
         cache: false,
         success: function(res) {
      	  /* alert("StatusBar : " +val); */
      	location.reload();
        //document.getElementById("userlist").submit();
        	 $(".tablebor").html(args);
         }
    });
}	
	
	
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
	
	
	
	function accessDeviceClose2(){
		document.getElementById("postitEventSort").style.display = "none";
	}
	
	/* if($("input[name=info]").is(":checked"))	{
		status = "checked";
	} */
	
	
	$(document).ready( function(){
		   // read the current/previous setting
		    $("input.box[type=checkbox]").each(function() {
		        var name = $(this).attr('id');
		        if ($.cookie(name) && $.cookie(name) == "true") {
		            $(this).prop('checked', $.cookie(name));
		        }
		    });
		   // event management
		    $("input.box[type=checkbox]").change(function() {
		        var name = $(this).attr('id');
		        $.cookie(name, $(this).prop('checked'), {
		            path: '/',
		            expires: 365
		        });
		    });
		});

</script>
<div class="deviceSortPop">
<div class="selectBox">
<form name="eventlist" id="eventlist" method="post" action="">
<!-- <div class="printPage"> -->
		<div class="Title" style="text-align:center;color:white;padding-top:5px;height:30px;font-size:15px;background-color:#a49c9e">Event Sort
		<a href="#EventInfo" onclick="accessDeviceClose2();" style="float:right"><img src="/TrustWinPro/action/image/interface/delete.png"></a>	
		</div>
		<!-- <hr width="100%"> -->
		<table border="1" cellspacing="0" class="titleEx2" style="text-align:center" >
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
<td><input type="checkbox" name="info" value="EventType/72" id="1" <%=status1%>></td>
<td >EventType</td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="EventDate/73" id="2" <%=status2%>></td>
<td >EventDate</td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="EventTime/74" id="3" <%=status3%>></td>
<td >EventTime</td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="EventPlace/75" id="4" <%=status4%>></td>
<td >EventPlace</td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="EventName/76" id="5" <%=status5%>></td>
<td> EventName</td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="EventUserID/77" id="6" <%=status6%>></td>
<td >EventUserID</td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="EventUserName/78" id="7" <%=status7%>></td>
<td >EventUserName</td>
</tr>
<tr>
<td ><input type="checkbox" name="info" value="EventDoorState/79" id="8" <%=status8%>></td>
<td >EventDoorState</td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="EventCompanyID/80" id="9" <%=status9%>></td>
<td >EventCompanyID</td>
</tr>
</tbody>
</table>
<div class="buttom">
<a href="#" id="sortBtn" onclick="EventSorts(document.getElementById('eventlist'),'<%=searchStartDate%>','<%=searchEndDate%>','<%=EventTime%>','<%=searchEndTime%>', '<%=searchName %>', '<%=searchUser %>', '<%=top%>');" class="button gray"><span class="icon-check"></span>Sort</a>
</div>
<!-- div id="DeviceSorts" class="tableList2"></div> -->
</form>
<!-- 	</div> -->
</div>
	</div>
	</div>