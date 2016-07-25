<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	CategoryFunc Catefunc = new CategoryFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	Language[] lan = Lanfunc.SelLanguage();
%>
<script type="text/javascript">
	function LanSubmit(){
		document.getElementById("LanModify").submit();
	}
</script>
<div id="Language">
	<div class="basic">
		<table cellspacing="0"  class="titleEx1">
			<colgroup>
				<col width="10%">
				<col width="30%">
				<col width="30%">
				<col width="30%">
			</colgroup>
			<tr>
				<th>idx</th>
				<th>ko</th>
				<th>en</th>
				<th>etc</th>
			</tr>
		</table>
		<form action="/TrustWinPro/action/page/LanAdmModify.jsp" name="LanModify" id="LanModify" method="post">
		<table cellspacing="0" class="ex1">
			<colgroup>
				<col width="10%">
				<col width="30%">
				<col width="30%">
				<col width="30%">
			</colgroup>
			<tbody>
	
<%
	for(int i=0;i<lan.length;i++){
%>
				<tr>
					<td><%=lan[i].getIdx() %></td>
					<td><%=lan[i].getKo() %></td>
					<td><%=lan[i].getEn() %></td>
					<td>
						<input type="text" name="etc" value="<%=LangUtil.Empty(lan[i].getEtc()) %>" >
						<input type="hidden" name="idx" value="<%=lan[i].getIdx() %>" >
					</td>
				</tr>
<%
	}
%>
			</tbody>
		</table>
		</form>
	</div>
	<div class="InfoButtom">
		<a href="#UserInfo" onclick="LanSubmit();"><img src="/TrustWinPro/action/image/interface/submit.png"></a>
	</div>
</div>


