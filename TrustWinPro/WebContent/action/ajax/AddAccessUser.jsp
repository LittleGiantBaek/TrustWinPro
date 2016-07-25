<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Access.*" %>
<%@ page import="com.Trustwin.Admin.Project.User.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%
	UserFunc Userfunc = new UserFunc();
	CategoryFunc catefunc = new CategoryFunc();

	String access = request.getParameter("access");
	String user_id = request.getParameter("id");

	int idlen = user_id.length();
	String UserID = user_id;
	for(int i = idlen; i<8;i++){
		UserID = "0" + UserID;
	}
	User user = Userfunc.SelUserID(UserID);
	String department = catefunc.selCategory(user.getDepartment());
	
	
	Connection conn = null;
	String sql = "Delete from AccessUser where access = '" + access + "' and userID='"+ UserID+ "'"; 
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
	
	sql = "insert into AccessUser(UserID, department, access)"; 
	sql += " values('"+UserID+"','"+department+"','"+access+"')";
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