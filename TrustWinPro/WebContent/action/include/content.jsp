<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%
	String content = (String)request.getParameter("content");
	String logtype = (String)request.getParameter("logtype");
	
	if(content == null){
		content = "";
	}
	if(logtype == null){
		logtype = "";
	}
%>

<div class="content">
<%
	if(content.equals("Home")){ 
%>
	<jsp:include page="/action/page/Log.jsp" flush="false"></jsp:include>
<%
	}else if(content.equals("User")){
%>
	<jsp:include page="/action/page/User.jsp" flush="false"></jsp:include>
<%		
	}else if(content.equals("AllUser")){
%>
	<jsp:include page="/action/page/AllUserList.jsp" flush="false"></jsp:include>
<%		
	}else if(content.equals("AllDevice")){
%>
	<jsp:include page="/action/page/AllDeviceList.jsp" flush="false"></jsp:include>
<%		
	}else if(content.equals("Log")){
%>
	<div>
		<form action="/TrustWinPro/action/index.jsp" name="realLog" id="realLog" method="post">
			<input type="hidden" value="realLog"  name="logtype" />
			<input type="hidden" value="Log" name="content" />
		</form>
		<form action="/TrustWinPro/action/index.jsp" name="searchLog" id="searchLog" method="post">
			<input type="hidden" value="searchLog" name="logtype" />
			<input type="hidden" value="Log" name="content" />
		</form>
	</div>
<%
		if(logtype.equals("searchLog")){
%>
	<jsp:include page="/action/page/LogSearch.jsp" flush="false"></jsp:include>
<%		
		}else{
%>
	<jsp:include page="/action/page/Log.jsp" flush="false"></jsp:include>
<%			
		}
	}else if(content.equals("UserInfo")){
%>
	<script type="text/javascript">
		$(".Loading").css("display","block");
	</script>
	<jsp:include page="/action/page/UserInfo.jsp" flush="false"></jsp:include>
<%	
	}else if(content.equals("DeviceInfo")){
%>
		<jsp:include page="/action/page/DeviceInfo.jsp" flush="false"></jsp:include>
<%	
	}else if(content.equals("Time")){
%>
		<jsp:include page="/action/page/TimeZone.jsp" flush="false"></jsp:include>
<%	
	}else if(content.equals("Holiday")){
%>
		<jsp:include page="/action/page/HoliDay.jsp" flush="false"></jsp:include>
<%	
	}else if(content.equals("AccessGroup")){
%>
		<jsp:include page="/action/page/AccessGroup.jsp" flush="false"></jsp:include>
<%	
	}else if(content.equals("Language")){
%>
		<jsp:include page="/action/page/LanguageAdmin.jsp" flush="false"></jsp:include>
<%	
	}else if(content.equals("Map")){
%>
		<jsp:include page="/action/page/Map.jsp" flush="false"></jsp:include>
<%	
	}else if(content.equals("MapSetup")){
%>
		<jsp:include page="/action/page/MapSetup.jsp" flush="false"></jsp:include>
<%	
	}else{
%>
		<jsp:include page="/action/page/main.jsp" flush="false"></jsp:include>
<%	
	}
%>

</div>
