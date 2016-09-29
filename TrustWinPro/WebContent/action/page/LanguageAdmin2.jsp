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



	<div>
		<section class="sectionji" style="margin-bottom:10rem;">
			<ul class="ulji">
			</ul>
			<div>
				<form action="/TrustWinPro/action/page/LanAdmModify.jsp" name="LanModify" id="LanModify" method="post">
					<p></p>
					<input type="hidden" value="Setting" name="left" /> <input type="hidden" value=Setting_s name="content" />
					<p>
						<div class="headerji" style="font-size:15px;font-weight: bold;">Korea</div>
						<div class="headerji" style="font-size:15px;font-weight: bold;">English </div>
						<div class="headerji" style="font-size:15px;font-weight: bold;">Etc </div>
						<br><br>
					</p>
					
<%
	for(int i=0;i<lan.length;i++){
%>
				<p>
						<div class="headerji"><%=lan[i].getKo() %>	</div>
						<div class="headerji"><%=lan[i].getEn() %>	</div>
						<input type="text" name="etc" class="inputt" style="width: 250px" value="<%=lan[i].getEtc() %>" />
						<input type="hidden" name="idx" value="<%=lan[i].getIdx() %>" >
				</p>
<%
	}
%>
					<input type="button"  onclick="LanSubmit();" value="Save" class="ct-btn white" style="float: right; margin-right:3rem;" />
				</form>
			</div>

		</section>
	</div>
