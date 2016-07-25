<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.socket.*" %>
<%
	String ServerIP;
	int port;
	
	Connection conn = null;
	String sql = "select ServerIP, Port from dbo.SocketServer; ";

	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		
		ResultSet rs = pstmt.executeQuery(sql);
		rs.next();
		ServerIP = rs.getString(1);
		port = rs.getInt(2);
		rs.close();
		conn.close();	
		
		try{
			TCPClient client = new TCPClient(ServerIP, port);
			client.run();
			int result = 0; 
			
			String send = request.getParameter("Data");
			System.out.println(send);
			
			client.output(send);
			result = client.input();
			System.out.println(result);
			
			if(result != 0){
				out.print("success");
				client.end();
			}else{
				out.print("false");
				client.end();
			}
		}catch (Exception e){
			out.print("false");
			System.out.println(e);
		}
		
	}
	catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
	}
	
	
%>
	