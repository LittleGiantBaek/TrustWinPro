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
	UserFunc Userfunc = new UserFunc();
	DeviceFunc Devfunc = new DeviceFunc();
	String userClass = (String) session.getAttribute("userClass");
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
	function check3(form) {
		alert($("input[type=radio][name=accountAdmin]:checked").val());
	}
	function check4(form) {
		alert(form.DevAccount.value);

		alert(form.UserAccount.value);

		alert(form.ACAccount.value);

		alert(form.MonitoringAccount.value);
	}

	function SetAccount() {

		var queryString = $("form[name=Account]").serialize();
		alert(queryString);
		$.ajax({
					type : "post",
					url : "/TrustWinPro/action/ajax/AccountMode.jsp",
					data : "queryString="+queryString,
					success : function(args) {
						location.href = "/TrustWinPro/WebContent/action/page/SettingAccount.jsp";
					},
					error : function(e) {
						alert(e.responseText);
					}
				});
	}
</script>


<%
	if (userClass.equals("128")) {
%>
<div class="contents ng-scope" id="contents">
	<article class="titleSubAct">
		<!-- title -->
		<div class="titleGroup">
			<button ng-click="backSetting()" class="btnBack"></button>
			<h2 class="cntTitle">
				<b ng-label="account.account">계정</b>
			</h2>
		</div>
	</article>
	<article class="formBox">
		<div class="cnt">
			<h2>사용자 권한</h2>
			<div>
				<form name="Account" id="Account" method="post">
					<h5>Device</h5>
					<input type="radio" name="DevAccount" value="see" <%=Account[0].equals("1") ? "checked" : ""%>> 보기 <input type="radio" name="DevAccount" value="edit" <%=Account[0].equals("2") ? "checked" : ""%>> 수정 <input type="radio" name="DevAccount" value="hide" <%=Account[0].equals("3") ? "checked" : ""%>> 숨김 <br> <br>
					<h5>User</h5>
					<input type="radio" name="UserAccount" value="see" <%=Account[1].equals("1") ? "checked" : ""%>> 보기 <input type="radio" name="UserAccount" value="edit" <%=Account[1].equals("2") ? "checked" : ""%>> 수정 <input type="radio" name="UserAccount" value="hide" <%=Account[1].equals("3") ? "checked" : ""%>> 숨김 <br> <br>
					<h5>AccessControl</h5>
					<input type="radio" name="ACAccount" value="see" <%=Account[2].equals("1") ? "checked" : ""%>> 보기 <input type="radio" name="ACAccount" value="edit" <%=Account[2].equals("2") ? "checked" : ""%>> 수정 <input type="radio" name="ACAccount" value="hide" <%=Account[2].equals("3") ? "checked" : ""%>> 숨김 <br> <br>
					<h5>Monitoring</h5>
					<input type="radio" name="MonitoringAccount" value="see" <%=Account[3].equals("1") ? "checked" : ""%>> 보기 <input type="radio" name="MonitoringAccount" value="edit" <%=Account[3].equals("2") ? "checked" : ""%>> 수정 <input type="radio" name="MonitoringAccount" value="hide" <%=Account[3].equals("3") ? "checked" : ""%>> 숨김 <br> <br> 
					<input type="button" value="확인" onclick="SetAccount();">
				</form>
			</div>
	</article>
</div>
<%
	} else {
%>
<script>
	alert("권한이 없습니다.");
	history.back();
</script>
<%
	}
%>