<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="javax.sql.*"%>
<%@ page import="javax.naming.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.Trustwin.Admin.Project.Category.*"%>
<%@ page import="com.Trustwin.Admin.Project.Device.*"%>
<%@ page import="com.Trustwin.Admin.Project.Language.*"%>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
	<%

		CategoryFunc Catefunc = new CategoryFunc();
		LanguageFunc Lanfunc = new LanguageFunc();
		DeviceFunc Devfunc = new DeviceFunc();
		request.setCharacterEncoding("utf-8");
		Connection conn = null;
		
		String ControllerName = (String) request.getParameter("searchControllerName");
		if (ControllerName != null) {
			ControllerName = new String(ControllerName.getBytes("8859_1"), "UTF-8");
		}
		String Address = (String) request.getParameter("searchAddress");
		if (Address != null) {
			Address = new String(Address.getBytes("8859_1"), "UTF-8");
		}

		String ID = (String) request.getParameter("searchID");
		if (ID != null) {
			ID = new String(ID.getBytes("8859_1"), "UTF-8");
		}

		String UniqueID = (String) request.getParameter("searchUniqueID");
		if ((String) request.getParameter("searchUniqueID") != null) {
			UniqueID = new String(UniqueID.getBytes("8859_1"), "UTF-8");
		}
		
		
		
		int GroupID = 0;
		List <Integer> ChildDepartmentArr = new ArrayList<Integer>();
		
		if ((String) request.getParameter("deviceGroupID") != null) {
			if(!((String)request.getParameter("deviceGroupID")).equals("")){
				GroupID = Integer.parseInt((String)request.getParameter("deviceGroupID"));
				Devfunc.departmentChildarr(GroupID, ChildDepartmentArr);
			} 
		}

		if((String) request.getParameter("searchDeviceGroup") != null) {
			if(!((String)request.getParameter("searchDeviceGroup")).equals("")){
				GroupID = Integer.parseInt((String)request.getParameter("searchDeviceGroup"));
				Devfunc.departmentChildarr(GroupID, ChildDepartmentArr);
			} 
		}
		//DeviceInfo
		DeviceGroup[] deviceGroup = null;
		deviceGroup = Devfunc.GroupDefind();
				
		Device[] devices = Devfunc.searchDevice(ControllerName, Address, ID, UniqueID, ChildDepartmentArr);
		String lan = (String) session.getAttribute("nation");
		
		String[] dev = {"1","2", "3", "4", "5", "6", "7"};
		EventFunc EFunc = new EventFunc();
		String device = EFunc.deviceVal();
		String[] devicess = device.split(",");
		String statuss1 = "notcheck";
		String statuss2 = "notcheck";
		String statuss3 = "notcheck";
		String statuss4 = "notcheck";
		String statuss5 = "notcheck";
		String statuss6 = "notcheck";
		String statuss7 = "notcheck";
			for(int i=0;i<dev.length;i++){
				for(int j=0;j<devicess.length;j++){
					if(dev[0].equals(devicess[j])){
						 statuss1 = "checked";
					} else if(dev[1].equals(devicess[j])) {
						 statuss2 = "checked";
					} else if(dev[2].equals(devicess[j])) {
						 statuss3 = "checked";
					} else if(dev[3].equals(devicess[j])) {
						 statuss4 = "checked";
					} else if(dev[4].equals(devicess[j])) {
						 statuss5 = "checked";
					} else if(dev[5].equals(devicess[j])) {
						 statuss6 = "checked";
					} else if(dev[6].equals(devicess[j])) {
						 statuss7 = "checked";
					}
				}
			}
	%>
<script type="text/javascript">
$(window).load(function() {
	 preview_print();
	$(".notcheck").css("display", "none");
	//alert("hello")
	//drawDevice();
}); 

/* $( ".tab>li>a" ).click(function() {
    $(this).parent().addClass("on").siblings().removeClass("on");
    return false;
}); */

function drawDevice()
{
     var data = null;
     var table_data = null;
     $.ajax({
         url:'/TrustWinPro/action/ajax/deviceStatusProc.jsp',
         data: 'idx=',
         cache: false,
         success: function(res) {
        	table_data = eval("(" + res + ")");
        	$(".tablebor").html(args);
         }
    });
}


function printPage(){
	 var initBody;
	 window.onbeforeprint = function(){
	  initBody = document.body.innerHTML;
	  document.body.innerHTML =  document.getElementById('TrustPrint').innerHTML;
	 };
	 window.onafterprint = function(){
	  document.body.innerHTML = initBody;
	 };
	 window.print();
	 return false;
	}
	
function preview_print(){
	   var OLECMDID = 7;
	   var PROMPT = 1;
	   var WebBrowser = '<OBJECT ID="WebBrowser1" WIDTH=0 HEIGHT=0 CLASSID="CLSID:8856F961-340A-11D0-A96B-00C04FD705A2"></OBJECT>';
	   document.body.insertAdjacentHTML('TrustPrint', WebBrowser);
	   WebBrowser1.ExecWB( OLECMDID, PROMPT);
}
	
	
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}

function deviceSort(){
	document.getElementById("postitDeviceSort").style.display = "block";
	document.getElementById("postitDeviceSort").style.top = "200px";
}

function deviceExcel(){
	document.getElementById("postitDeviceExcel").style.display = "block";
	document.getElementById("postitDeviceExcel").style.top = "200px";
}

var change = 0;
function allDeviceInfoCheck(){
	var check = document.deviceInfo.check;
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


function checkedF(num,v){
	var count = 0;
	var array = new Array();
	var check = document.deviceInfo.check;
	for(var i = 0; i< check.length; i++){
		if(check[i].checked){
			array[count] = check[i].value;
			count++;
		}
	}

	if(v==1){ // 전송
		if(num==count){
			Enroll('S,D,E,0,E');
		}else{
			var value = 'S,D,E,1,';
			for(var i=0;i<count;i++){
				value = value + array[i] + ',';
			}
			value = value + 'E';
			Enroll(value);
		}
	}else{	// 삭제
		if(num==count){
			Delete('S,D,D,0,E');
		}else{
			var value = 'S,D,D,1,';
			for(var i=0;i<count;i++){
				value = value + array[i] + ',';
			}
			value = value + 'E';
			Delete(value);
		}
	}
	
	
}


</script>
<div id="userdata">


	<div>
		<section class="sectionji">
			<ul class="ulji">
			</ul>

			<div>
				<form action="/TrustWinPro/action/index.jsp" name="allDevice"
					id="allDevice" method="post">
					<input type="hidden" value="Device" name="left" /> <input
						type="hidden" value="AllDevice" name="content" />
					<p>
					<div class="headerji">
						<%=Lanfunc.language(lan, 1)%>
						:
					</div>
					<input type="text" name="searchControllerName" class="inputt"
						value="<%=LangUtil.Empty(ControllerName)%>" />
					</p>

					<p>
					<div class="headerji">
						<%=Lanfunc.language(lan, 3)%>
						:
					</div>
					<input type="text" name="searchAddress" class="inputt"
						value="<%=LangUtil.Empty(Address)%>" />
					</p>

					<p>
					<div class="headerji">
						<%=Lanfunc.language(lan, 2)%>
						:
					</div>
					<input type="text" name="searchID" class="inputt"
						value="<%=LangUtil.Empty(ID)%>" />
					</p>

					<p>
					<div class="headerji">
						<%=Lanfunc.language(lan, 6)%>
						:
					</div>
					</p>
					
					
					<input type="text" name="searchUniqueID" class="inputt"
						value="<%=LangUtil.Empty(UniqueID)%>" /> 
						
					<p><div class = "headerji">
				<%=Lanfunc.language(lan, 39)%> : 
				</div>
				<select name="searchDeviceGroup" class = "hourselect">
					<option value="<%=0%>">== Select Option ==</option>
<%
	for(int i=0;i<deviceGroup.length;i++){


%>

					<option value="<%=deviceGroup[i].getIdx()%>" <%=deviceGroup[i].getIdx() == GroupID ? "selected" : "" %>><%=deviceGroup[i].getGroupname() %></option>
					
<%
	}
%>
				</select>	
						
						
				    <input type="submit"
						name="submit" value="<%=Lanfunc.language(lan, 182)%>"
						class="ct-btn white" style="margin-left: 3rem" />

					<!-- <div style="float: right; margin-right: 20px"">
						<a href="#a" onclick="DevicePrint();"><img
							src="/TrustWinPro/action/image/interface/printImage.jpg" alt=""></a>
					</div> -->
				</form>
			</div>

		</section>
	</div>
	<!--<div class="searchForm">
	</div> !-->
	<div class="dropdown" style="margin-left:1%; font-size:13px;">
  <button onclick="myFunction()" class="dropbtn">•••</button>
  <div id="myDropdown" class="dropdown-content">
  <!--ieExecWB();  -->
    <a href="#" onclick="printPage();">Print</a>
    <a href="#" onclick="deviceExcel();">Excel</a>
    <a href="#" onclick="deviceSort();">Sort</a>
  </div>
</div>
	
	
	<form action="" name="deviceInfo" id="deviceInfo" method="post">
		<div class="tablebor" id="TrustPrint">
			<table cellspacing="0" class="titleEx1">
				<colgroup>
					<col width="10%" class="deviceSelect">
					<%
						for(int i=0;i<devicess.length;i++){
					%>
						<col width="<%=100/devicess.length%>%" >
					<%
							}
					%>
			<%-- 		<col width="10%" class="deviceName" id="<%=statuss1%>">
					<col width="10%" class="deviceId" id="<%=statuss2%>">
					<col width="10%" class="deviceAddress" id="<%=statuss3%>">
					<col width="10%" class="devicePortNumber" id="<%=statuss4%>">
					<col width="14%" class="devicePassword" id="<%=statuss5%>">
					<col width="12%" class="deviceUniqueId" id="<%=statuss6%>">
					<col width="12%" class="deviceServerPort" id="<%=statuss7%>"> --%>
				</colgroup>
				<tr>
					<th class="deviceSelect"><%=Lanfunc.language(lan, 85)%><input type="checkbox"
						name="allcheck" onclick="allDeviceInfoCheck();" value=""></th>
					<th class="deviceName <%=statuss1%>" ><%=Lanfunc.language(lan, 1)%></th>
					<th class="deviceId <%=statuss2%>"><%=Lanfunc.language(lan, 2)%></th>
					<th class="deviceAddress <%=statuss3%>" ><%=Lanfunc.language(lan, 3)%></th>
					<th class="devicePortNumber <%=statuss4%>"><%=Lanfunc.language(lan, 4)%></th>
					<th class="devicePassword <%=statuss5%>" "><%=Lanfunc.language(lan, 5)%></th>
					<th class="deviceUniqueId <%=statuss6%>" "><%=Lanfunc.language(lan, 6)%></th>
					<th class="deviceServerPort <%=statuss7%>" ><%=Lanfunc.language(lan, 7)%></th>
				</tr>
			</table>
			<table cellspacing="0" class="ex1">
				<colgroup>
					<col width="10%" class="deviceSelect">
					<%
						for(int i=0;i<devicess.length;i++){
					%>
						<col width="<%=100/devicess.length%>%" >
					<%
							}
					%>
			<%-- 		<col width="10%" class="deviceName"  id="<%=statuss1%>">
					<col width="10%" class="deviceId"  id="<%=statuss2%>">
					<col width="10%" class="deviceAddress"  id="<%=statuss3%>">
					<col width="10%" class="devicePortNumber"  id="<%=statuss4%>">
					<col width="14%" class="devicePassword"  id="<%=statuss5%>">
					<col width="12%" class="deviceUniqueId"  id="<%=statuss6%>">
					<col width="12%" class="deviceServerPort"  id="<%=statuss7%>"> --%>
				</colgroup>
				<tbody>
					<%
						for (int i = 0; i < devices.length; i++) {
							if(i%2==1){
								out.println("<tr class='odd'>");
							}else{
								out.println("<tr>");	
							}
					%>
						<td class="deviceSelect"><input type="checkbox" name="check"
							value="<%=devices[i].getID()%>"></td>
						<td class='date1 deviceName <%=statuss1%>' ><a href="#a"
							onclick="submitDevice('Device','<%=devices[i].getID()%>')"><%=devices[i].getControllerName()%></a></td>
						<td class='date1 deviceId <%=statuss2%>' ><%=devices[i].getID()%></td>
						<td class='date1 deviceAddress <%=statuss3%>' ><%=devices[i].getAddress()%></td>
						<td class='date1 devicePortNumber <%=statuss4%>' ><%=devices[i].getPort()%></td>
						<td class='date1 devicePassword <%=statuss5%>' "><%=devices[i].getPassword()%></td>
						<td class='date1 deviceUniqueId <%=statuss6%>'><%=devices[i].getUniqueID()%></td>
						<td class='date1 deviceServerPort <%=statuss7%>' ><%=devices[i].getServerPort()%></td>
					</tr>
					<%
						}
					%>
				</tbody>
			</table>

		</div>

		<div class="bottom bt_device">
			<a href="#" title="Send"
				onclick="checkedF(<%=devices.length%>,1);" class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;"></span><%-- <%=Lanfunc.language(lan, 183)%> --%>Send</a>
			<a href="#" title="Delete"
				onclick="checkedF(<%=devices.length%>,2);" class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;"></span><%=Lanfunc.language(lan, 88)%></a>
		</div>
	</form>
		<div class="postitDeviceSort" id="postitDeviceSort" style="display:none">
		<jsp:include page="DeviceSort.jsp" flush="true">
			<jsp:param name="searchControllerName" value="<%=LangUtil.Empty(ControllerName)%>"/>
			<jsp:param name="searchAddress" value="<%=LangUtil.Empty(Address)%>"/>
			<jsp:param name="searchID" value="<%=LangUtil.Empty(ID)%>"/>
			<jsp:param name="searchUniqueID" value="<%=LangUtil.Empty(UniqueID)%>"/>
		</jsp:include>
		</div>
		
		<div class="postitDeviceExcel" id="postitDeviceExcel">
		<jsp:include page="DeviceExcel.jsp" flush="true">
			<jsp:param name="searchControllerName" value="<%=LangUtil.Empty(ControllerName)%>"/>
			<jsp:param name="searchAddress" value="<%=LangUtil.Empty(Address)%>"/>
			<jsp:param name="searchID" value="<%=LangUtil.Empty(ID)%>"/>
			<jsp:param name="searchUniqueID" value="<%=LangUtil.Empty(UniqueID)%>"/>
		</jsp:include>
		</div>
</div>
<form action="/TrustWinPro/action/index.jsp" name="Device" id="Device"
	method="post">
	<input type="hidden" value="Device" name="left" /> <input
		type="hidden" value="" name="deviceID" /> <input type="hidden"
		value="DeviceInfo" name="content" />
</form>



