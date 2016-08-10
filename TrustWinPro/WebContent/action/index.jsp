<%@ page contentType="text/html;charset=utf-8" errorPage="/common/error/error.jsp"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<%
	String id = (String)session.getAttribute("id");
	String nation = (String)session.getAttribute("nation");
	String userClass = (String)session.getAttribute("userClass");
	if(id == null || nation == null ){
%>
		<script type="text/javascript">
			alert("not Login! go LoginPage!");
			
			location.replace("Login.jsp");
		</script>
<%
	} 
%>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge, chrome=1" />
<link rel="stylesheet" type="text/css" href="/TrustWinPro/action/css/icon.css" />
<link rel="stylesheet" type="text/css" href="/TrustWinPro/action/css/common.css" />
<link rel="stylesheet" type="text/css" href="/TrustWinPro/action/css/timePicker.css" />
<script type="text/javascript" src="http://www.google.com/jsapi"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/jquery-1.11.1.min.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/common.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/jquery.timePicker.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/calendar.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/jquery.event.drag-2.2.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/jquery.event.drag.live-2.2.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/jquery.event.drop-2.2.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/jquery.event.drop.live-2.2.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/jscolor/jscolor.js"></script>
<script type="text/javascript" src="/TrustWinPro/action/js/contextmunu.js"></script>


<title>Trust</title>
<script type="text/javascript">
$(".Loading").css("display","none");
</script> 
</head>
<body class="mainBody">
<div id="Loading" class="Loading" >
	<div class="backImg">&nbsp;</div>
</div>
<div class="main" id="mainContent" >
   <jsp:include page="./include/top.jsp" flush="false"></jsp:include>
   <jsp:include page="./include/left.jsp" flush="false"></jsp:include>    
   <jsp:include page="./include/content.jsp" flush="false"></jsp:include>        
   <jsp:include page="./include/footer.jsp" flush="false"></jsp:include>
</div>

		<%
			if(userClass != null && !userClass.equals("128")){
		%>
			<script type = "text/javascript">
			$(".bottom").hide(); //Device Enroll button
			$(".DeviceButtom").hide();
			$(".InfoButtom").hide();
			$(".UserButtom").hide();
			$(".buttom").hide();
			$(".mainButtom").hide();
			</script>
		<%
		}
		%>
			
</body>
</html>

