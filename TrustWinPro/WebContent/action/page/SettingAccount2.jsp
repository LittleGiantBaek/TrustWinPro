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
		alertify.alert($("input[type=radio][name=accountAdmin]:checked").val());
	}
	function check4(form) {
		alertify.alert(form.DevAccount.value);

		alertify.alert(form.UserAccount.value);

		alertify.alert(form.ACAccount.value);

		alertify.alert(form.MonitoringAccount.value);
	}

	function SetAccount() {

		var queryString = $("form[name=Account]").serialize();
		//alert(queryString);		
		$.ajax({
					type : "post",
					url : "/TrustWinPro/action/ajax/AccountMode.jsp",
					data : "queryString=&"+queryString,
					success : function(args) {
						alertify.alert("저장되었습니다.");
					},
					error : function(e) {
						alertify.alert(e.responseText);
					}
				});
	}
</script>


<%
	if (userClass.equals("128")) {
%>
	<div>
		<section class="sectionji">
			<ul class="ulji">
			</ul>
			<div>
				<form action="/TrustWinPro/action/index.jsp" name="Account" method="post" style="padding-left:5%;">
					<p></p>
					<input type="hidden" value="Setting" name="left" /> <input type="hidden" value=Setting_s name="content" />
					<p>
						<div class="headerji">Device :</div>
						<input type="radio" name="DevAccount" value="see" <%=Account[0].equals("1") ? "checked" : ""%>> 보기 
						<input type="radio" name="DevAccount" value="edit" <%=Account[0].equals("2") ? "checked" : ""%>> 수정
						<%--  <input type="radio" name="DevAccount" value="hide" <%=Account[0].equals("3") ? "checked" : ""%>> 숨김 --%> 
					</p>
					<br>
					<p>
						<div class="headerji">User  :</div>
						<input type="radio" name="UserAccount" value="see" <%=Account[1].equals("1") ? "checked" : ""%>> 보기 
						<input type="radio" name="UserAccount" value="edit" <%=Account[1].equals("2") ? "checked" : ""%>> 수정 
						<%--  <input type="radio" name="UserAccount" value="hide" <%=Account[1].equals("3") ? "checked" : ""%>> 숨김 <br> <br> --%>
					</p>
					<br>
					<p>
						<div class="headerji">Access Control :</div>
						<input type="radio" name="ACAccount" value="see" <%=Account[2].equals("1") ? "checked" : ""%>> 보기 
						<input type="radio" name="ACAccount" value="edit" <%=Account[2].equals("2") ? "checked" : ""%>> 수정 
						<%-- <input type="radio" name="ACAccount" value="hide" <%=Account[2].equals("3") ? "checked" : ""%>> 숨김 <br> <br> --%>
					</p>
					<br>
					<p>
						<div class="headerji">Monitoring : </div>
						<input type="radio" name="MonitoringAccount" value="see" <%=Account[3].equals("1") ? "checked" : ""%>> 보기
						 <input type="radio" name="MonitoringAccount" value="edit" <%=Account[3].equals("2") ? "checked" : ""%>> 수정 
						 <%-- <input type="radio" name="MonitoringAccount" value="hide" <%=Account[3].equals("3") ? "checked" : ""%>> 숨김 <br> <br> --%> 
					</p>
					<input type="button" onclick="SetAccount();" value="Save" class="ct-btn white" style="float: right; margin-right:3rem;" />
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