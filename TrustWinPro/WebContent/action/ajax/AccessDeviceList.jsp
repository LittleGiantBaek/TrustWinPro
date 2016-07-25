<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	int group= Integer.parseInt(request.getParameter("group"));
	int[] num = new int[1000];
	Arrays.fill(num, -1);
	
	DeviceFunc DevFunc = new DeviceFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	
	num[0] = group;
	
	DevFunc.setCount();
	num = DevFunc.DeviceGroupIdx(group,num);
	String lan = (String)session.getAttribute("nation");
%>
	<table border=1 cellspacing="0"  class="titleEx2">
		<colgroup>
			<col width="10%">
			<col width="30%">
			<col width="20%">
			<col width="20%">
			<col width="20%">
		</colgroup>
		<tr>
			<th><%=Lanfunc.language(lan, 85) %>  <input type="checkbox" name="order" id="order" onclick="allDeviceCheck();" ></th>
			<th><%=Lanfunc.language(lan, 66) %></th>
			<th><%=Lanfunc.language(lan, 2) %></th>
			<th><%=Lanfunc.language(lan, 3) %></th>
			<th><%=Lanfunc.language(lan, 70) %></th>
		</tr>
	</table>
	<table cellspacing="0"  class="ex1">
		<colgroup>
			<col width="10%">
			<col width="30%">
			<col width="20%">
			<col width="20%">
			<col width="20%">
		</colgroup>
		<tbody>
	
<%
	int num_length = 0;
	for(int i=0;i<num.length;i++)
			if(num[i] == -1 ){
				num_length = i+1;
				break;
			}
	
	for(int i=0;i<num_length;i++){
		Device[] device = DevFunc.DeviceSelect2(num[i]);
		int count = 0;
		for(int j=0;j<device.length;j++){
			if(count%2==0){
				out.println("<tr  class='odd'>");
			}else{
				out.println("<tr>");	
			}
			out.println("<td class='date1'><input type='checkbox' name='checkD' value='"+device[j].getUniqueID()+"' > </td>");
			out.println("<td class='date1'>" + device[j].getControllerName() + "</td>");
			out.println("<td class='date1'>" + device[j].getID() + "</td>");
			out.println("<td class='date1'>" + device[j].getAddress() + "</td>");
			out.println("<td class='date1'>" + device[j].getGroupIdx() + "</td>");
			out.println("</tr>");
			count++;
		}
	}

%>
		</tbody>
	</table>
