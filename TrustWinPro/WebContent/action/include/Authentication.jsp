<%@ page language="java" contentType="text/html; charset=euc-kr" pageEncoding="euc-kr"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%
	Connection conn = null;
	String[] Account = null;
	String sql = "SELECT Device,[User],AccessControl,Monitoring FROM AccountMode Where UserClass = 1";
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		ResultSet rs = pstmt.executeQuery(sql);
		
		if(rs.next()){
		Account = new String[4];
		Account[0] = rs.getString(1);
		Account[1] = rs.getString(2);
		Account[2] = rs.getString(3);
		Account[3] = rs.getString(4);
		}
		conn.close();
	} catch (Exception e) {
		out.println("DB error!!.");
		e.printStackTrace();
	}
%>


<script type="text/javascript">
	if(<%=Account[0]%> != "2")
		$(".bt_device").empty(); //Device Button
	if(<%=Account[1]%> != "2")
		$(".bt_user").empty(); //User Button
	if(<%=Account[2]%> != "2")
		$(".bt_access").empty(); //Access Control Button
	if(<%=Account[3]%> != "2")
		$(".bt_monitoring").empty(); //Monitoring Control Button
</script>