<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	LanguageFunc Lanfunc = new LanguageFunc();
	String lan = (String)session.getAttribute("nation");
	String FirstName = (String)request.getParameter("searchFirstName");
	if(FirstName != null){
		FirstName = new String(FirstName .getBytes("8859_1"), "UTF-8");	
	}
	String MiddleName = (String)request.getParameter("searchMiddleName");
	if(MiddleName != null){
		MiddleName = new String(MiddleName .getBytes("8859_1"), "UTF-8");	
	}
	
	String LastName = (String)request.getParameter("searchLastName");
	if(LastName != null){
		LastName = new String(LastName .getBytes("8859_1"), "UTF-8");	
	}
	
	int Department = 0;
	if((String)request.getParameter("searchDepartment")!=null){
		String temp = (String)request.getParameter("searchDepartment");
		if(!temp.equals("")){
	Department = Integer.parseInt((String)request.getParameter("searchDepartment"));
		}
	}
%>
<div>
	<div class="printPage">
		<div class="Title"><%=Lanfunc.language(lan, 176)%></div>
		<hr width="100%" hieght="2px;">
		<form name="userlist" id="userlist" method="post" action="">
			<div class="selectBox">
				<div class="smallTitle"><%=Lanfunc.language(lan, 177)%> <input type="checkbox" name="allcheck" onclick="allUserCheck();"></div>
				<div class="ListBox">
					<div><input type="checkbox" name="info" value="FirstName/26"> <%=Lanfunc.language(lan, 26)%></div>
					<div><input type="checkbox" name="info" value="MiddleName/27"> <%=Lanfunc.language(lan, 27)%></div>
					<div><input type="checkbox" name="info" value="LastName/28"> <%=Lanfunc.language(lan, 28)%></div>
					<div><input type="checkbox" name="info" value="UserID/29"> <%=Lanfunc.language(lan, 29)%></div>
					<div><input type="checkbox" name="info" value="UserClass/30"> <%=Lanfunc.language(lan, 30)%></div>
					<div><input type="checkbox" name="info" value="ID/2"> <%=Lanfunc.language(lan, 2)%></div>
					<div><input type="checkbox" name="info" value="Password/5"> <%=Lanfunc.language(lan, 5)%></div>
					<div><input type="checkbox" name="info" value="Department/39"> <%=Lanfunc.language(lan, 39)%></div>
				</div>
				<div class="buttom">
					<a href="#in" onclick="UserList(document.getElementById('userlist'),'<%=FirstName%>','<%=MiddleName%>','<%=LastName%>','<%=Department%>')"><%=Lanfunc.language(lan, 179)%></a>
				</div>
			</div>
		</form>	
	</div>
	<div class="printShow">
		<div class="Title"><%=Lanfunc.language(lan, 178)%></div>
		<div class="buttom">
			<a href="#in" onclick="ieExecWB()">print</a> / <a href="#in" onclick="UserExcel(document.getElementById('userlist'),'<%=FirstName%>','<%=MiddleName%>','<%=LastName%>','<%=Department%>');">excel</a>
		</div>
		<div id="UserList" class="tableList">
		
		
		</div>
		
	</div>
 </div>