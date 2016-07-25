<%@	page contentType="text/html;charset=euc-kr" errorPage="/common/error/error.jsp"%>
<%@ page import="com.Trustwin.Admin.Project.Dbcheck.*" %>
<%
	DBCheck check = new DBCheck();
	check.AccessDeviceCheck();
	check.AccessGroupCheck();
	check.AccessUserCheck();
	check.AlarmTimeCheck();
	check.AutoDoorCheck();
	check.AutoKeyCheck();
	check.DepartCheck();
	check.DeviceGroupCheck();
	check.EventOptionCheck();
	check.History2Check();
	check.HistoryCheck();
	check.HistoryTempCheck();
	check.HolidaysCheck();
	check.LanguageCheck();
	check.ManageModeCheck();
	check.MemberCheck();
	check.NoActKeyCheck();
	check.SetupSerialCheck();
	check.SetupTcpipCheck();
	check.SunshineCheck();
	check.Table_1Check();
	check.TimezoneCheck();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<link rel="stylesheet" type="text/css" href="/TrustWinPro/action/css/common.css" />
<script type="text/javascript" src="/TrustWinPro/action/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/jquery.ezmark.min.js"></script>
<title>Login Page</title>
<script type="text/javascript">
<%
	String Id = (String)session.getAttribute("id");
	if(Id != null ){
		if(!Id.equals("")){
%>
	location.href="index.jsp";
<%
		}
	}
%>

	function init(id){
		document.getElementById(id).value = "";
	}
	function indexSubmit(){
		member.submit();
	}
	
	$(document).ready(
		function(){
			$("input[type=radio]").ezMark();
		}
	);
</script>
</head>
<body>
<div class="wrap">
	<div class="start">
		<div class="login">
			<form name="member" method="post" action="LoginProc.jsp">
				<div class="loginImage"><img src="/TrustWinPro/action/image/interface/login01.png" /></div>
				<div class="loginLogo"><img src="/TrustWinPro/action/image/interface/login02.png" /></div>
				<div class="inputBox">
					<input type="text" name="id" class="id" value="ID" size="28" id="id" onclick="init('id');"  onfocus="init(id);"/>
					<input type="password" name="passwd" class="password" value="1111" size="30" id="pw" onfocus="init('pw');" onkeypress="if(event.keyCode==13){member.submit();}"  />
					<div class="radioBox">
						<label>en</label> <input type="radio" value="en" name="language" checked />
						<label>ko</label> <input type="radio" value="ko" name="language" />
						<label>etc</label> <input type="radio" value="etc" name="language" />
					</div>
				</div>
				<div class="LoginButtom">
					<a href="#in" onclick="indexSubmit();"><img src="/TrustWinPro/action/image/login/enter.png" /></a>
				</div>
			</form>
		</div>
		<div class="loginlogo">
			<img src="/TrustWinPro/action/image/interface/loginlogo.png" />
		</div>
	</div>
</div>
</body>
</html>