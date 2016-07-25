<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.Trustwin.Admin.Project.Holiday.*" %>
<%
	if(request.getParameter("date") == ""){
	
	}else{
		String date = (String)request.getParameter("date");
		HoliDayFunc func = new HoliDayFunc();
		func.HolidayDelete(date);
	}
%>