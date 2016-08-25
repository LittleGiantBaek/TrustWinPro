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
			String valueOfId[] = send.split(",");
			System.out.println(send);
			for(int i =0; i < valueOfId.length; i++)
				{
					valueOfId[i] = valueOfId[i].replace("'", "");
					System.out.println("S,U,E,1," + valueOfId[i] + ",E");
					client.output("S,U,E,1," + valueOfId[i] + ",E");
					result = client.input();
					if(result != 0){
						out.print("success");
					}else{
						out.print("false");
					} 
				}
			client.end();
			
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
	