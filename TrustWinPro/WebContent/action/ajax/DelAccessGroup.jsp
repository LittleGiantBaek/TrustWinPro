<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.Trustwin.Admin.Project.Access.*" %>
<%
	if(request.getParameter("num") == ""){
	
	}else{
		String Idx = (String)request.getParameter("num");
		AccessFunc Accfunc = new AccessFunc();
		Accfunc.delAccessGroup(Integer.parseInt(Idx));
	}
%>