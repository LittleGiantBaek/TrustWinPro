<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	request.setCharacterEncoding("utf-8");
	response.setHeader("Content-Type", "application/vnd.ms-excel");
	response.setHeader("Content-Transfer-Encoding", "binary");
	response.setHeader("Content-Disposition", "attachment; filename=\"userExcel.xls\"");

	String[] List= request.getParameter("array").split(",");
	int[] listNum = new int[List.length];
	for(int i=0;i<List.length;i++){
		listNum[i] = Integer.parseInt(List[i].split("/")[1]);
	}
	CategoryFunc func = new CategoryFunc();
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
	if((String)request.getParameter("searchUniqueID")!=null){
		UniqueID = new String(UniqueID.getBytes("8859_1"), "UTF-8");
	}
	
	Device[] devices = Devfunc.searchDevice(ControllerName, Address, ID, UniqueID); 
	String lan = (String)session.getAttribute("nation");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<style>
table.titleEx1{background:#596f84;background-size:cover;background-repeat:no-repeat;border:0; width:96%;margin:0 auto;padding:10px; margin:0;padding:0;color:#fff;-ms-filter: "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='/TrustWinPro/action/image/interface/titlebar.png',sizingMethod='scale')";  }
.titleEx1 th{padding:.2em 0;vertical-align:middle;font-weight:normal;text-align:center;}
table.ex1 {width:96%;margin:0 auto;padding:10px;}
table.ex1 ,.ex1 td,.ex1 th{border:0;border-collapse:collapse;margin:0;padding:0;}
.ex1 td, .ex1 th{padding:.2em 0;vertical-align:top;font-weight:normal;text-align:center;}
.ex1 thead th{text-transform:uppercase;color:#fff;}
.ex1 tbody td{background:#e1e9ef;}
.ex1 tbody th{background:#e1e9ef;}
.ex1 tbody tr.odd td{background:#fff;}
.ex1 tbody tr.odd th{background:#fff;}
.ex1 caption{text-align:left;text-transform:uppercase;letter-spacing:-1px;}
table.ex1 th a:link{color:#030;}
table.ex1 th a:visited{color:#003;}
table.ex1 td a:link{color:#369;}
table.ex1 td a:visited{color:#000;}
table.ex1 a:hover{text-decoration:none;}
table.ex1 a:active{color:#000;}
</style>
<meta http-equiv="Content-Type" content="application/vnd.ms-excel; charset=euc-kr" />
</head>
<body>
	<table>
		<tr>
			<td></td>
			<td colspan="<%=List.length-1%>"></td>
		</tr>
	</table>
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
	<table border=1 cellspacing="0"  class="ex1">
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
</body>
</html>
