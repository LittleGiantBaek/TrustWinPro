<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%

// num�� ���� ��������� Depart�� Upnumber�� �ȴ� -> parent
// dep�� ���� ��������� Depart�� Depth�� �ȴ� -> parent depth + 1

	if(request.getParameter("num") == "" || request.getParameter("dep") == ""){

	}else{
		int Num = Integer.parseInt(request.getParameter("num"));
		int Dep = Integer.parseInt(request.getParameter("dep"));
		
		
		Connection conn = null;
		
		Connection conn2 = null;
		String sql_temp = "select count(*) from Member where Department = " + Num;
		
		try {
			int count = 0;
			Context init2 = new InitialContext();
			DataSource ds2 = (DataSource)init2.lookup("java:comp/env/jdbc/MssqlDB");
			conn2 = ds2.getConnection();
			Statement pstmt2 = conn2.createStatement();
			ResultSet rs2 = pstmt2.executeQuery(sql_temp);

			while(rs2.next()){
				count = rs2.getInt(1);
			}
			
			//mumber�� ���� ���� �ʴٸ� 0 �ƴϸ� 1
			if(count == 0 ){ 
				out.println(0);
			} else
			{
				out.println(1);
			}
			
			
			conn2.close();
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
	}
		
%>