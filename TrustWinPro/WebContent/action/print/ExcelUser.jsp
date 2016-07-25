<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.User.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
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
	UserFunc Userfunc = new UserFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	CategoryFunc Catefunc = new CategoryFunc();
	
	String FirstName = (String)request.getParameter("FN");
	if(FirstName != null){
		FirstName = new String(FirstName .getBytes("8859_1"), "UTF-8");	
	}
	
	String MiddleName = (String)request.getParameter("MN");
	if(MiddleName != null){
		MiddleName = new String(MiddleName .getBytes("8859_1"), "UTF-8");	
	}
	
	String LastName = (String)request.getParameter("LN");
	if(LastName != null){
		LastName = new String(LastName .getBytes("8859_1"), "UTF-8");	
	}
	
	int Department = 0;
	if((String)request.getParameter("DP")!=null){
		Department = Integer.parseInt((String)request.getParameter("DP"));
	}
	User[] users = Userfunc.UserList(FirstName, MiddleName, LastName, Department); 
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
	for(int i=0;i<users.length;i++){
%>	
		<tr>
<%
		for(int j=0;j<List.length;j++){
			if(List[j].split("/")[1].equals("26")){
%>
			<td><%=users[i].getFirstName() %></td>
<%
			}else if(List[j].split("/")[1].equals("27")){
%>
			<td><%=users[i].getMiddleName() %></td>
<%				
			}else if(List[j].split("/")[1].equals("28")){
%>
			<td><%=users[i].getLastName() %></td>
<%				
			}else if(List[j].split("/")[1].equals("29")){
%>
			<td style="mso-number-format:'\@'"><%=users[i].getUserId() %></td>
<%				
			}else if(List[j].split("/")[1].equals("30")){
%>
			<td><%=users[i].getUserClass() %></td>
<%				
			}else if(List[j].split("/")[1].equals("2")){
%>
			<td><%=users[i].getId() %></td>
<%				
			}else if(List[j].split("/")[1].equals("5")){
%>
			<td><%=users[i].getPassWord() %></td>
<%				
			}else if(List[j].split("/")[1].equals("39")){
				String name = Catefunc.selCategory(users[i].getDepartment());
%>
			<td><%=name %></td>
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
