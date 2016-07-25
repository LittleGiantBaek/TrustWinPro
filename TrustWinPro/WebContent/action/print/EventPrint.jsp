<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	CategoryFunc func = new CategoryFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	
	String lan = (String)session.getAttribute("nation");
	String SDate = (String)request.getParameter("SDate");
	String EDate = (String)request.getParameter("EDate");
	String STime = (String)request.getParameter("STime");
	String ETime = (String)request.getParameter("ETime");
	
	String Name = (String)request.getParameter("Name");
	if(Name != null){
		Name = new String(Name .getBytes("8859_1"), "UTF-8");	
	}
	
	String User = (String)request.getParameter("User");
	if(User != null){
		User = new String(User .getBytes("8859_1"), "UTF-8");	
	}
	String Top = (String)request.getParameter("Num");
%>
<div>
	<div class="printPage">
		<div class="Title"><%=Lanfunc.language(lan, 176)%></div>
		<hr width="100%" hieght="2px;">
		<form name="eventlist" id="eventlist" method="post" action="">
			<div class="selectBox">
				<div class="smallTitle"><%=Lanfunc.language(lan, 177)%> <input type="checkbox" name="allcheck" onclick="allEventCheck();"></div>
				<div class="ListBox">
					<div><input type="checkbox" name="info" value="EventType/72"> <%=Lanfunc.language(lan, 72)%></div>
					<div><input type="checkbox" name="info" value="EventDate/73"> <%=Lanfunc.language(lan, 73)%></div>
					<div><input type="checkbox" name="info" value="EventTime/74"> <%=Lanfunc.language(lan, 74)%></div>
					<div><input type="checkbox" name="info" value="EventPlace/75"> <%=Lanfunc.language(lan, 75)%></div>
					<div><input type="checkbox" name="info" value="EventName/76"> <%=Lanfunc.language(lan, 76)%></div>
					<div><input type="checkbox" name="info" value="EventUserID/77"> <%=Lanfunc.language(lan, 77)%></div>
					<div><input type="checkbox" name="info" value="EventUserName/78"> <%=Lanfunc.language(lan, 78)%></div>
					<div><input type="checkbox" name="info" value="EventDoorState/79"> <%=Lanfunc.language(lan, 79)%></div>
					<div><input type="checkbox" name="info" value="EventCompanyID/80"> <%=Lanfunc.language(lan, 80)%></div>
				</div>
				<div class="buttom">
					<a href="#in" onclick="EventList(document.getElementById('eventlist'),'<%=SDate%>','<%=EDate%>','<%=STime%>','<%=ETime%>','<%=Name%>','<%=User%>','<%=Top%>')"><%=Lanfunc.language(lan, 179)%></a>
				</div>
			</div>
		</form>	
	</div>
	<div class="printShow">
		<div class="Title"><%=Lanfunc.language(lan, 178)%></div>
		<div class="buttom">
			<a href="#in" onclick="ieExecWB()">print</a> / <a href="#in" onclick="EventExcel(document.getElementById('eventlist'),'<%=SDate%>','<%=EDate%>','<%=STime%>','<%=ETime%>','<%=Name%>','<%=User%>','<%=Top%>');">excel</a>
		</div>
		<div id="EventList" class="tableList">
		
		
		</div>
		
	</div>
 </div>