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
		
		//���� num�� Member�� �ִٸ� �߰��� ���� �ʴ´�.
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
			
			//mumber�� ���� ���� �ʴٸ� �߰� �ƴϸ� �߰� ����
			if(count == 0 ){ 
				String sql = "insert into depart(Name, UpNumber, Depth)"; 
				sql += " values('new department', "+ Num +","+ Dep +")";
				
				try {
						Context init = new InitialContext();
						DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
						conn = ds.getConnection();
						Statement pstmt = conn.createStatement();
						pstmt.executeUpdate(sql);
						conn.close();
						//System.out.println("complete depart add");
						
				}catch(Exception e){
					out.println("DB error!!.");
					e.printStackTrace();
				}
			} else
			{
				out.println(1);
				//System.out.println("Not complete depart add");
			}
			
			
			conn2.close();
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
	
		
		//
		
		/*
		String sql = "insert into depart(Name, UpNumber, Depth)"; 
		sql += " values('new department', "+ Num +","+ Dep +")";
		
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
		
		sql = "select Top 1 idx from depart order by idx desc";
		int idx = 0;
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			
			ResultSet rs = pstmt.executeQuery(sql);
			
			while(rs.next()){
				idx = rs.getInt(1);
			}
			
			rs.close();
			conn.close();
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
		
		
		
		
		sql = "update Member set department = " + idx + "where department = " + Num;
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
		*/
	}
		
%>