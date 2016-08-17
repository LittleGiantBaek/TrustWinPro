<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.User.*" %>

<%
	CategoryFunc Catefunc = new CategoryFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	UserFunc Userfunc = new UserFunc();
	DeviceFunc Devfunc = new DeviceFunc();
	String userClass = (String)session.getAttribute("userClass");

%>

<script type="text/javascript">
 function check(country){
 alert(country);
   }
 function check2(form){
 for(var i=0; i<form.country.length;i++){
  if(form.country[i].checked == true){
   alert(i+"번째의 "+form.country[i].value + " 선택");
  }
 }
}
 function check3(form){
 	alert($("input[type=radio][name=accountAdmin]:checked").val());
 }
 function check4(form){
	 	alert(form.account.value);
	 }

 function form_check(f) { 
 if(f.account['0'].checked) { 
 f.stats.readOnly = true; // readonly 속성 지정 
 }else if(f.account['1'].checked) { 
 f.status.readOnly = true; // readonly 속성 지정 
 }
 } 
 alert(<%=request.getParameter("account1")%>);
 </script>

 
<%if(userClass.equals("128")){ %>
<div class="contents ng-scope" id="contents">
    <article class="titleSubAct">
        <!-- title -->
        <div class="titleGroup">
            <button ng-click="backSetting()" class="btnBack"></button>
            <h2 class="cntTitle"><b ng-label="account.account">계정</b></h2>
        </div>
        </article>
    <article class="formBox">
        <div class="cnt">
			<h2>사용자 권한</h2>
			<div>
               	<h5>Device</h5>
                	<form action="/TrustWinPro/action/index.jsp" name="Account" id="AccountDevice" method="post">
                		 <input type="radio" name="account1" value = "see" > 보기
                		 <input type="radio" name="account" value = "edit" > 수정
						 <input type="radio" name="account" value = "hide" > 숨김
                	<br><br>       
                	<input type="button" value="확인" onclick = "check4(this.form)">    
                	</form>        	      	
         </div>

			<div>
               	<h5>User</h5>
                	<form  action="/TrustWinPro/action/index.jsp" name="Account" id="AccountUser" method="post">
                		 <input type="radio" name="account" value = "see" > 보기
                		 <input type="radio" name="account" value = "edit" > 수정
						 <input type="radio" name="account" value = "hide" > 숨김
                	<br><br>       
                	<input type="button" value="확인" onclick = "check4(this.form)">   
                	</form>             	      	
         </div>
         			<div>
               	<h5>AccessControl</h5>
                	<form  action="/TrustWinPro/action/index.jsp" name="Account" id="AccountAccessControl" method="post">
                		 <input type="radio" name="account" value = "see" > 보기
                		 <input type="radio" name="account" value = "edit" > 수정
						 <input type="radio" name="account" value = "hide" > 숨김
                	<br><br>       
                	<input type="button" value="확인" onclick = "check4(this.form)">   
                	</form>             	      	
         </div>
         			<div>
               	<h5>Monitoring</h5>
                	<form  action="/TrustWinPro/action/index.jsp" name="Account" id="AccountMonitoring" method="post">
                		 <input type="radio" name="account" value = "see" > 보기
                		 <input type="radio" name="account" value = "edit" > 수정
						 <input type="radio" name="account" value = "hide" > 숨김
                	<br><br>       
                	<input type="button" value="확인" onclick = "check4(this.form)">   
                	</form>             	      	
         </div>
         </div>
    </article>
</div>
<%} else{%>
<script>alert("권한이 없습니다.");
history.back();
</script>
<%}%>