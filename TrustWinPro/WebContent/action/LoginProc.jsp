<%@	page contentType="text/html;charset=euc-kr" errorPage="/common/error/error.jsp"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<%
	Connection conn = null;
	String sql = "select ID, Password, userClass from Member where ID = '" +request.getParameter("id")+ "' and Password = '" +request.getParameter("passwd")+ "';";
	
	try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			
			PreparedStatement pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			int count = 0;
			while(rs.next()){
				session.setAttribute("id", rs.getString(1));
				session.setAttribute("userClass", rs.getString(3));
				String lan = "";
				if(request.getParameter("language") != null){
					lan = request.getParameter("language");
				}else{
					lan = "ko";
				}
				session.setAttribute("nation", lan);
				count = 1;
			}
			if(count==1){
%>
	<script type="text/javascript">
		location.href="index.jsp";
	</script>
<%				
			}else{
%>
	<script type="text/javascript">
		alert("not correct member!!");
		location.href="Login.jsp";
	</script>
<%				
			}
			rs.close();
	}catch(Exception e){
		out.println("DB error!!");
		e.printStackTrace();
	}
%>
</head>
<body>
</body>
</html>