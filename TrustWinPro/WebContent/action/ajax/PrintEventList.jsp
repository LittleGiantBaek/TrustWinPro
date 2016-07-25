<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<%
	String SDate = (String)request.getParameter("SDate");
	String EDate = (String)request.getParameter("EDate");
	String STime = (String)request.getParameter("STime");
	String ETime = (String)request.getParameter("ETime");
	String Name = (String)request.getParameter("Name");
	String User = (String)request.getParameter("User");
	String Top = (String)request.getParameter("Num");
	String[] List= request.getParameter("array").split(",");
	int[] listNum = new int[List.length];
	for(int i=0;i<List.length;i++){
		listNum[i] = Integer.parseInt(List[i].split("/")[1]);
	}
	EventFunc Evtfunc = new EventFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	if(Name != null){
		Name = new String(Name.getBytes("8859_1"), "UTF-8");	
	}
	
	if(User != null){
		User = new String(User.getBytes("8859_1"), "UTF-8");	
	}
	
	Event[] events = Evtfunc.searchEvent(SDate, EDate, STime, ETime, Name, User,Top); 
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
	for(int i=0;i<events.length;i++){
%>	
		<tr>
<%
		for(int j=0;j<List.length;j++){
			if(List[j].split("/")[1].equals("72")){
%>
			<td><%=events[i].getEventType() %></td>
<%
			}else if(List[j].split("/")[1].equals("73")){
%>
			<td><%=events[i].getEventDate() %></td>
<%				
			}else if(List[j].split("/")[1].equals("74")){
%>
			<td><%=events[i].getEventTime() %></td>
<%				
			}else if(List[j].split("/")[1].equals("75")){
%>
			<td><%=events[i].getEventPlace() %></td>
<%				
			}else if(List[j].split("/")[1].equals("76")){
%>
			<td><%=events[i].getEventName() %></td>
<%				
			}else if(List[j].split("/")[1].equals("77")){
%>
			<td><%=events[i].getEventUserid() %></td>
<%				
			}else if(List[j].split("/")[1].equals("78")){
%>
			<td><%=events[i].getEventUserName() %></td>
<%				
			}else if(List[j].split("/")[1].equals("79")){
%>
			<td><%=events[i].getEventDoorState() %></td>
<%				
			}else if(List[j].split("/")[1].equals("80")){
%>
			<td><%=events[i].getEventCompanyId() %></td>
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

	