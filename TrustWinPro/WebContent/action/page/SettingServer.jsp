<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="com.Trustwin.Admin.Project.Category.*"%>
<%@ page import="com.Trustwin.Admin.Project.Language.*"%>
<%@ page import="com.Trustwin.Admin.Project.Device.*"%>
<%@ page import="com.Trustwin.Admin.Project.User.*"%>

<%

	CategoryFunc Catefunc = new CategoryFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	
	String userClass = (String) session.getAttribute("userClass");

	String ServerIP = (String) request.getParameter("Server_ip");
	String Port = (String) request.getParameter("Server_port");


	Connection conn = null;
	String sql = "";
	if (ServerIP != null && Port != null) {
		sql = "update SocketServer set ServerIP = '"+ ServerIP+"' , Port = '" + Port + "'";
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
	
	sql = "SELECT ServerIP, Port FROM SocketServer";
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource) init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		
		ResultSet rs = pstmt.executeQuery(sql);
		if(rs.next()){
			ServerIP = rs.getString(1);
			Port = rs.getString(2);
		}
		conn.close();
	} catch (Exception e) {
		out.println("DB error!!.");
		e.printStackTrace();
	}
%>

<script type="text/javascript">
	
</script>


<%
	if (userClass.equals("128")) {
%>
	<div>
		<section class="sectionji">
			<ul class="ulji">
			</ul>
			<div>
				<form action="/TrustWinPro/action/index.jsp" name="allDevice" id="allDevice" method="post">
					<p></p>
					<input type="hidden" value="Setting" name="left" /> <input type="hidden" value=Setting_s name="content" />
					<p>
						<div class="headerji">Server IP	:</div>
						<input type="text" name="Server_ip" class="inputt" value="<%=ServerIP%>" />
					</p>
					<p>
						<div class="headerji">Port :</div>
						<input type="text" name="Server_port" class="inputt" value="<%=Port%>" />
					</p>
					<input type="submit" name="submit" value="Save" class="ct-btn white" style="float: right; margin-right:3rem;" />
				</form>
			</div>

		</section>
	</div>
<%
	} else {
%>
<script>
alertify.alert("권한이 없습니다.");
</script>
<%
	}
%>