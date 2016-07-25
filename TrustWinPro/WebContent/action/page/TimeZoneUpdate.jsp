<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%
	request.setCharacterEncoding("UTF-8");
	if(request.getParameter("result1") == "" || request.getParameter("timezoneNo") == ""){

	}else{
		String Res = (String)request.getParameter("result1");
		String[] array = Res.split("/");
		int time = Integer.parseInt(request.getParameter("timezoneNo"));
		int timem = Integer.parseInt(request.getParameter("timezoneNoM"));
		int count = 0;
		String timeName = (String)request.getParameter("timename");
		String sql = "update TimeZone set TimeZoneName = '" + timeName + "', TimeZoneNo = '" + timem + "', ";
		
		if(request.getParameter("result1").split("/").length==2){
			String StartTimeS1 = request.getParameter("result1").split("/")[0];
			String EndTimeE1 = request.getParameter("result1").split("/")[1];
			sql = sql + "HolSTime2 = '" + StartTimeS1 + "', HolETime2 = '" + EndTimeE1 + "', ";
			count++;
		}
		
		if(request.getParameter("result2").split("/").length==2){
			String StartTimeS2 = request.getParameter("result2").split("/")[0];
			String EndTimeE2 = request.getParameter("result2").split("/")[1];
			sql = sql + "MonSTime = '" + StartTimeS2 + "', MonETime = '" + EndTimeE2 + "', ";
			count++;
		}
		
		if(request.getParameter("result3").split("/").length==2){
			String StartTimeS3 = request.getParameter("result3").split("/")[0];
			String EndTimeE3 = request.getParameter("result3").split("/")[1];
			sql = sql + "TueSTime = '" + StartTimeS3 + "', TueETime = '" + EndTimeE3 + "', ";
			count++;
		}
		
		if(request.getParameter("result4").split("/").length==2){
			String StartTimeS4 = request.getParameter("result4").split("/")[0];
			String EndTimeE4 = request.getParameter("result4").split("/")[1];
			sql = sql + "WedSTime = '" + StartTimeS4 + "', WedETime = '" + EndTimeE4 + "', ";
			count++;
		}
		
		if(request.getParameter("result5").split("/").length==2){
			String StartTimeS5 = request.getParameter("result5").split("/")[0];
			String EndTimeE5 = request.getParameter("result5").split("/")[1];
			sql = sql + "ThuSTime = '" + StartTimeS5 + "', ThuETime = '" + EndTimeE5 + "', ";
			count++;
		}
		
		if(request.getParameter("result6").split("/").length==2){
			String StartTimeS6 = request.getParameter("result6").split("/")[0];
			String EndTimeE6 = request.getParameter("result6").split("/")[1];
			sql = sql + "FriSTime = '" + StartTimeS6 + "', FriETime = '" + EndTimeE6 + "', ";
			count++;
		}
		
		if(request.getParameter("result7").split("/").length==2){
			String StartTimeS7 = request.getParameter("result7").split("/")[0];
			String EndTimeE7 = request.getParameter("result7").split("/")[1];
			sql = sql + "SatSTime = '" + StartTimeS7 + "', SatETime = '" + EndTimeE7 + "', ";
			count++;
		}
		
		if(request.getParameter("result8").split("/").length==2){
			String StartTimeS8 = request.getParameter("result8").split("/")[0];
			String EndTimeE8 = request.getParameter("result8").split("/")[1];
			sql = sql + "HolSTime1 = '" + StartTimeS8 + "', HolETime1 = '" + EndTimeE8 + "' ";
			count++;
		}
		
		
		if(count > 0){
			Connection conn = null;
			sql = sql + " where TimeZoneNo = " + time;
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
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<script type="text/javascript">
			function replace(){
				document.getElementById("Time").submit();	
			}
		</script>
	</head>
	<body onload="replace();">
		<form action="/TrustWinPro/action/index.jsp" name="Time" id="Time" method="post">
			<input type="hidden" value="<%=timem %>" name="num" />
			<input type="hidden" value="Time" name="left" />
			<input type="hidden" value="Time" name="content" />
		</form>
	</body>
</html>
<%
	}
%>