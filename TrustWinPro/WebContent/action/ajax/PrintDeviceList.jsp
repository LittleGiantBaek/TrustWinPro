<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	String[] List= request.getParameter("array").split(",");
	int[] listNum = new int[List.length];
	for(int i=0;i<List.length;i++){
		listNum[i] = Integer.parseInt(List[i].split("/")[1]);
	}
	DeviceFunc Devfunc = new DeviceFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	String ControllerName = (String)request.getParameter("CN");
	if(ControllerName != null){
		ControllerName = new String(ControllerName.getBytes("8859_1"), "UTF-8");	
	}
	String Address = (String)request.getParameter("Add");
	if(Address != null){
		Address = new String(Address.getBytes("8859_1"), "UTF-8");	
	}
	
	String ID = (String)request.getParameter("ID");
	if(ID != null){
		ID = new String(ID.getBytes("8859_1"), "UTF-8");	
	}
	
	String UniqueID = (String)request.getParameter("UID");
	if(UniqueID !=null){
		UniqueID = new String(UniqueID.getBytes("8859_1"), "UTF-8");
	}

	Device[] devices = Devfunc.searchDevice(ControllerName, Address, ID, UniqueID); 
	String lan = (String)session.getAttribute("nation");
%>
	<table border=1 cellspacing="0"  class="titleEx1">
		<colgroup>
<%
	for(int i=0;i<List.length;i++){
%>
			<col width="<%=100/List.length%>%">
<%
	}
%>
			
		</colgroup>
		<tr>
<%
	for(int i=0;i<List.length;i++){
%>
			<td align="center"><%=Lanfunc.language(lan, listNum[i]) %></td>
<%
	}
%>
		</tr>
	</table>
	<table cellspacing="0"  class="ex1">
		<colgroup>
<%
	for(int i=0;i<List.length;i++){
%>
			<col width="<%=100/List.length%>%">
<%
	}
%>
			
		</colgroup>
		<tbody>
	
<%
	for(int i=0;i<devices.length;i++){
%>	
		<tr>
<%
		for(int j=0;j<List.length;j++){
			if(List[j].split("/")[1].equals("1")){
%>
			<td><%=devices[i].getControllerName() %></td>
<%
			}else if(List[j].split("/")[1].equals("2")){
%>
			<td><%=devices[i].getID() %></td>
<%				
			}else if(List[j].split("/")[1].equals("3")){
%>
			<td><%=devices[i].getAddress() %></td>
<%				
			}else if(List[j].split("/")[1].equals("4")){
%>
			<td><%=devices[i].getPort() %></td>
<%				
			}else if(List[j].split("/")[1].equals("5")){
%>
			<td><%=devices[i].getPassword() %></td>
<%				
			}else if(List[j].split("/")[1].equals("6")){
%>
			<td><%=devices[i].getUniqueID() %></td>
<%				
			}else if(List[j].split("/")[1].equals("7")){
%>
			<td><%=devices[i].getServerPort() %></td>
<%			
			}else if(List[j].split("/")[1].equals("8")){
%>
			<td><%=devices[i].getServerPort() %></td>
<%			
			}else{
				j--;
			}
		}
%>
		</tr>
<%
	}
%>
		</tbody>
	</table>
