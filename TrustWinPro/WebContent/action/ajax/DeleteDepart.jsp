<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.Trustwin.Admin.Project.User.*" %>
<%
	if(request.getParameter("idx") == ""){
	
	}else{
		String Idx = (String)request.getParameter("idx");
		UserFunc Userfunc = new UserFunc();
		Userfunc.departmentDelete(Integer.parseInt(Idx));
	}
%>