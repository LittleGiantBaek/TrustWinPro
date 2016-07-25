<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	request.setCharacterEncoding("euc-kr");
	Connection conn = null;
	String[] idxs = request.getParameterValues("idx");
	String[] etcs = request.getParameterValues("etc");
	String sql = "";
	for(int i=0;i<idxs.length;i++){
		sql = "update Language set etc = '" + etcs[i] + "' where idx = "+idxs[i]+";";
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<script type="text/javascript">
			function replace(){
				document.getElementById("Language").submit();	
			}
		</script>
	</head>
	<body onload="replace();">
		<form action="/TrustWinPro/action/index.jsp" name="Language" id="Language" method="post">
			<input type="hidden" value="" name="left" />
			<input type="hidden" value="Language" name="content" />
		</form>
	</body>
</html>