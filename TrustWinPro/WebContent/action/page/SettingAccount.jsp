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
			<h2>권한</h2>
			<div>
               	<h5 class="ng-binding">관리자</h5>
                	<form>
                		 <input type="radio" name="accountAdmin" value = "see"> 보기
                		 <input type="radio" name="accountAdmin" value = "edit"> 수정
                	<br>       
                	<input type="button" value="확인" onclick = "check3(this.form)">     
                	</form>        	      	
         </div>

			<div>
               	<h5 class="ng-binding">사용자</h5>
                	<form>
                		 <input type="radio" name="account" value = "see"> 보기
                		 <input type="radio" name="account" value = "edit"> 수정
                	<br>       
                	<input type="button" value="확인" onclick = "check3(this.form)">
                	</form>             	      	
         </div>
         </div>
    </article>
</div>
<%} %>
