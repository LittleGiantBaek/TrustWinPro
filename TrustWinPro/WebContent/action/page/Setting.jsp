<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Map.*" %>
<script type="text/javascript">
</script>
<section class="contents ng-scope" id="contents">

    <!-- title -->
    <div class="titleGroup">
        <h2 class="cntTitle"><b ng-label="common.setting">설정</b></h2>
    </div>

    <article class="settingMain">
        <ul>
            <li class="account" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/accounts"><span ng-label="common.account">계정</span></a></li>
            <li class="preference"><a href="#/setting/preference"><span ng-label="common.preference">기본 설정</span></a></li>
            <li class="card" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/card"><span ng-label="common.card">카드</span></a></li>
            <li class="cardformat" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/cardFormat"><span ng-label="common.cardFormat">카드 형식</span></a></li>
            <li class="server" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/server"><span ng-label="common.server">서버</span></a></li>
            <li class="triggerAction" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/triggerActions"><span ng-label="common.triggerAndAction">작업 조건 및 동작</span></a></li>
            <li class="schedule" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/schedule"><span ng-label="common.schedule">스케줄</span></a></li>
            <!--<li class="usbdevices"><a href="#/setting/usbdevices"></a></li>-->
            <!--<li class="badging"><a href="#/setting/badging"></a></li>-->
            <li class="alert" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/alert"><span ng-label="common.alert">경보</span></a></li>
            <!-- ngIf: displayHttps == true -->
            <li class="cloud" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/cloud"><span ng-label="common.cloud">클라우드</span></a></li>
            <li class="imageLog" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/imageLog"><span ng-label="common.imageLog">이미지 로그</span></a></li>
            <li class="bioMini" ng-privilege="SETTING" data-hide-when-not-allowed="true"><a href="#/setting/bioMini"><span ng-label="setting.bioMiniUSBAgent.title">BioMini USB AGENT</span></a></li>
        </ul>
    </article>

</section>