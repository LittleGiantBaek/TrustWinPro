<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%
	String Idx = (String)request.getParameter("idx");
	String DIdx = (String)request.getParameter("Didx");
	DeviceFunc Devfunc = new DeviceFunc();	
	
	
	if(request.getParameter("idx") == ""){
		Devfunc.DeviceDelete(Integer.parseInt(DIdx));
	}else{
		Devfunc.DeviceGroupDelete(Integer.parseInt(Idx));
	}
%>