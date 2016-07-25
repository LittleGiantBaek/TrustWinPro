<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.User.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%
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
			<td><%=users[i].getUserId() %></td>
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
