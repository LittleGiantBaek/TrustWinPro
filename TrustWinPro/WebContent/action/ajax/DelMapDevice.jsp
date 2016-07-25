<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.Trustwin.Admin.Project.Map.*" %>
<%
	if(request.getParameter("devid") == ""){
	
	}else{
		String Idx = (String)request.getParameter("devid");
		MapFunc Accfunc = new MapFunc();
		Accfunc.DelMapDevice(Integer.parseInt(Idx));
	}
%>