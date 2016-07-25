<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.User.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%
	UserFunc Userfunc = new UserFunc();
	CategoryFunc catefunc = new CategoryFunc();
	request.setCharacterEncoding("euc-kr");
	String idx = (String)request.getParameter("idx");
	if(request.getParameterValues("checkU") == null ){

	}else{
		
		String[] userIdx = request.getParameterValues("checkU");
		String sql = "";
		
		
		for(int i=0;i<userIdx.length;i++){
			User user = Userfunc.SelUser(userIdx[i]);
			String department = catefunc.selCategory(user.getDepartment());
			Connection conn = null;
			
			sql = "Delete from AccessUser where access = '" + idx + "' and userID='"+ user.getUserId()+ "';";
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
			
			
			
			sql = "insert into AccessUser (userID, department, access ) values ('" + user.getUserId() + "', '" + department + "',"+idx+");";
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
				document.getElementById("AccessGroup").submit();	
			}
		</script>
	</head>
	<body onload="replace();">
		<form action="/TrustWinPro/action/index.jsp" name="AccessGroup" id="AccessGroup" method="post">
			<input type="hidden" value="<%=idx %>" name="num" />
			<input type="hidden" value="Time" name="left" />
			<input type="hidden" value="AccessGroup" name="content" />
		</form>
	</body>
</html>
