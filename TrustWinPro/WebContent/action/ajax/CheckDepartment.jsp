<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.io.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%

// num은 새로 만들어지는 Depart의 Upnumber가 된다 -> parent
// dep는 새로 만들어지는 Depart의 Depth가 된다 -> parent depth + 1

	if(request.getParameter("num") == "" || request.getParameter("dep") == ""){

	}else{
		int Num = Integer.parseInt(request.getParameter("num"));
		int Dep = Integer.parseInt(request.getParameter("dep"));
		
		
		Connection conn = null;
		String sql_temp = "select count(*) from Member where Department = " + Num;
		
		Connection conn2 = null;
		String sql_depart = "select count(*) from Depart where UpNumber = " + Num;	
		
		
		try {
			int count = 0;
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			ResultSet rs = pstmt.executeQuery(sql_temp);

			while(rs.next()){
				count = rs.getInt(1);
			}
			
			//count : mumber가 존재 하지 않다면 0   //count2: 부서 하위에 부서가 존재하지 않다면 0 
			if(count == 0 ){ 
				try {
					int countdepart = 0;
					Context init2 = new InitialContext();
					DataSource ds2 = (DataSource)init2.lookup("java:comp/env/jdbc/MssqlDB");
					conn2 = ds2.getConnection();
					Statement pstmt2 = conn2.createStatement();
					ResultSet rs2 = pstmt2.executeQuery(sql_depart);
					
					while(rs2.next()){
						countdepart = rs2.getInt(1);
					}
					
					if(countdepart !=0){
						out.println(1);
					}
					else{
						out.println(3);
					}
					conn2.close();
				}catch(Exception e){
					out.println("DB error!!.");
					e.printStackTrace();}
			} 
			else
			{
				out.println(2);
			}
			
			
			conn.close();
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
	}
		
%>