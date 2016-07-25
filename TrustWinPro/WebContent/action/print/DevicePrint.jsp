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
	String ControllerName = (String)request.getParameter("searchControllerName");
	if(ControllerName != null){
		ControllerName = new String(ControllerName.getBytes("8859_1"), "UTF-8");	
	}
	String Address = (String)request.getParameter("searchAddress");
	if(Address != null){
		Address = new String(Address.getBytes("8859_1"), "UTF-8");	
	}
	
	String ID = (String)request.getParameter("searchID");
	if(ID != null){
		ID = new String(ID.getBytes("8859_1"), "UTF-8");	
	}
	
	String UniqueID = (String)request.getParameter("searchUniqueID");
	if((String)request.getParameter("searchUniqueID")!=null){
		UniqueID = new String(UniqueID.getBytes("8859_1"), "UTF-8");
	}
%>
<div>
	<div class="printPage">
		<div class="Title"><%=Lanfunc.language(lan, 176)%></div>
		<hr width="100%" hieght="2px;">
		<form name="devicelist" id="devicelist" method="post" action="">
			<div class="selectBox">
				<div class="smallTitle"><%=Lanfunc.language(lan, 177)%> <input type="checkbox" name="allcheck" onclick="allDeviceCheck();"></div>
				<div class="ListBox">
					<div><input type="checkbox" name="info" value="devicename/1"> <%=Lanfunc.language(lan, 1)%></div>
					<div><input type="checkbox" name="info" value="ID/2"> <%=Lanfunc.language(lan, 2)%></div>
					<div><input type="checkbox" name="info" value="Address/3"> <%=Lanfunc.language(lan, 3)%></div>
					<div><input type="checkbox" name="info" value="Port Number/4"> <%=Lanfunc.language(lan, 4)%></div>
					<div><input type="checkbox" name="info" value="Password/5"> <%=Lanfunc.language(lan, 5)%></div>
					<div><input type="checkbox" name="info" value="UniqueID/6"> <%=Lanfunc.language(lan, 6)%></div>
					<div><input type="checkbox" name="info" value="Server Port/7"> <%=Lanfunc.language(lan, 7)%></div>
				</div>
				<div class="buttom">
					<a href="#in" onclick="DeviceList(document.getElementById('devicelist'),'<%=ControllerName%>','<%=Address%>','<%=ID%>','<%=UniqueID%>')"><%=Lanfunc.language(lan, 179)%></a>
				</div>
			</div>
		</form>	
	</div>
	<div class="printShow">
		<div class="Title"><%=Lanfunc.language(lan, 178)%></div>
		<div class="buttom">
			<a href="#in" onclick="ieExecWB()">print</a> / <a href="#in" onclick="DeviceExcel(document.getElementById('devicelist'),'<%=ControllerName%>','<%=Address%>','<%=ID%>','<%=UniqueID%>');">excel</a>
		</div>
		<div id="DeviceList" class="tableList">
		
		
		</div>
		
	</div>
 </div>