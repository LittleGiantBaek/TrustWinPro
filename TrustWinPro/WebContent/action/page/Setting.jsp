<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Map.*" %>
<script type="text/javascript">
</script>
<%	 
String temp = "";
String temp1 = "";
String temp2 = "";
	temp = (String)request.getAttribute("SelectedContent");
	temp1 = (String)request.getAttribute("left");
	temp2 = (String)request.getAttribute("content");
%>
<section class="contents ng-scope" id="contents">

    <!-- title -->
    <div class="titleGroup">
        <h2 class="cntTitle"><b ng-label="common.setting">설정</b></h2>
    </div>

    <article class="settingMain">
        <ul>
            <li class="account" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#a" onclick="location.href='/TrustWinPro/action/index.jsp?content=SettingAccount'"><span ng-label="common.account">계정</span></a></li><br>
            <li class="preference"><a href="#/setting/preference"><span ng-label="common.preference">기본 설정</span></a></li><br>
            <li class="card" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/card"><span ng-label="common.card">카드</span></a></li><br>
            <li class="cardformat" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/cardFormat"><span ng-label="common.cardFormat">카드 형식</span></a></li><br>
            <li class="server" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/server"><span ng-label="common.server">서버</span></a></li><br>
            <li class="triggerAction" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/triggerActions"><span ng-label="common.triggerAndAction">작업 조건 및 동작</span></a></li><br>
            <li class="schedule" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/schedule"><span ng-label="common.schedule">스케줄</span></a></li><br>

        </ul>
    </article>

</section>