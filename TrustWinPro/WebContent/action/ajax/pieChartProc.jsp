<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%
	EventFunc EFunc = new EventFunc();
	String val = EFunc.pieChartVal();
	StringBuilder sb = new StringBuilder();
	int[] cnt = new int[6];
	int count_sum =0;
	String[] devices = {"granted", "Denied", "UserEnroll", "SettingChange", "Alarm", "start"};
	
	if(val.equals("0")){
		cnt = EFunc.AllEventStatus();
	}else{
		cnt = EFunc.selEventStatus(val); //MainChart DB에 저장된 선택된 Device ID
	}

	sb.append("[['device','count']");
	for(int i=0;i<6;i++){
		sb.append(",['"+devices[i]+"',"+cnt[i]+"]");
		count_sum += cnt[i];
	}
	if(count_sum == 0)
		sb.append(",['Nothing Event',1]]");
	else
		sb.append("]");	

%>
<%=sb.toString()%>