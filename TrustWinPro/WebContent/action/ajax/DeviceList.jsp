<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	int group= Integer.parseInt(request.getParameter("group"));
	int[] num = new int[1000];
	DeviceFunc Devfunc = new DeviceFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	num[0] = group;
	Devfunc.setCount();
	num = Devfunc.DeviceGroupIdx(group,num);
	String lan = (String)session.getAttribute("nation");
%>
	<table border=1 cellspacing="0"  class="titleEx1">
		<tr>
			<th><%=Lanfunc.language(lan, 124) %></th>
			<th><%=Lanfunc.language(lan, 2) %></th>
			<th><%=Lanfunc.language(lan, 3) %></th>
			<th><%=Lanfunc.language(lan, 67) %></th>
			<th><%=Lanfunc.language(lan, 5) %></th>
			<th><%=Lanfunc.language(lan, 6) %></th>
			<th><%=Lanfunc.language(lan, 7) %></th>
			<th><%=Lanfunc.language(lan, 70) %></th>
		</tr>
	</table>
	<table cellspacing="0"  class="ex1">
		<tbody>
	
<%
	int count = 0;
	for(int i=0;i<num.length;i++){
		Device[] device = Devfunc.DeviceSelect2(num[i]);
		for(int j=0;j<device.length;j++){
			if(count%2==0){
				out.println("<tr  class='odd'>");
			}else{
				out.println("<tr>");	
			}
			out.println("<td class='date1'>" + device[j].getControllerName() + "</td>");
			out.println("<td class='date1'>" + device[j].getID() + "</td>");
			out.println("<td class='date1'>" + device[j].getAddress() + "</td>");
			out.println("<td class='date1'>" + device[j].getPort() + "</td>");
			out.println("<td class='date1'>" + device[j].getPassword() + "</td>");
			out.println("<td class='date1'>" + device[j].getUniqueID() + "</td>");
			out.println("<td class='date1'>" + device[j].getServerPort() + "</td>");
			out.println("<td class='date1'>" + device[j].getGroupIdx() + "</td>");
			out.println("</tr>");
			count++;
		}
	}

%>
		</tbody>
	</table>
