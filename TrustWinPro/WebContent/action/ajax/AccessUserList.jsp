<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*"%>
<%@ page import="com.Trustwin.Admin.Project.User.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	int catenum = Integer.parseInt(request.getParameter("group"));
	int[] num = new int[1000];
	Arrays.fill(num, -1);
	
	CategoryFunc Catefunc = new CategoryFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	UserFunc Userfunc = new UserFunc();
	num[0] = catenum;
	Catefunc.setCount();
	num = Catefunc.CategoryIdx(catenum,num);
	String lan = (String)session.getAttribute("nation");
%>
	<table border=1 cellspacing="0"  class="titleEx2">
		<colcate>
			<col width="10%">
			<col width="30%">
			<col width="20%">
			<col width="20%">
			<col width="20%">
		</colcate>
		<tr>
			<th><%=Lanfunc.language(lan, 85) %> <input type="checkbox" name="order" id="order" onclick="allUserCheck();" ></th>
			<th><%=Lanfunc.language(lan, 29) %></th>
			<th><%=Lanfunc.language(lan, 81) %></th>
			<th><%=Lanfunc.language(lan, 125) %></th>
			<th><%=Lanfunc.language(lan, 126) %></th>
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
		User[] user = Userfunc.UserSelect2(num[i]);
		int count = 0;
		for(int j=0;j<user.length;j++){
			if(count%2==0){
				out.println("<tr  class='odd'>");
			}else{
				out.println("<tr>");	
			}
			out.println("<td class='date1'><input type='checkbox' name='checkU'  value='"+user[j].getId()+"' > </td>");
			out.println("<td class='date1'>" + user[j].getId() + "</td>");
			out.println("<td class='date1'>" + user[j].getName() + "</td>");
			out.println("<td class='date1'>" + user[j].getUserClass() + "</td>");
			out.println("<td class='date1'>" + user[j].getDepartment() + "</td>");
			out.println("</tr>");
			count++;
		}
	}

%>
		</tbody>
	</table>
