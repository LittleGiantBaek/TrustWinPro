<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%
	String UID = (String)request.getParameter("deviceID");
	
	DeviceFunc devFunc = new DeviceFunc();
	
	UserList[] userlist = null;
	userlist = devFunc.DeviceUserList(UID);
	String lan = (String)session.getAttribute("nation");
%>

									<colgroup>
										<col width="5%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="5%">
										<col width="5%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<tbody>

<%
		for(int i=0;i < userlist.length;i++){
				out.println("<tr>");
				out.println("<td>" + userlist[i].getNo() + "</td>");
				out.println("<td>" + userlist[i].getUserID() + "</td>");
				out.println("<td>" + userlist[i].getName() + "</td>");
				out.println("<td>" + userlist[i].getDepartment() + "</td>");
				out.println("<td>" + userlist[i].getUserClass() + "</td>");
				out.println("<td>" + userlist[i].getCard() + "</td>");
				out.println("<td>" + userlist[i].getFP1() + "</td>");
				out.println("<td>" + userlist[i].getFP2() + "</td>");
				out.println("<td>" + userlist[i].getDeviceName() + "</td>");
				out.println("<td>" + userlist[i].getDeviceID() + "</td>");
				out.println("<td>" + userlist[i].getEtc() + "</td>");
				out.println("</tr>");
			}
%>
									</tbody>