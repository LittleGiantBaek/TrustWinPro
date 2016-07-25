<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%
	String ID = (String)request.getParameter("ID");
	EventFunc EFunc = new EventFunc();
	DeviceFunc DFunc = new DeviceFunc();
	String val = EFunc.barChartVal();
	StringBuilder sb = new StringBuilder();
	String[] TopVal = EFunc.EventPlaceList().split(",");
	String[] devVal = EFunc.barChartVal().split(",");
	
	
	int[] cnt = new int[devVal.length];
	Device temp_dv = new Device();
	
	if(TopVal.length == 0){
		sb.append("[['device','count'],");
		sb.append("]");
	}else{
		if(val.equals("")){
			cnt = EFunc.TopEventAc(TopVal);	
			sb.append("[['device','count']");
			for(int i=0;i<TopVal.length;i++){
				
				sb.append(",['"+TopVal[i]+"',"+cnt[i]+"]");
			}
			sb.append("]");
		}else{
			
			cnt = EFunc.selEventAC(devVal);
			sb.append("[['device','count']");
			for(int i=0;i<devVal.length;i++){
				temp_dv = DFunc.selDevice2(devVal[i]);
				sb.append(",['"+temp_dv.getControllerName()+"',"+cnt[i]+"]");
			}
			sb.append("]");
		}		
	}
%>
<%=sb.toString()%>
