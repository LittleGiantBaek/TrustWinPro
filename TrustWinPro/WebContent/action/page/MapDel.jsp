<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Map.*" %>
<%
	MapFunc mapFunc = new MapFunc();
	Map map = mapFunc.topMap();
	
	if(request.getParameterValues("idx") != null){
		String idx = request.getParameter("idx");
		Connection conn = null;
		String sql = "Delete from MapDevice where deviceID = '" + idx + "'"; 
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			pstmt.executeUpdate(sql);

			sql = "Delete from Map where idx = '" + idx + "'"; 
			
			pstmt.executeUpdate(sql);
			conn.close();
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
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
		<form action="/TrustWinPro/action/index.jsp" name="Map" id="Map" method="post">
			<input type="hidden" value="" name="mapID" />
			<input type="hidden" value="Monitoring" name="left" />
			<input type="hidden" value="Map" name="content" />
		</form>
	</body>
</html>