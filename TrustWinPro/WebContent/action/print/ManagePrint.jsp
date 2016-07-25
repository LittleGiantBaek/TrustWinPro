<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%
	CategoryFunc func = new CategoryFunc();
	String div = (String)request.getParameter("div");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<link rel="stylesheet" type="text/css" href="/TrustWinPro/action/css/common.css" />
<script type="text/javascript" src="/TrustWinPro/action/js/common.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/calendar.js"></script>
<meta http-equiv="Content-Type" content="text/html; charset=euc-kr" />
<title>Print Page</title>
<script type="text/javascript">
function UserList(form,FN,MN,LN,DP){
	var arrayObj = "";
	var count = 0;
	for(i=0;i<form.info.length;i++){
		if(form.info[i].checked){
			arrayObj = arrayObj + form.info[i].value + ",";
			count++;
		}
	}
	if(count==0){
		alert("항목을 선택하세요");
		return false;
	}else{
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/PrintUserList.jsp",   
		    data: "array=" + arrayObj + "&FN="+FN+"&MN="+MN+"&LN="+LN+"&DP="+DP,
		    success:function(args){   
		        $("#UserList").html(args);      
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		});
	}
}

function DeviceList(form,CN,Add,ID,UID){
	var arrayObj = "";
	var count = 0;
	for(i=0;i<form.info.length;i++){
		if(form.info[i].checked){
			arrayObj = arrayObj + form.info[i].value + ",";
			count++;
		}
	}
	if(count==0){
		alert("항목을 선택하세요");
		return false;
	}else{
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/PrintDeviceList.jsp",
		    data: "array=" + arrayObj + "&CN="+CN+"&Add="+Add+"&ID="+ID+"&UID="+UID,
		    success:function(args){   
		        $("#DeviceList").html(args);      
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		});
	}
}


function EventList(form,SDate,EDate,STime,ETime,Name,User,Top){
	var arrayObj = "";
	var count = 0;
	for(i=0;i<form.info.length;i++){
		if(form.info[i].checked){
			arrayObj = arrayObj + form.info[i].value + ",";
			count++;
		}
	}
	if(count==0){
		alert("항목을 선택하세요");
		return false;
	}else{
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/PrintEventList.jsp",   
		    data: "array=" + arrayObj + "&SDate="+SDate+"&EDate="+EDate+"&STime="+STime+"&ETime="+ETime+"&Name="+Name+"&User="+User+"&Num="+Top,
		    success:function(args){   
		        $("#EventList").html(args);      
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		});
	}
}

var Uchange = 0;
function allUserCheck(){
	var check = document.userlist.info;
	if(Uchange == 0){
		for(var i = 0 ; i < check.length;i++ ){
			check[i].checked = true;	
		}
			
		Uchange = 1;
	}else{
		for(var i = 0 ; i < check.length;i++ ){
			check[i].checked = false;
		}
		
		Uchange = 0;
	}
	
}

var Dchange = 0;
function allDeviceCheck(){
	var check = document.devicelist.info;
	if(Dchange == 0){
		for(var i = 0 ; i < check.length;i++ ){
			check[i].checked = true;	
		}
			
		Dchange = 1;
	}else{
		for(var i = 0 ; i < check.length;i++ ){
			check[i].checked = false;
		}
		
		Dchange = 0;
	}
	
}

var Echange = 0;
function allEventCheck(){
	var check = document.eventlist.info;
	if(Echange == 0){
		for(var i = 0 ; i < check.length;i++ ){
			check[i].checked = true;	
		}
			
		Echange = 1;
	}else{
		for(var i = 0 ; i < check.length;i++ ){
			check[i].checked = false;
		}
		
		Echange = 0;
	}
	
}
</script>
</head>
<body>
	<div class="printContent">
<%
	if(div.equals("User")){ 
%>
		<jsp:include page="/action/print/UserPrint.jsp" flush="false"></jsp:include>
<%
	}else if(div.equals("Device")){
%>
		<jsp:include page="/action/print/DevicePrint.jsp" flush="false"></jsp:include>
<%		
	}else if(div.equals("Event")){
%>
		<jsp:include page="/action/print/EventPrint.jsp" flush="false"></jsp:include>
<%			
	}
%>
	</div>
</body>
</html>