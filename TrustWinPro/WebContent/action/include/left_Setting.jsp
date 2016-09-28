<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Map.*" %>
<%
	LanguageFunc Lanfunc = new LanguageFunc();
	String lan = (String)session.getAttribute("nation");
	String select_setting = (String)request.getParameter("SelectedContent");
%>
<script type="text/javascript">
	function Settingsubmit(v,i){
		var form = document.getElementById(v);
		form.content.value = "Setting_" + i;
		form.SelectedContent.value = i;
		form.submit();
	}
	$( document ).ready(function() {
		$("#Setting_"+'<%=select_setting%>').addClass("userspan");
	});
</script>
<div class="Setting">
	<ul>
		<li id="Setting_a"  ><img src="/TrustWinPro/action/image/interface/leftmapicon.png" style="width:13px;"><a  href="#in"onclick="Settingsubmit('SettingOption','a');"> Account</a></li>
		<li id="Setting_s"  ><img src="/TrustWinPro/action/image/interface/leftmapicon.png" style="width:13px;"><a  href="#in" onclick="Settingsubmit('SettingOption','s');"> Server</a></li>
		<li id="Setting_d"  ><img src="/TrustWinPro/action/image/interface/leftmapicon.png" style="width:13px;"><a  href="#in" onclick="Settingsubmit('SettingOption','d');"> DataBase</a></li>
	</ul>
</div>

<form action="/TrustWinPro/action/index.jsp" name="SettingOption" id="SettingOption" method="post">
	<input type="hidden" value="Setting" name="left" />
	<input type="hidden" value="SettingAccount" name="content" />
	<input type="hidden" value="" name="SelectedContent" />
</form>
