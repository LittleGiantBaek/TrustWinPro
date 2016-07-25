<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%
	String[] idxs = request.getParameterValues("check");
	Connection conn = null;
	String sql = ""; 
	if(idxs != null){
		for(int i=0;i<idxs.length;i++){
			try {
					sql = "Delete from AccessDevice where idx = " + idxs[i] + ";"; 
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
				document.getElementById("AccessGroup").submit();	
			}
		</script>
	</head>
	<body onload="replace();">
		<form action="/TrustWinPro/action/index.jsp" name="AccessGroup" id="AccessGroup" method="post">
			<input type="hidden" value="" name="num" />
			<input type="hidden" value="Time" name="left" />
			<input type="hidden" value="AccessGroup" name="content" />
		</form>
	</body>
</html>