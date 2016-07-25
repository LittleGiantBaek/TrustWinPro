<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%
	Connection conn = null;
	String[] array = request.getParameter("array").split(",");
	String[] color = request.getParameter("color").split(",");
	String sql = "";
	for(int i=0;i<array.length;i++){
		if(array[i].substring(0,1).equals("1")){
			sql = "update EventOption set Display = '1' , color = '" +color[i]+ "'";
			sql = sql +" where idx = "+array[i].substring(1)+";";	
			try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement();
				pstmt.executeUpdate(sql);
				
				pstmt.close();
				conn.close();
			}catch(Exception e){
				out.println("DB error!!.");
				e.printStackTrace();
			}
		}else{
			sql = "update EventOption set Display = '0'  , color = '" +color[i]+ "'";
			sql = sql +" where idx = "+array[i].substring(1)+";";	
			try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement();
				pstmt.executeUpdate(sql);
				
				pstmt.close();
				conn.close();
			}catch(Exception e){
				out.println("DB error!!.");
				e.printStackTrace();
			}
		}
		
	}
%>