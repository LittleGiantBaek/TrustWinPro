<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Map.*" %>
<%
	String ID = (String)request.getParameter("mapID");
	DeviceFunc devFunc = new DeviceFunc();
	Device[] dev = devFunc.deviceList();
	MapFunc mapFunc = new MapFunc();
	MapDevice[] mapDev = mapFunc.selMapDev(ID);
	Map map = mapFunc.selMap(ID);
%>
<script type="text/javascript">
function addMapDevice(v){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/AddMapDevice.jsp",   
	    data: "id="+v,
	    success:function(args){
	    	location.href = "/TrustWinPro/action/index.jsp?left=Monitoring&content=MapSetup&mapID=" + <%=ID%>;
	    },   
	    error:function(e){  
	        alert(e.responseText);  
	    }  
	}); 
}

function delMapDevice(x){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/DelMapDevice.jsp",   
	    data: "devid="+x,
	    success:function(args){
	    	location.href = "/TrustWinPro/action/index.jsp?left=Monitoring&content=MapSetup&mapID=" + <%=ID%>;
	    },   
	    error:function(e){  
	        alert(e.responseText);  
	    }  
	}); 
}

function updMapDevice(x,v){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/UpdateMapDevice.jsp",   
	    data: "idx="+v + "&id=" + x,
	    success:function(args){
	    	location.href = "/TrustWinPro/action/index.jsp?left=Monitoring&content=MapSetup&mapID=" + <%=ID%>;
	    },   
	    error:function(e){
	        alert(e.responseText);
	    }  
	}); 
}

function MapInfoSubmit(){
	MapInfomating.submit();
}

function MapCancel(){
	canMap.submit();
}
</script>

<div id="MapInfo">
	<div class="basic">
		<form action="/TrustWinPro/action/page/MapSetupModify.jsp" name="MapInfomating" id="MapInfomating" method="post"  enctype="multipart/form-data" >
			<input type="hidden" value="<%=ID%>"  name="id" />
			

			<section class = "sectionji">
			<ul class = "ulji">
			</ul>

			<div class="basicInfo">
				<div class="InfoBox">
					<div class="block">
						<div class="header">MAP 이름</div>
						<div class="main"><input type="text" name="mapName" value="<%=map.getName() %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header">MAP File</div>
						<div class="main">
							<input type="file" name="saveFile" id="saveFile"  value="<%=map.getImage() %>" >
						</div>
					</div>
					<table border=1 cellspacing="0" class="titleEx1">
						<colgroup>
							<col width="10%">
							<col width="40%">
							<col width="20%">
							<col width="20%">
							<col width="10%">
						</colgroup>
						<tr>
							<th>번호</th>
							<th>디바이스 명</th>
							<th>X 좌표</th>
							<th>Y 좌표</th>
							<th>추가 <a href="#a" onclick="addMapDevice('<%=ID%>')">+</a></th>
						</tr>
					</table>
					<table cellspacing="0"  class="ex1">
						<colgroup>
							<col width="10%">
							<col width="40%">
							<col width="20%">
							<col width="20%">
							<col width="10%">
						</colgroup>
						<tbody>
			<%
					for(int i=0;i<mapDev.length;i++){
			%>
							<tr>
								<td><%=i+1%></td>
								<td class='date1'>
									<select name="deviceName" onchange="updMapDevice(this.value,<%=mapDev[i].getIdx()%>);">
										<option value="0">-- None --</option>
<%
						for(int j=0;j<dev.length;j++){
							String device = mapDev[i].getDeviceID(); 
							if(device == null){
								device = "";
							}
%>
										<option value="<%=dev[j].getControllerName()%>" <%=device.equals(dev[j].getControllerName())?"selected" : "" %>><%=dev[j].getControllerName()%></option>
<%
						}
%>
									</select>
								</td>
								<td class='date1'><%=mapDev[i].getX() %></td>
								<td class='date1'><%=mapDev[i].getY() %></td>
								<td class='date1'><a href="#a" onclick="delMapDevice(<%=mapDev[i].getIdx()%>)">삭제</a></td>
							</tr>
			<%
					}
			%>	
						</tbody>
					</table>
				</div>
			</div>
		</section>


			<div class="bottom" id="web-buttons-idrmij3">
				<a href="#a" onclick="MapInfoSubmit();"><img src="/TrustWinPro/action/image/interface/submit.png"></a>
				<a href="#a" onclick="MapCancel();" ><img src="/TrustWinPro/action/image/interface/delete.png"></a>
			</div>
		</form>
	</div>
</div>
<form name="canMap" id="canMap" method="post" action="/TrustWinPro/action/index.jsp" >
	<input type="hidden" value="<%=ID%>"  name="mapID" />
	<input type="hidden" value="Monitoring" name="left" />
	<input type="hidden" value="Map" name="content" />
</form>
