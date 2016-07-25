<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Access.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Timezone.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	AccessFunc Accfunc = new AccessFunc();
	DeviceFunc Devfunc = new DeviceFunc();
	TimeZoneFunc Timezonefunc = new TimeZoneFunc();
	LanguageFunc lanfunc = new LanguageFunc();
	
	int idxs = 0;
	if(request.getParameter("num") == null || request.getParameter("num").equals("")){
		AccessGroup[] group =  Accfunc.AccessGroupMenu();
		idxs = group[0].getIdx();
	}else{
		idxs = Integer.parseInt(request.getParameter("num"));
	}

	//DeviceInfo
	DeviceGroup[] device = null;
	device = Devfunc.GroupDefind();
	TimeZone[] time = null;
	time = Timezonefunc.TimeMenu();
	String lan = (String)session.getAttribute("nation");
%>
<script type="text/javascript">
	
	var change = 0;

	function accessDeviceList(v){
		if(v!=0){
			$(".Loading").css("display","block");
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/AccessDeviceList.jsp",   
			    data: "group=" + v,
			    success:function(args){   
			        $("#devicelist").html(args);
					$(".Loading").css("display","none"); 
					$("#default_devicelist").css("display","none");    
			    },   
			    error:function(e){  
			        alert("AcceessDeviceList Error!" + e.responseText);  
			    }  
			}); 
		}else{
			
		}
	}
	
	function allDeviceCheck(){
		var check = document.getElementsByName("checkD");
		if(change == 0){
			for(var i = 0 ; i < check.length;i++ ){
				check[i].checked = true;	
			}
				
			change = 1;
		}else{
			for(var i = 0 ; i < check.length;i++ ){
				check[i].checked = false;
			}
			
			change = 0;
		}
		
	}
	
	function accessDevice(){
		document.getElementById("AccessDevice").submit();
	}
	
	function accessDeviceClose(){
		document.getElementById("postitDevice").style.display = "none";
	}

</script>
<div class="accessDevice">
	<form name="AccessDevice" id="AccessDevice" method="post" action="/TrustWinPro/action/page/AccessDeviceAdd.jsp">
	<input type="hidden" name="idx" id="idx" value="<%=idxs %>" >
		<table>
			<colgroup>
				<col width="20%" align="center" >
				<col width="80%">
			</colgroup>
			<tr class="block">
				<td class="header" style="padding:13px;"><%=lanfunc.language(lan, 64) %> </td>
				<td class="main">
					<select name="Device" onchange="accessDeviceList(this.value);" onload="accessDeviceList(this.value);">
						<option value = "0" >-- <%=lanfunc.language(lan, 65)%> --</option>
<%
	DeviceGroup[] deviceGroup = null;
	deviceGroup = Devfunc.GroupDefind();
	
	int lengthD = deviceGroup.length;
	DeviceGroup[] dev = new DeviceGroup[lengthD];	
	dev = Devfunc.SortGroupOne(deviceGroup);
	for(int i=0;i < dev.length;i++){
%>
						<option value = "<%=dev[i].getIdx()%>"><%=dev[i].getGroupname() %></option>
<%
	}
%>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="default_devicelist">
						<table border=1 cellspacing="0"  class="titleEx2">
							<colgroup>
								<col width="10%">
								<col width="30%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
							</colgroup>
							<tr>
								<th><%=lanfunc.language(lan, 85) %>  <input type="checkbox" name="order" id="order" onclick="allDeviceCheck();" ></th>
								<th><%=lanfunc.language(lan, 66) %></th>
								<th><%=lanfunc.language(lan, 2) %></th>
								<th><%=lanfunc.language(lan, 3) %></th>
								<th><%=lanfunc.language(lan, 70) %></th>
							</tr>
						</table>
						<table cellspacing="0"  class="ex1">
							<colgroup>
								<col width="10%">
								<col width="30%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
							</colgroup>
								<tbody>
							</tbody>
						</table>
					</div>
					<div id="devicelist">
					
					</div>
				</td>
			</tr>
		</table>
		<div class="timeZone">
			<span class="title" style="padding:13px;"><%=lanfunc.language(lan, 111)%></span>
			<select name="timeSelect">
				<option value = "0" >-- <%=lanfunc.language(lan, 65)%> --</option>
<%
	for(int i=0;i<time.length;i++){
%>
				<option value = "<%=time[i].getTimeZoneName()%>"><%=time[i].getTimeZoneName() %></option>
<%
	}
%>
			</select>
		</div>
		<div class="buttom">
			<a href="#DeviceInfo" onclick="accessDevice();"><img src="/TrustWinPro/action/image/interface/submit.png"></a>
			<a href="#DeviceInfo" onclick="accessDeviceClose();"><img src="/TrustWinPro/action/image/interface/delete.png"></a>
		</div>
	</form>
</div>