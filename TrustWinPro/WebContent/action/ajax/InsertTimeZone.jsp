<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	String group = (String)request.getParameter("group");
	int value = 0;
	
	Connection conn = null;
	//String sql = "select TimeZoneNo from Timezone order by TimeZoneNo";
	String sql = "select TimeZoneNo from  Timezone  order by CAST(TimeZoneNo AS INT)";
	String No = "";
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		ResultSet rs = pstmt.executeQuery(sql);
		int val = 1;
		int res = 0;
		while(rs.next()){
			if(val != Integer.parseInt(rs.getString(1))){
				No = Integer.toString(val);
				res = 1;
				break;
			}
			val++;
		}
			
		if(res != 1){
			No = Integer.toString(val);
		}
		rs.close();
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	
	
	sql = "insert into Timezone(TimeZoneNo,TimeZoneName, HolSTime1, HolETime1, HolSTime2, HolETime2, MonSTime, MonETime, TueSTime, TueETime, WedSTime, WedETime, ThuSTime, ThuETime, FriSTime, FriETime, SatSTime, SatETime)"; 
	sql += " values('"+No+"','newTime','00:00:00','00:00:00','00:00:00','00:00:00','00:00:00','00:00:00','00:00:00','00:00:00','00:00:00','00:00:00','00:00:00','00:00:00','00:00:00','00:00:00','00:00:00','00:00:00')";
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		pstmt.executeUpdate(sql);
		
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
%>