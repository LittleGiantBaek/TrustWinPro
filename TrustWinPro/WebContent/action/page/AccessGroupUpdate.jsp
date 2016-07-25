<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	String realFolder = "";
	String filename1 = "";
	String savefile = "img";
	request.setCharacterEncoding("UTF-8");
	Connection conn = null;
	
	String sql = "update AccessGroup set name = '"+request.getParameter("name")+"',info ='"+request.getParameter("info")+"' where idx = "+request.getParameter("idx")+";";
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

%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<script type="text/javascript">
			function replace(){
				document.getElementById("Access").submit();	
			}
		</script>
	</head>
	<body onload="replace();">
		<form action="/TrustWinPro/action/index.jsp" name="Access" id="Access" method="post">
			<input type="hidden" value="" name="num" />
			<input type="hidden" value="Time" name="left" />
			<input type="hidden" value="AccessGroup" name="content" />
		</form>
	</body>
</html>