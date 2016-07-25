<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	Connection conn = null;
	String id = request.getParameter("id");
	String userid = request.getParameter("userid");
	for(int i = userid.length();i<8;i++){
		userid = "0" + userid;
	}
	String sql = "select * from member where CardID = '" + id + "' and UserId <> '" + userid + "'";
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		
		ResultSet rs = pstmt.executeQuery(sql);
		rs.last();
		out.println(rs.getRow());
		
		rs.close();
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
%>