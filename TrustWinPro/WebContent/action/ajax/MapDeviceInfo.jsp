<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Map.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	String DevID = (String)request.getParameter("deviceID");
	MapFunc mapfunc = new MapFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	String lan = (String)session.getAttribute("nation");
	Connection conn = null;
	String sql = "select top(1) EventPlace,EventName from dbo.History"; 
	
	String where = " where EventDate = CONVERT(CHAR(10), GETDATE(), 23) and DATEDIFF(ss, EventTime, CONVERT(CHAR(8), GETDATE(), 108)) < 10 and EventPlace = '"+DevID+"'";
	ResultSet rs = null;
	sql = sql + where;
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		rs = pstmt.executeQuery(sql);
		if(rs.next()){
%>
	<table cellspacing="0"  class="titleEx1">
		<colgroup>
			<col width="50%">
			<col width="50%">
		</colgroup>
		<tr>
			<th><%=Lanfunc.language(lan, 75) %></th>
			<th><%=Lanfunc.language(lan, 76) %></th>
		</tr>
	</table>
	<table cellspacing="0"  class="ex1">
		<colgroup>
			<col width="50%">
			<col width="50%">
		</colgroup>
		<tbody>
<%
			out.println("<tr>");	
			out.println("<td class='date1'>" + rs.getString(1) + "</td>");
			out.println("<td class='date1'>" + rs.getString(2) + "</td>");
			out.println("</tr>");
%>
		</tbody>
	</table>
<%
		}
		rs.close();
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}finally{
		if(rs !=null){
			rs.close();
		}
		if(conn != null){
			conn.close();
		}
	}
	
%>