<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.Trustwin.Admin.Project.Timezone.*" %>
<%
	if(request.getParameter("num") == ""){
	
	}else{
		String Idx = (String)request.getParameter("num");
		TimeZoneFunc Timefunc = new TimeZoneFunc();
		Timefunc.delTime(Integer.parseInt(Idx));
	}
%>