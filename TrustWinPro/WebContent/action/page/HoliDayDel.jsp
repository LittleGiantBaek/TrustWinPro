<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
	if(request.getParameterValues("check") != null){
		String[] date = request.getParameterValues("check");
		Connection conn = null;
		for(int i=0;i<date.length;i++){
			String sql = "Delete from Holidays where HolidayDate = '" + date[i] + "'"; 
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
		}
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<script type="text/javascript">
			function replace(){
				document.getElementById("Holiday").submit();	
			}
		</script>
	</head>
	<body onload="replace();">
		<form action="/TrustWinPro/action/index.jsp" name="Holiday" id="Holiday" method="post">
			<input type="hidden" value="Time" name="left" />
			<input type="hidden" value="Holiday" name="content" />
		</form>
	</body>
</html>