<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DecimalFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Access.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.AlarmTime.*" %>
<%@ page import="com.Trustwin.Admin.Project.AutoDoor.*" %>
<%@ page import="com.Trustwin.Admin.Project.AutoKey.*" %>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<%@ page import="com.Trustwin.Admin.Project.Timezone.*" %>
<%
	SimpleDateFormat timeFormat = new SimpleDateFormat("yyyy-MM-dd");
	String today = timeFormat.format(new Date());
	String UID = (String)request.getParameter("deviceID");
	
	DeviceFunc devFunc = new DeviceFunc();
	EventFunc Evtfunc = new EventFunc();
	AlarmFunc alFunc = new AlarmFunc();
	AutoDoorFunc autoDoor = new AutoDoorFunc();
	AutoKeyFunc autoKey = new AutoKeyFunc();
	AccessFunc Accfunc = new AccessFunc();
	TimeZoneFunc Timezonefunc = new TimeZoneFunc();
	
	LanguageFunc lanFunc = new LanguageFunc();

	TimeZone[] time = null;
	time = Timezonefunc.TimeMenu();
	
	String lan = (String)session.getAttribute("nation");
	if(UID == null){
		
		UID = devFunc.DeviceTop();
	}
	Connection conn = null;
	String sql = "select ControllerName, ID, Address, Port, Password, UniqueID, ServerPort, photo, DoorRelay, DoorMode, " + 
			"DoorTime, DoorAlarm, CdType, ReAccess, Cd2Fun, AlmRelayFun, AlmBuzzFun, AntiPass, Fire, IdSecret, Limit, VoiceOut, MachineID, " +
			"Baudrate, DeviceTime, UserCount, ManagerCount, FpCount, CardCount, SLogTotal, SLogRead, GLogTotal, GLogRead, CurDoorMode, DoorStatus, "+
			"MPCI, BGI from SetupTcpip where  id = '"+UID+"';";
	try {
			
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			ResultSet rs = pstmt.executeQuery(sql);
			if(!rs.next()){
%>
		<script type="text/javascript">
			location.replace("index.jsp?left=Device&content=AllDevice");
		</script>
<%
			}else{
%>
<script type="text/javascript">
$(".Loading").css("display","block");
var cardid = 0;
var companyid = 0;
function previewImage(targetObj, View_area) {
	var preview = document.getElementById(View_area); //div id
	var ua = window.navigator.userAgent;
	var ImagePrev = document.getElementById("prev_"+View_area);
	if(ImagePrev != null){
		preview.removeChild(ImagePrev);	
	}
	
	
	
	
	
	if (ua.indexOf("MSIE") > -1) {
		 try {
             var src = ""; // get file full path 
             
             if (targetObj.value.indexOf("\\fakepath\\") < 0) {
          	   src = targetObj.value;
             } else {
          	  
             }
             
             var ie_preview_error = document
                     .getElementById("ie_preview_error_" + View_area);

             if (ie_preview_error) {
                 preview.removeChild(ie_preview_error); 
             }
             var img = document.getElementById(View_area); 
             img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "', sizingMethod=scale)"; 
         } catch (e) {
      	  
             if (!document.getElementById("ie_preview_error_" + View_area)) {
                 var info = document.createElement("<p>");
                 info.id = "ie_preview_error_" + previewId;
                 info.innerHTML = "a";
                 preview.insertBefore(info, null);
             }
         }
	} else {
		var files = targetObj.files;
		for ( var i = 0; i < files.length; i++) {
			var file = files[i];
			var imageType = /image.*/; 
			if (!file.type.match(imageType))
				continue;
			var prevImg = document.getElementById("prev_" + View_area); //���� �̸����Ⱑ �ִٸ� ����
			if (prevImg) {
				preview.removeChild(prevImg);
			}
			var img = document.createElement("img"); 
			img.id = "prev_" + View_area;
			img.classList.add("obj");
			img.file = file;
			img.style.width = '180px'; 
			img.style.height = '180px';
			preview.appendChild(img);
			if (window.FileReader) { // FireFox, Chrome, Opera Ȯ��.
				var reader = new FileReader();
				reader.onloadend = (function(aImg) {
					return function(e) {
						aImg.src = e.target.result;
					};
				})(img);
				reader.readAsDataURL(file);
			} else { // safari is not supported FileReader
				//alert('not supported FileReader');
				if (!document.getElementById("sfr_preview_error_"
						+ View_area)) {
					var info = document.createElement("p");
					info.id = "sfr_preview_error_" + View_area;
					info.innerHTML = "not supported FileReader";
					preview.insertBefore(info, null);
				}
			}
		}
	}
}


var change = 0;
function allA_GroupInfoCheck() {
	//var check = document.DeviceInfomation.check; 
	var check = document.getElementsByName("AG_check");
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


function DeviceInfoSubmit(){
	var dev = document.getElementById("DeviceInfomation");
	
	if(dev.controllerName.value == "")
    	alertify.alert("Please input 'Device Name'");
	else if(dev.idm.value == "")
    	alertify.alert("Please input 'ID'");
	else if(dev.address.value == "")
    	alertify.alert("Please input 'Address'");
	else if(dev.port.value == "")
    	alertify.alert("Please input 'Port Number'");
	else if(dev.Password.value == "")
    	alertify.alert("Please input 'Password'");
	else if(dev.uniqueid.value == "")
    	alertify.alert("Please input 'UniqueID'");
	else if(dev.serverport.value == "")
    	alertify.alert("Please input 'Server Port'");
	else
		document.getElementById("DeviceInfomation").submit();
}


function RedundancyEmployee(num,userid){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/RedEmp.jsp",   
	    data: "num="+num + "&userid="+userid,
	    success:function(args){
	    	if(args > 0){

	    		alertify.alert("<%=lanFunc.language(lan, 114)%>");
	    		companyid = 0;
	    	}else{
	    		alertify.alert("<%=lanFunc.language(lan, 115)%>");
	    		companyid = 1;
	    	}
	    },   
	    error:function(e){  
	    	alertify.alert(e.responseText);  
	    }  
	}); 
}


function RedundancyCard(num,userid){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/RedCard.jsp",   
	    data: "num="+num + "&userid="+userid,
	    success:function(args){
	    	if(args > 0){
	    		alertify.alert("<%=lanFunc.language(lan, 116)%>");
	    		cardid = 0;
	    	}else{
	    		alertify.alert("<%=lanFunc.language(lan, 117)%>");
	    		cardid = 1;
	    	}
	    },   
	    error:function(e){  
	    	alertify.alert(e.responseText);  
	    }  
	}); 
}

<%-- 
function DeviceDelete(){
	$(".Loading").css("display","block");
	var del = alertify.confirm("<%=lanFunc.language(lan, 103)%>");
	if(del){
		deviceDelete.submit();
	}else{}
} 
 --%>

$( ".tab2>li>a" ).click(function() {
    $(this).parent().addClass("on").siblings().removeClass("on");
    return false;
});

function displayInfo(z){
	for(var i=1;i<11;i++){
		if(i==z){
			document.getElementById("tab0"+i).parentNode.className = "on";
			document.getElementById("tab"+i).style.display = "block";		
		}else{
			document.getElementById("tab0"+i).parentNode.className = "";
			document.getElementById("tab"+i).style.display = "none";
		}
	}
}



function searchEventDevice(){
	var eventLog = document.getElementById("DeviceEventLog");
	eventLog.start.value = document.getElementById("startDate").value;
	eventLog.end.value = document.getElementById("endDate").value;
	eventLog.submit();
}

function accessList(v){
	if(v!=0){
		$(".Loading").css("display","block");
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/AccessGroupList.jsp",   
		    data: "access=" + v,
		    success:function(args){   
		    	$("#option" + v).attr('disabled', true);
		    	$('#access_group').val($('#access_group').val() + v);
		    	$('#access_group_table > tbody:last-child').append(args);
		    	$(".Loading").css("display","none");   
		    },   
		    error:function(e){  
		    	alertify.alert(e.responseText);  
		    }  
		}); 
	}else{
		
	}
}

function AccessAdd(DeviceID){
    $('.access_class').each(function(){   
    		var access = $(this).val();
    		var device_id = parseInt(DeviceID,10);
    		$(".Loading").css("display","block");
    		$.ajax({      
    		    type:"post",  
    		    url:"/TrustWinPro/action/ajax/AddAccessDevice.jsp",   
    		    data: "access=" + access + "&id=" + device_id, 
    		    success:function(args){   
    		    	//$("#tr" + access).remove();
    		    	$(".Loading").css("display","none");   
    		    },   
    		    error:function(e){  
    		    	alertify.alert(e.responseText);  
    		    }  
    		});
    		
    });;

}


function AccessDelete(deviceID){
	$('.access_class').each(function(){
    	if($(this).prop('checked'))
    	{	
    		var access = $(this).val();
    		var device_id = parseInt(deviceID,10);
    		$(".Loading").css("display","block");
    		$.ajax({      
    		    type:"post",  
    		    url:"/TrustWinPro/action/ajax/DelAccessDevice.jsp",   
    		    data: "access=" + access + "&id=" + device_id, 
    		    success:function(args){   
    		    	$("#tr" + access).remove();
    		    	$(".Loading").css("display","none");   
    		    },   
    		    error:function(e){  
    		    	alertify.alert(e.responseText);  
    		    }  
    		}); 
    	}
    	
    });
}

</script>

<%
	String realFolder = "";
	ServletContext scontext = getServletContext();
	realFolder = request.getContextPath() + "/upload/image/device/";
	realFolder = realFolder + rs.getString(8);
%>
<div id="DeviceInfo">
	<div class="basic">
		<form action="/TrustWinPro/action/page/DeviceUpdate.jsp" name="DeviceInfomation" id="DeviceInfomation" method="post"  enctype="multipart/form-data" >
			<input type="hidden" name="id" value="<%=LangUtil.Empty(LangUtil.Empty(rs.getString(2))) %>">
			<section class = "sectionji">
				<ul class = "ulji">
				</ul>
				<div class="picture">
							<div id='View_area' style='color: black; border: 0px solid black; dispaly: inline;float:left;'>
<%-- <%
	if(rs.getString(8)!=null){
%> --%>
									<img src="<%=realFolder %>" alt="" style="width:180px;height:180px;" id="prev_View_area" />

								<div>
									<input type="file" name="saveFile" id="saveFile"  style="filter:alpha(opacity:0);z-index:2;width:30;opacity:0;position: absolute;left:0px;height:30px;" onchange="previewImage(this,'View_area');" value="">
									<img src="/TrustWinPro/action/image/interface/search.png"  border='0' >
								</div>
							</div>				
				</div>
				<div class="Info">
				
					<div class="box1">
					
						<p><div class = "headerji">
						<span style="color:red">*</span> <%=lanFunc.language(lan, 1)%> : 
						</div>
						<input type="text" class = "inputt" name="controllerName" value="<%=LangUtil.Empty(rs.getString(1)) %>" >
					
					
						<p><div class = "headerji">
						<span style="color:red">*</span> <%=lanFunc.language(lan, 2)%> : 
						</div>
						<input type="text" class = "inputt" name="idm" value="<%=LangUtil.Empty(rs.getString(2)) %>" >
					
					
						<p><div class="headerji"><span style="color:red">*</span> <%=lanFunc.language(lan, 3)%> : </div>
						<input type="text" class = "inputt" name="address" value="<%=LangUtil.Empty(rs.getString(3))%>">
					
					</div>
					
					<div class="box2">
					
						<p><div class="headerji"><span style="color:red">*</span> <%=lanFunc.language(lan, 4)%> : </div>
						<input type="text" class = "inputt" name="port" value="<%=LangUtil.Empty(rs.getString(4)) %>">
					
					
						<p><div class="headerji"><span style="color:red">*</span> <%=lanFunc.language(lan, 5)%> : </div>
						<input type="text" name="Password" class = "inputt" value="<%=LangUtil.Empty(rs.getString(5)) %>" >
					
					
						<p><div class="headerji"><span style="color:red">*</span> <%=lanFunc.language(lan, 6)%> : </div>
						<input type="text" name="uniqueid" class = "inputt" value="<%=LangUtil.Empty(rs.getString(6)) %>" >
					
				
						<p><div class="headerji"><span style="color:red">*</span> <%=lanFunc.language(lan, 7)%> : </div>
						<input type="text" name="serverport" class = "inputt" value="<%=LangUtil.Empty(rs.getString(7)) %>" >
					
					<div class="block" style="float:right; margin-right:6rem;">
						<p><div><span style="color:red">required *</span></div>
					</div>
				</div>
				</div>
				
			</section>
			
			
				<ul class="tab2" style="margin-bottom:0px">
					<li class="on">
						<a href="#a" onclick="displayInfo(1)" class="here" id="tab01"><%=lanFunc.language(lan, 137)%></a>
					</li>
					<li >
						<a href="#a" onclick="displayInfo(2)" id="tab02"><%=lanFunc.language(lan, 8)%></a>
					</li>
					<li >
						<a href="#a" onclick="displayInfo(3)" id="tab03"><%=lanFunc.language(lan, 9)%></a>
					</li>
					<li >
						<a href="#a" onclick="displayInfo(4)" id="tab04" ><%=lanFunc.language(lan, 10)%></a>
					</li>
					<li >
						<a href="#a" onclick="displayInfo(5)" id="tab05" ><%=lanFunc.language(lan, 11)%></a>
					</li>
					<li >
						<a href="#a" onclick="displayInfo(6)" id="tab06" ><%=lanFunc.language(lan, 12)%></a>
					</li>
					<li >
						<a href="#a" onclick="displayInfo(7)" id="tab07" ><%=lanFunc.language(lan, 13)%></a>
					</li>
					<li >
						<a href="#a" onclick="displayInfo(8)" id="tab08" ><%=lanFunc.language(lan, 36)%></a>
					</li>
					<li >
						<a href="#a" onclick="displayInfo(9)" id="tab09" ><%=lanFunc.language(lan, 37)%></a>
					</li>
					<li >
						<a href="#a" onclick="displayInfo(10);EnrollUserList('S,D,U,0,0,<%=UID%>,E','<%=UID%>');" id="tab010" ><%=lanFunc.language(lan, 190)%></a>
					</li>
				</ul>
			<div class="Basic" id="tab1" style="display:block">
				<div class="InfoBox1">
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 138)%></div>

						<div class="main">
							<select name="DoorRelay" class="mainselect">
								<option value = "NULL" >--- Select Option ---</option>
								<!-- Relay 1 : 1  / Relay 2 : 2 -->
								<option value = "1" <%="1".equals(rs.getString(9)) ? "selected" : "" %>>Relay 1</option>
								<option value = "2" <%="2".equals(rs.getString(9)) ? "selected" : "" %>>Relay 2</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 139)%></div>
						<div class="main">
							<select name="DoorMode" class="mainselect">
								<option value = "NULL" >--- Select Option ---</option>
								<!-- [ANY MODE] : 0  / [FINGER] : 1 / [CD]or[FP] : 3 ... -->
								<option value = "0" <%="0".equals(rs.getString(10)) ? "selected" : "" %>>[ANY MODE]</option>
								<option value = "1" <%="1".equals(rs.getString(10)) ? "selected" : "" %>>[FINGER]</option>
								<option value = "2" <%="2".equals(rs.getString(10)) ? "selected" : "" %>>[CD] or [FP]</option>
								<option value = "3" <%="3".equals(rs.getString(10)) ? "selected" : "" %>>[ID&FP] or [CD]</option>
								<option value = "4" <%="4".equals(rs.getString(10)) ? "selected" : "" %>>[ID&FP] or [ID&CD]</option>
								<option value = "5" <%="5".equals(rs.getString(10)) ? "selected" : "" %>>[ID&FP] or [CD&FP]</option>
								<option value = "6" <%="6".equals(rs.getString(10)) ? "selected" : "" %>>[OPEN]</option>
								<option value = "7" <%="7".equals(rs.getString(10)) ? "selected" : "" %>>[CLOSE]</option>
								<option value = "8" <%="8".equals(rs.getString(10)) ? "selected" : "" %>>[CD]</option>
								<option value = "9" <%="9".equals(rs.getString(10)) ? "selected" : "" %>>[ID] or [FP]</option>
								<option value = "10" <%="10".equals(rs.getString(10)) ? "selected" : "" %>>[ID] or [CD]</option>
								<option value = "11" <%="11".equals(rs.getString(10)) ? "selected" : "" %>>[ID&CD]</option>
								<option value = "12" <%="12".equals(rs.getString(10)) ? "selected" : "" %>>[CD&FP]</option>
								<option value = "13" <%="13".equals(rs.getString(10)) ? "selected" : "" %>>[ID&FP]</option>
								<option value = "14" <%="14".equals(rs.getString(10)) ? "selected" : "" %>>[ID&CD&FP]</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 140)%></div>
						<div class="main">
							<select name="DoorTime" class="mainselect">
								<option value = "999" >--- Select Option ---</option>
<%
	for(int i=1;i<100;i++){
%>
								<option value = "<%=i%>" <%=i == rs.getInt(11) ? "selected" : "" %>><%=i%> Sec</option>
<%
	}
%>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 141)%></div>
						<div class="main">
							<select name="DoorAlarm" class="mainselect">
								<option value = "999" >--- Select Option ---</option>
<%
	for(int i=0;i<100;i++){
%>
								<option value = "<%=i%>" <%=i == rs.getInt(12) ? "selected" : "" %>><%=i%> Sec</option>
<%
	}
%>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 142)%></div>
						<div class="main">
							<select name="CdType" class="mainselect">
								<option value = "NULL" >--- Select Option ---</option>
								<!-- 26bit Wiegand : 1  / 34bit Wiegand : 2  / 35bit Wiegand : 3 / 37bit Wiegand : 4 -->
								<option value = "1" <%="1".equals(rs.getString(13)) ? "selected" : "" %>>26bit Wiegand</option>
								<option value = "2" <%="2".equals(rs.getString(13)) ? "selected" : "" %>>34bit Wiegand</option>
								<option value = "3" <%="3".equals(rs.getString(13)) ? "selected" : "" %>>35bit Wiegand</option>
								<option value = "4" <%="4".equals(rs.getString(13)) ? "selected" : "" %>>37bit Wiegand</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 143) %></div>
						<div class="main">
							<select name="ReAccess" class="mainselect">
								<option value = "999" >--- Select Option ---</option>
<%
	for(int i=0;i<10;i++){
%>
								<option value = "<%=i%>" <%=i == rs.getInt(14) ? "selected" : "" %>><%=i%></option>
<%
	}
%>
								<option value = "10" <%="10".equals(rs.getString(14)) ? "selected" : "" %>>None</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 144) %></div>
						<div class="main">
							<select name="Cd2Fun" class="mainselect">
								<option value = "NULL" >--- Select Option ---</option>
<%
	for(int i=1;i<5;i++){
		for(int j=0;j<10;j++){
			if(i==1){
%>
				<option value = "<%=j%>" <%=(String.valueOf(j)).equals(rs.getString(15)) ? "selected" : "" %>>F<%=i%>-<%=j%></option>
<%
			}else{
%>
				<option value = "<%=i-1%><%=j%>" <%=(String.valueOf(i-1) + String.valueOf(j)).equals(rs.getString(15)) ? "selected" : "" %>>F<%=i%>-<%=j%></option>
				<%-- <option value = "F<%=i%>-<%=j%>" <%=("F" + i + "-" + j).equals(rs.getString(15)) ? "selected" : "" %>>F<%=i%>-<%=j%></option> --%>
<%
			}
		}
	}
%>
				<option value = "40" <%=("40").equals(rs.getString(15)) ? "selected" : "" %>>None</option>
				
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 145) %></div>
						<div class="main">
							<select name="AlmRelayFun" class="mainselect">
								<option value = "NULL" >--- Select Option ---</option>
<%
	for(int i=1;i<5;i++){
		for(int j=0;j<10;j++){
			if(i==1){
%>
				<option value = "<%=j%>" <%=(String.valueOf(j)).equals(rs.getString(16)) ? "selected" : "" %>>F<%=i%>-<%=j%></option>
<%
			}else{
%>
				<option value = "<%=i-1%><%=j%>" <%=(String.valueOf(i-1) + String.valueOf(j)).equals(rs.getString(16)) ? "selected" : "" %>>F<%=i%>-<%=j%></option>
<%
			}
		}
	}
%>
				<option value = "40" <%=("40").equals(rs.getString(16)) ? "selected" : "" %>>None</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 146) %></div>
						<div class="main">
							<select name="AlmBuzzFun" class="mainselect">
								<option value = "NULL" >--- Select Option ---</option>
<%
	for(int i=1;i<5;i++){
		for(int j=0;j<10;j++){
			if(i==1){
%>
								<option value = "<%=j%>" <%=(String.valueOf(j)).equals(rs.getString(17)) ? "selected" : "" %>>F<%=i%>-<%=j%></option>
<%
			}else{
%>
								<option value = "<%=i-1%><%=j%>" <%=(String.valueOf(i-1) + String.valueOf(j)).equals(rs.getString(17)) ? "selected" : "" %>>F<%=i%>-<%=j%></option>
<%
			}
		}
	}
%>
								<option value = "40" <%=("40").equals(rs.getString(17)) ? "selected" : "" %>>None</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 147) %>3</div>
						<div class="main">
							<select name="AntiPass" class="mainselect">
								<option value = "NULL" >--- Select Option ---</option>
								<!--  NO : 0 / YES : 1 -->
								<option value = "0" <%="0".equals(rs.getString(18)) ? "selected" : "" %>>NO</option>
								<option value = "1" <%="1".equals(rs.getString(18)) ? "selected" : "" %>>YES</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 148) %></div>
						<div class="main">
							<select name="Fire" class="mainselect">
								<option value = "NULL" >--- Select Option ---</option>
								<!--  Intrusion : 0 / Fire : 1 -->
								<option value = "0" <%="0".equals(rs.getString(19)) ? "selected" : "" %>>Intrusion</option>
								<option value = "1" <%="1".equals(rs.getString(19)) ? "selected" : "" %>>Fire</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 149) %></div>
						<div class="main">
							<select name="IdSecret" class="mainselect">
								<option value = "NULL" >--- Select Option ---</option>
								<!--  Off : 0 / On : 1 -->
								<option value = "0" <%="0".equals(rs.getString(20)) ? "selected" : "" %>>Off</option>
								<option value = "1" <%="1".equals(rs.getString(20)) ? "selected" : "" %>>On</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 150)%></div>
						<div class="main">
							<select name="Limit" class="mainselect">
								<!--  None : 0 / On : 1 -->
								<option value = "0" <%="0".equals(rs.getString(21)) ? "selected" : "" %>>None</option>
<%
	for(int i=1;i<601;i++){
%>
								<option value = "<%=i%>" <%=Integer.toString(i).equals(rs.getString(21)) ? "selected" : "" %>><%=i%> Min</option>
<%
	}
%>
								
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 151)%></div>
						<div class="main">
							<select name="VoiceOut" class="mainselect">
								<option value = "NULL" >--- Select Option ---</option>
								<!--  Off : 0 / On : 1 -->
								<option value = "0" <%="0".equals(rs.getString(22)) ? "selected" : "" %>>Off</option>
								<option value = "1" <%="1".equals(rs.getString(22)) ? "selected" : "" %>>On</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 152)%></div>
						<div class="main"> 
							<select name="MachineID" class="mainselect">
								<option value = "999" >--- Select Option ---</option>
<%
	for(int i=1;i<501;i++){
%>
								<option value = "<%=i%>" <%=i == rs.getInt(23) ? "selected" : "" %>><%=i%></option>
<%
	}
%>
								
							</select>
						</div>
					</div>
				</div>
				<div class="InfoBox2">
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 153)%></div>
						<div class="main">
							<select name="Baudrate" class="mainselect">
								<option value = "NULL" >--- Select Option ---</option>
								<!--  9600 bps : 0 / 19200 bps : 1 ... -->
								<option value = "0" <%="0".equals(rs.getString(24)) ? "selected" : "" %>>9600 bps</option>
								<option value = "1" <%="1".equals(rs.getString(24)) ? "selected" : "" %>>19200 bps</option>
								<option value = "2" <%="2".equals(rs.getString(24)) ? "selected" : "" %>>38400 bps</option>
								<option value = "3" <%="3".equals(rs.getString(24)) ? "selected" : "" %>>57600 bps</option>
								<option value = "4" <%="4".equals(rs.getString(24)) ? "selected" : "" %>>115200 bps</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 154)%></div>
						<div class="main">
							<input type="text" name="DeviceTime" value="<%=LangUtil.Empty(rs.getString(25)) %>" >
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 155) %></div>
						<div class="main"><input type="text" name="UserCount" value="<%=LangUtil.Empty(rs.getString(26)) %>" ></div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 156) %></div>
						<div class="main"><input type="text" name="ManagerCount"  value="<%=LangUtil.Empty(rs.getString(27)) %>" ></div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 157) %></div>
						<div class="main"><input type="text" name="FpCount" value="<%=LangUtil.Empty(rs.getString(28)) %>" ></div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 158) %></div>
						<div class="main"><input type="text" name="CardCount" value="<%=LangUtil.Empty(rs.getString(29)) %>" ></div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 159) %></div>
						<div class="main"><input type="text" name="SLogTotal" value="<%=LangUtil.Empty(rs.getString(30)) %>" ></div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 160) %></div>
						<div class="main"><input type="text" name="SLogRead" value="<%=LangUtil.Empty(rs.getString(31)) %>" ></div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 161) %></div>
						<div class="main"><input type="text" name="GLogTotal" value="<%=LangUtil.Empty(rs.getString(32)) %>" ></div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 162) %></div>
						<div class="main"><input type="text" name="GLogRead" value="<%=LangUtil.Empty(rs.getString(33)) %>" ></div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 163) %></div>
						<div class="main"><input type="text" name="CurDoorMode" value="<%=LangUtil.Empty(rs.getString(34)) %>" ></div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 164) %></div>
						<div class="main">
							<select name="DoorStatus" class="mainselect">
								<option value = "0" >--- Select Option ---</option>
								<option value = "Close" <%="Close".equals(rs.getString(35)) ? "selected" : "" %>>Close</option>
								<option value = "Open" <%="Open".equals(rs.getString(35)) ? "selected" : "" %>>Open</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 165) %></div>
						<div class="main"><input type="text" name="Manager PC Information" value="<%=LangUtil.Empty(rs.getString(36)) %>" ></div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 166) %></div>
						<div class="main">
							<select name="BGI" class="mainselect">
								<option value = "NULL" >--- Select Option ---</option>
								<!-- Image-1 : 0 / Image-2 : 1 / Image-Custome : 2 -->
								<option value = "0" <%="0".equals(rs.getString(37)) ? "selected" : "" %>>Image-1</option>
								<option value = "1" <%="1".equals(rs.getString(37)) ? "selected" : "" %>>Image-2</option>
								<option value = "2" <%="2".equals(rs.getString(37)) ? "selected" : "" %>>Image-Custom</option>
							</select>
						</div>
					</div>
				</div>
				<div class="GetSet" style="display:none;">
					<a href="#UserInfo" onclick="">get</a>
					<a href="#UserInfo" onclick="">set</a>
				</div>
				<div class="InfoButtom bt_device" style="width:300px; float:left; margin-top:610px; position:absolute; left:0px;">
					<!-- <a style="margin-right: 0px;padding-top:4px;padding-right:8px;" class="button"><span><img src="/TrustWinPro/action/image/interface/device_com2.png" style="height:28px; width:28px;border-radius:7px;"></span></a> -->
					<a href="#" title="Send" onclick="Enroll('S,D,E,2,1,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%-- <%=lanFunc.language(lan, 183)%> --%>Send</a>
					<a href="#" style="display:none"  title="Delete" onclick="Delete('S,D,D,2,1,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%=lanFunc.language(lan, 88)%></a>
				</div>
			</div>
			
<%
	Sunshine sun = new Sunshine();
	sun = devFunc.SelSunshine(rs.getInt(2));
%>
			<div class="Sunlight" id="tab2" style="display:none">
				<div class="InfoBox">
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 14)%></div>
						<div class="main">
							<input type="text" name="StartTime" readonly="readOnly" value="<%=sun.getSYear()%>-<%=sun.getSMonth()<10?"0"+sun.getSMonth():sun.getSMonth() %>-<%=sun.getSDay()<10?"0"+sun.getSDay():sun.getSDay() %>" size="40um" onclick="fnPopUpCalendar(StartTime,StartTime,'yyyy-mm-dd')">
							
						<select name="SHour" class="hourselect">
<%
	for(int i=1;i<25;i++){
%>							
							<option value = "<%=i%>" <%=sun.getSHour() == i ? "selected" : "" %>><%=i%></option>
<%
	}
%>
						</select>
						<%=lanFunc.language(lan, 15)%>&nbsp;
						<select name="SMinute" class="minuteselect">
<%
	for(int i=0;i<60;i++){
%>							
							<option value = "<%=i%>" <%=sun.getSMinute() == i ? "selected" : "" %>><%=i%></option>
<%
	}
%>
						</select>
						<%=lanFunc.language(lan, 16)%>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 17)%></div>
						<div class="main">
							<input type="text" name="ChangeSTime" readonly="readOnly" value="<%=sun.getSCYear()%>-<%=sun.getSCMonth()<10?"0"+sun.getSCMonth():sun.getSCMonth() %>-<%=sun.getSCDay()<10?"0"+sun.getSCDay():sun.getSCDay() %>" size="40um" onclick="fnPopUpCalendar(ChangeSTime,ChangeSTime,'yyyy-mm-dd')">
							
						<select name="SCHour" class="mainselect">
<%
	for(int i=1;i<25;i++){
%>							
							<option value = "<%=i%>" <%=sun.getSCHour() == i ? "selected" : "" %>><%=i%></option>
<%
	}
%>
						</select>
						<%=lanFunc.language(lan, 15)%>&nbsp;
						<select name="SCMinute" class="mainselect">
<%
	for(int i=0;i<60;i++){
%>							
							<option value = "<%=i%>" <%=sun.getSCMinute() == i ? "selected" : "" %>><%=i%></option>
<%
	}
%>
						</select>
						<%=lanFunc.language(lan, 16)%>&nbsp;
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 18)%></div>
						<div class="main">
							<input type="text" name="CombackTime" readonly="readOnly" value="<%=sun.getRYear()%>-<%=sun.getRMonth()<10?"0"+sun.getRMonth():sun.getRMonth() %>-<%=sun.getRDay()<10?"0"+sun.getRDay():sun.getRDay() %>" size="40um" onclick="fnPopUpCalendar(CombackTime,CombackTime,'yyyy-mm-dd')">
							
						<select name="RHour" class="mainselect">
<%
	for(int i=1;i<25;i++){
%>							
							<option value = "<%=i%>" <%=sun.getRHour() == i ? "selected" : "" %>><%=i%></option>
<%
	}
%>
						</select>
						<%=lanFunc.language(lan, 15)%>&nbsp;
						<select name="RMinute" class="mainselect">
<%
	for(int i=0;i<60;i++){
%>							
							<option value = "<%=i%>" <%=sun.getRMinute() == i ? "selected" : "" %>><%=i%></option>
<%
	}
%>
						</select>
						<%=lanFunc.language(lan, 16)%>&nbsp;
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 17)%></div>
						<div class="main">
							<input type="text" name="ChangeETime" readonly="readOnly" value="<%=sun.getRCYear()%>-<%=sun.getRCMonth()<10?"0"+sun.getRCMonth():sun.getRCMonth() %>-<%=sun.getRCDay()<10?"0"+sun.getRCDay():sun.getRCDay() %>" size="40um" onclick="fnPopUpCalendar(ChangeETime,ChangeETime,'yyyy-mm-dd')">
							
						<select name="RCHour" class="mainselect">
<%
	for(int i=1;i<25;i++){
%>							
							<option value = "<%=i%>" <%=sun.getRCHour() == i ? "selected" : "" %>><%=i%></option>
<%
	}
%>
						</select>
						<%=lanFunc.language(lan, 15)%>&nbsp;
						<select name="RCMinute" class="mainselect">
<%
	for(int i=0;i<60;i++){
%>							
							<option value = "<%=i%>" <%=sun.getRCMinute() == i ? "selected" : "" %>><%=i%></option>
<%
	}
%>
						</select>
						<%=lanFunc.language(lan, 16)%>&nbsp;
						</div>
					</div>
				</div>
				<div class="InfoButtom bt_device" style="width:300px; float:left; margin-top:150px;position:absolute;">
					<!-- <a style="margin-right: 0px;padding-top:4px;padding-right:8px;" class="button"><span> <img src="/TrustWinPro/action/image/interface/device_com2.png" style="height:28px; width:28px;border-radius:7px;"></span></a> -->
					<a href="#" title="Send" onclick="Enroll('S,D,E,2,2,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%-- <%=lanFunc.language(lan, 183)%> --%>Send</a>
					<a href="#" style="display:none;" title="Delete" onclick="Delete('S,D,D,2,2,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%=lanFunc.language(lan, 88)%></a>
				</div>
			</div>
<%
	ManageMode mm = new ManageMode();
	mm = devFunc.SelManageMode(rs.getInt(2));
%>
			<div class="Operatelight" id="tab3" style="display:none">
				<div class="InfoBox">
					<div class="block">
						<table>
							<colgroup>
								<col width="30%">
								<col width="20%">
								<col width="20%">
								<col width="30%">
							</colgroup>
							<tr>
								<th><%=lanFunc.language(lan, 19)%></th>
								<th><%=lanFunc.language(lan, 14)%></th>
								<th><%=lanFunc.language(lan, 20)%></th>
								<th><%=lanFunc.language(lan, 9)%></th>
							</tr>
<%
			for(int k=1;k<11;k++){
				int week = 0;
				if(k==1){
					week = mm.getWeek1();
				}else if(k==2){
					week = mm.getWeek2();
				}else if(k==3){
					week = mm.getWeek3();
				}else if(k==4){
					week = mm.getWeek4();
				}else if(k==5){
					week = mm.getWeek5();
				}else if(k==6){
					week = mm.getWeek6();
				}else if(k==7){
					week = mm.getWeek7();
				}else if(k==8){
					week = mm.getWeek8();
				}else if(k==9){
					week = mm.getWeek9();
				}else if(k==10){
					week = mm.getWeek10();
				}
%>
							<tr>
								<td>
									<select name="WeekO<%=k%>" class="hourselect">
										<option value = "0" <%=week == 0 ? "selected" : "" %>>None</option>
										<option value = "255" <%=week == 255 ? "selected" : "" %>>All Day</option>
										<option value = "1" <%=week == 1 ? "selected" : "" %>>Holiday</option>
										<option value = "2" <%=week == 2 ? "selected" : "" %>>Sunday</option>
										<option value = "3" <%=week == 3 ? "selected" : "" %>>Holiday+Sunday</option>
										<option value = "4" <%=week == 4 ? "selected" : "" %>>Monday</option>
										<option value = "5" <%=week == 5 ? "selected" : "" %>>Tuesday</option>
										<option value = "6" <%=week == 6 ? "selected" : "" %>>Wednesday</option>
										<option value = "7" <%=week == 7 ? "selected" : "" %>>Thursday</option>
										<option value = "8" <%=week == 8 ? "selected" : "" %>>Friday</option>
										<option value = "9" <%=week == 9 ? "selected" : "" %>>Saturday</option>
										<option value = "10" <%=week == 10 ? "selected" : "" %>>Monday-Friday</option>
										<option value = "11" <%=week == 11 ? "selected" : "" %>>Monday-Saturday</option>
									</select>
								</td>
								<td>
									<select name="SHourO<%=k%>" class="hourselect">
<%
				int shour = 0;
				if(k==1){
					shour = mm.getSHour1();
				}else if(k==2){
					shour = mm.getSHour2();
				}else if(k==3){
					shour = mm.getSHour3();
				}else if(k==4){
					shour = mm.getSHour4();
				}else if(k==5){
					shour = mm.getSHour5();
				}else if(k==6){
					shour = mm.getSHour6();
				}else if(k==7){
					shour = mm.getSHour7();
				}else if(k==8){
					shour = mm.getSHour8();
				}else if(k==9){
					shour = mm.getSHour9();
				}else if(k==10){
					shour = mm.getSHour10();
				}
				
				for(int i=1;i<25;i++){
%>							
										<option value = "<%=i%>" <%=shour == i ? "selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
									<select name="SMinuteO<%=k%>" class="hourselect">
<%
				int SMinute = 0;
				if(k==1){
					SMinute = mm.getSMinute1();
				}else if(k==2){
					SMinute = mm.getSMinute2();
				}else if(k==3){
					SMinute = mm.getSMinute3();
				}else if(k==4){
					SMinute = mm.getSMinute4();
				}else if(k==5){
					SMinute = mm.getSMinute5();
				}else if(k==6){
					SMinute = mm.getSMinute6();
				}else if(k==7){
					SMinute = mm.getSMinute7();
				}else if(k==8){
					SMinute = mm.getSMinute8();
				}else if(k==9){
					SMinute = mm.getSMinute9();
				}else if(k==10){
					SMinute = mm.getSMinute10();
				}
				
				for(int i=0;i<60;i++){
%>							
										<option value = "<%=i%>" <%=SMinute == i ? "selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
								</td>
								<td>
									<select name="EHourO<%=k%>" class="hourselect">
<%
				int EHour = 0;
				if(k==1){
					EHour = mm.getEHour1();
				}else if(k==2){
					EHour = mm.getEHour2();
				}else if(k==3){
					EHour = mm.getEHour3();
				}else if(k==4){
					EHour = mm.getEHour4();
				}else if(k==5){
					EHour = mm.getEHour5();
				}else if(k==6){
					EHour = mm.getEHour6();
				}else if(k==7){
					EHour = mm.getEHour7();
				}else if(k==8){
					EHour = mm.getEHour8();
				}else if(k==9){
					EHour = mm.getEHour9();
				}else if(k==10){
					EHour = mm.getEHour10();
				}
				
				for(int i=1;i<25;i++){
%>							
										<option value = "<%=i%>" <%=EHour == i ? "selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
									<select name="EMinuteO<%=k%>" class="hourselect">
<%
				int EMinute = 0;
				if(k==1){
					EMinute = mm.getEMinute1();
				}else if(k==2){
					EMinute = mm.getEMinute2();
				}else if(k==3){
					EMinute = mm.getEMinute3();
				}else if(k==4){
					EMinute = mm.getEMinute4();
				}else if(k==5){
					EMinute = mm.getEMinute5();
				}else if(k==6){
					EMinute = mm.getEMinute6();
				}else if(k==7){
					EMinute = mm.getEMinute7();
				}else if(k==8){
					EMinute = mm.getEMinute8();
				}else if(k==9){
					EMinute = mm.getEMinute9();
				}else if(k==10){
					EMinute = mm.getEMinute10();
				}
				for(int i=0;i<60;i++){
%>							
										<option value = "<%=i%>" <%=EMinute == i ? "selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
								</td>
								<td>
<%
				int Manage = 0;
				if(k==1){
					Manage = mm.getManage1();
				}else if(k==2){
					Manage = mm.getManage2();
				}else if(k==3){
					Manage = mm.getManage3();
				}else if(k==4){
					Manage = mm.getManage4();
				}else if(k==5){
					Manage = mm.getManage5();
				}else if(k==6){
					Manage = mm.getManage6();
				}else if(k==7){
					Manage = mm.getManage7();
				}else if(k==8){
					Manage = mm.getManage8();
				}else if(k==9){
					Manage = mm.getManage9();
				}else if(k==10){
					Manage = mm.getManage10();
				}
%>	
									<select name="OperateModeO<%=k%>" class="hourselect">
										<option value = "0" <%=Manage == 0 ? "Selected" : "" %> >[Any]</option>
										<option value = "1" <%=Manage == 1 ? "Selected" : "" %> >[Finger]</option>
										<option value = "2" <%=Manage == 2 ? "Selected" : "" %> >[CD or FP]</option>
										<option value = "3" <%=Manage == 3 ? "Selected" : "" %> >[ID&FP] or [CD]</option>
										<option value = "4" <%=Manage == 4 ? "Selected" : "" %> >[ID&FP] or [ID&CD]</option>
										<option value = "5" <%=Manage == 5 ? "Selected" : "" %> >[ID&FP] or [CD&FP]</option>
										<option value = "6" <%=Manage == 6 ? "Selected" : "" %> >[Open]</option>
										<option value = "7" <%=Manage == 7 ? "Selected" : "" %> >[Close]</option>
										<option value = "8" <%=Manage == 8 ? "Selected" : "" %> >[Card]</option>
										<option value = "9" <%=Manage == 9 ? "Selected" : "" %> >[ID or FP]</option>
										<option value = "10" <%=Manage == 10 ? "Selected" : "" %> >[ID or CD]</option>
										<option value = "11" <%=Manage == 11 ? "Selected" : "" %> >[ID&CD]</option>
										<option value = "12" <%=Manage == 12 ? "Selected" : "" %> >[CD&FP]</option>
										<option value = "13" <%=Manage == 13 ? "Selected" : "" %> >[ID&FP]</option>
										<option value = "14" <%=Manage == 14 ? "Selected" : "" %> >[ID&CD&FP]</option>
									</select>
								</td>
							</tr>
<%
			}
%>
						</table>
					</div>
				</div>
				<div class="InfoButtom bt_device" style="width:300px; float:left; margin-top:35px; margin-left:5px;position:absolute;">
					<!-- <a style="margin-right: 0px;padding-top:4px;padding-right:8px;" class="button"><span> <img src="/TrustWinPro/action/image/interface/device_com2.png" style="height:28px; width:28px;border-radius:7px;"></span></a> -->
					<a href="#" title="Send" onclick="Enroll('S,D,E,2,3,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%-- <%=lanFunc.language(lan, 183)%> --%>Send</a>
					<a href="#" style="display:none;" title="Delete" onclick="Delete('S,D,D,2,3,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%=lanFunc.language(lan, 88)%></a>
				</div>
			</div>
<%
	AlarmTime at = new AlarmTime();
	at = alFunc.SelAlarmTime(rs.getInt(2));
%>			
			<div class="Alarm" id="tab4" style="display:none">
				<div class="InfoBox">
					<div class="block">
						<table>
							<colgroup>
								<col width="20%">
								<col width="15%">
								<col width="15%">
								<col width="20%">
								<col width="15%">
								<col width="15%">
							</colgroup>
							<tr>
								<th><%=lanFunc.language(lan, 19)%></th>
								<th><%=lanFunc.language(lan, 14)%></th>
								<th><%=lanFunc.language(lan, 21)%></th>
								<th><%=lanFunc.language(lan, 19)%></th>
								<th><%=lanFunc.language(lan, 14)%></th>
								<th><%=lanFunc.language(lan, 21)%></th>
							</tr>
<%
			for(int k=1;k<11;k++){
				int weeka = 0;
				if(k==1){
					weeka = at.getWeek1();
				}else if(k==2){
					weeka = at.getWeek2();
				}else if(k==3){
					weeka = at.getWeek3();
				}else if(k==4){
					weeka = at.getWeek4();
				}else if(k==5){
					weeka = at.getWeek5();
				}else if(k==6){
					weeka = at.getWeek6();
				}else if(k==7){
					weeka = at.getWeek7();
				}else if(k==8){
					weeka = at.getWeek8();
				}else if(k==9){
					weeka = at.getWeek9();
				}else if(k==10){
					weeka = at.getWeek10();
				}
%>
							<tr>
								<td>
									<select name="WeekA1<%=k%>" class="hourselect">
										<option value = "0" <%=weeka==0?"Selected" : "" %>>None</option>
										<option value = "255" <%=weeka==255?"Selected" : "" %>>All Day</option>
										<option value = "1" <%=weeka==1?"Selected" : "" %>>Holiday</option>
										<option value = "2" <%=weeka==2?"Selected" : "" %>>Sunday</option>
										<option value = "3" <%=weeka==3?"Selected" : "" %>>Holiday+Sunday</option>
										<option value = "4" <%=weeka==4?"Selected" : "" %>>Monday</option>
										<option value = "5" <%=weeka==5?"Selected" : "" %>>Tuesday</option>
										<option value = "6" <%=weeka==6?"Selected" : "" %>>Wednesday</option>
										<option value = "7" <%=weeka==7?"Selected" : "" %>>Thursday</option>
										<option value = "8" <%=weeka==8?"Selected" : "" %>>Friday</option>
										<option value = "9" <%=weeka==9?"Selected" : "" %>>Saturday</option>
										<option value = "10" <%=weeka==10?"Selected" : "" %>>Monday-Friday</option>
										<option value = "11" <%=weeka==11?"Selected" : "" %>>Monday-Saturday</option>
									</select>
								</td>
								<td>
									<select name="SHourA1<%=k%>" class="hourselect">
<%
				int shour = 0;
				if(k==1){
					shour = at.getSHour1();
				}else if(k==2){
					shour = at.getSHour2();
				}else if(k==3){
					shour = at.getSHour3();
				}else if(k==4){
					shour = at.getSHour4();
				}else if(k==5){
					shour = at.getSHour5();
				}else if(k==6){
					shour = at.getSHour6();
				}else if(k==7){
					shour = at.getSHour7();
				}else if(k==8){
					shour = at.getSHour8();
				}else if(k==9){
					shour = at.getSHour9();
				}else if(k==10){
					shour = at.getSHour10();
				}
				for(int i=1;i<25;i++){
%>							
										<option value = "<%=i%>" <%=shour==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
									<select name="SMinuteA1<%=k%>" class="hourselect">
<%
				int sminute = 0;
				if(k==1){
					sminute = at.getSMinute1();
				}else if(k==2){
					sminute = at.getSMinute2();
				}else if(k==3){
					sminute = at.getSMinute3();
				}else if(k==4){
					sminute = at.getSMinute4();
				}else if(k==5){
					sminute = at.getSMinute5();
				}else if(k==6){
					sminute = at.getSMinute6();
				}else if(k==7){
					sminute = at.getSMinute7();
				}else if(k==8){
					sminute = at.getSMinute8();
				}else if(k==9){
					sminute = at.getSMinute9();
				}else if(k==10){
					sminute = at.getSMinute10();
				}
				for(int i=0;i<60;i++){
%>							
										<option value = "<%=i%>" <%=sminute==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
								</td>
								<td>
									<select name="TimeA1<%=k%>" class="hourselect">
<%
				int timea = 0;
				if(k==1){
					timea = at.getSec1();
				}else if(k==2){
					timea = at.getSec2();
				}else if(k==3){
					timea = at.getSec3();
				}else if(k==4){
					timea = at.getSec4();
				}else if(k==5){
					timea = at.getSec5();
				}else if(k==6){
					timea = at.getSec6();
				}else if(k==7){
					timea = at.getSec7();
				}else if(k==8){
					timea = at.getSec8();
				}else if(k==9){
					timea = at.getSec9();
				}else if(k==10){
					timea = at.getSec10();
				}
				
				for(int i=0;i<255;i++){
%>							
										<option value = "<%=i%>" <%=timea == i ? "selected":"" %>><%=i%></option>
<%
				}
%>
									</select>
								</td>
								<td>
<%
				int weeka2 = 0;
				if(k==1){
					weeka2 = at.getWeek11();
				}else if(k==2){
					weeka2 = at.getWeek12();
				}else if(k==3){
					weeka2 = at.getWeek13();
				}else if(k==4){
					weeka2 = at.getWeek14();
				}else if(k==5){
					weeka2 = at.getWeek15();
				}else if(k==6){
					weeka2 = at.getWeek16();
				}else if(k==7){
					weeka2 = at.getWeek17();
				}else if(k==8){
					weeka2 = at.getWeek18();
				}else if(k==9){
					weeka2 = at.getWeek19();
				}else if(k==10){
					weeka2 = at.getWeek20();
				}
%>
									<select name="WeekA2<%=k%>" class="hourselect">
										<option value = "0" <%=weeka2==0?"Selected" : "" %>>None</option>
										<option value = "255" <%=weeka2==255?"Selected" : "" %>>All Day</option>
										<option value = "1" <%=weeka2==1?"Selected" : "" %>>Holiday</option>
										<option value = "2" <%=weeka2==2?"Selected" : "" %>>Sunday</option>
										<option value = "3" <%=weeka2==3?"Selected" : "" %>>Holiday+Sunday</option>
										<option value = "4" <%=weeka2==4?"Selected" : "" %>>Monday</option>
										<option value = "5" <%=weeka2==5?"Selected" : "" %>>Tuesday</option>
										<option value = "6" <%=weeka2==6?"Selected" : "" %>>Wednesday</option>
										<option value = "7" <%=weeka2==7?"Selected" : "" %>>Thursday</option>
										<option value = "8" <%=weeka2==8?"Selected" : "" %>>Friday</option>
										<option value = "9" <%=weeka2==9?"Selected" : "" %>>Saturday</option>
										<option value = "10" <%=weeka2==10?"Selected" : "" %>>Monday-Friday</option>
										<option value = "11" <%=weeka2==11?"Selected" : "" %>>Monday-Saturday</option>
									</select>
								</td>
								<td>
									<select name="SHourA2<%=k%>" class="hourselect">
<%
				int shoura2 = 0;
				if(k==1){
					shoura2 = at.getSHour11();
				}else if(k==2){
					shoura2 = at.getSHour12();
				}else if(k==3){
					shoura2 = at.getSHour13();
				}else if(k==4){
					shoura2 = at.getSHour14();
				}else if(k==5){
					shoura2 = at.getSHour15();
				}else if(k==6){
					shoura2 = at.getSHour16();
				}else if(k==7){
					shoura2 = at.getSHour17();
				}else if(k==8){
					shoura2 = at.getSHour18();
				}else if(k==9){
					shoura2 = at.getSHour19();
				}else if(k==10){
					shoura2 = at.getSHour20();
				}
				
				for(int i=1;i<25;i++){
%>							
										<option value = "<%=i%>" <%=shoura2==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
									<select name="SMinuteA2<%=k%>" class="hourselect">
<%
				int sminutea2 = 0;
				if(k==1){
					sminutea2 = at.getSMinute11();
				}else if(k==2){
					sminutea2 = at.getSMinute12();
				}else if(k==3){
					sminutea2 = at.getSMinute13();
				}else if(k==4){
					sminutea2 = at.getSMinute14();
				}else if(k==5){
					sminutea2 = at.getSMinute15();
				}else if(k==6){
					sminutea2 = at.getSMinute16();
				}else if(k==7){
					sminutea2 = at.getSMinute17();
				}else if(k==8){
					sminutea2 = at.getSMinute18();
				}else if(k==9){
					sminutea2 = at.getSMinute19();
				}else if(k==10){
					sminutea2 = at.getSMinute20();
				}

				for(int i=0;i<60;i++){
%>							
										<option value = "<%=i%>"  <%=sminutea2==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
								</td>
								<td>
									<select name="TimeA2<%=k%>" class="hourselect">
<%
				int stimea2 = 0;
				if(k==1){
					stimea2 = at.getSec11();
				}else if(k==2){
					stimea2 = at.getSec12();
				}else if(k==3){
					stimea2 = at.getSec13();
				}else if(k==4){
					stimea2 = at.getSec14();
				}else if(k==5){
					stimea2 = at.getSec15();
				}else if(k==6){
					stimea2 = at.getSec16();
				}else if(k==7){
					stimea2 = at.getSec17();
				}else if(k==8){
					stimea2 = at.getSec18();
				}else if(k==9){
					stimea2 = at.getSec19();
				}else if(k==10){
					stimea2 = at.getSec20();
				}

				for(int i=0;i<255;i++){
%>							
										<option value = "<%=i%>" <%=stimea2==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
								</td>
							</tr>
<%
			}
%>
						</table>
					</div>
				</div>
				<div class="InfoButtom bt_device" style="width:300px; float:left; margin-top:35px; margin-left:5px;position:absolute;">
					<!-- <a style="margin-right: 0px;padding-top:4px;padding-right:8px;" class="button"><span> <img src="/TrustWinPro/action/image/interface/device_com2.png" style="height:28px; width:28px;border-radius:7px;"></span></a> -->
					<a href="#" title="Send" onclick="Enroll('S,D,E,2,4,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%-- <%=lanFunc.language(lan, 183)%> --%>Send</a>
					<a href="#" style="display:none;" title="Delete" onclick="Delete('S,D,D,2,4,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%=lanFunc.language(lan, 88)%></a>
				</div>
			</div>
<%
			AutoDoor ad = new AutoDoor();
			ad = autoDoor.SelAutoDoor(rs.getInt(2));
%>
			<div class="AutoDoor" id="tab5" style="display:none">
				<div class="InfoBox">
					<div class="block">
						<table>
							<colgroup>
								<col width="30%">
								<col width="20%">
								<col width="20%">
							</colgroup>
							<tr>
								<th><%=lanFunc.language(lan, 19)%></th>
								<th><%=lanFunc.language(lan, 14)%></th>
								<th><%=lanFunc.language(lan, 20)%></th>
							</tr>
<%
			for(int k=1;k<7;k++){
				int weekad = 0;
				if(k==1){
					weekad = ad.getWeek1();
				}else if(k==2){
					weekad = ad.getWeek2();
				}else if(k==3){
					weekad = ad.getWeek3();
				}else if(k==4){
					weekad = ad.getWeek4();
				}else if(k==5){
					weekad = ad.getWeek5();
				}else if(k==6){
					weekad = ad.getWeek6();
				}else if(k==7){
					weekad = ad.getWeek7();
				}else if(k==8){
					weekad = ad.getWeek8();
				}else if(k==9){
					weekad = ad.getWeek9();
				}else if(k==10){
					weekad = ad.getWeek10();
				}
				
%>
							<tr>
								<td>
									<select name="WeekAD<%=k%>" class="hourselect">
										<option value = "0" <%=weekad==0?"Selected" : "" %>>None</option>
										<option value = "255" <%=weekad==255?"Selected" : "" %>>All Day</option>
										<option value = "1" <%=weekad==1?"Selected" : "" %>>Holiday</option>
										<option value = "2" <%=weekad==2?"Selected" : "" %>>Sunday</option>
										<option value = "3" <%=weekad==3?"Selected" : "" %>>Holiday+Sunday</option>
										<option value = "4" <%=weekad==4?"Selected" : "" %>>Monday</option>
										<option value = "5" <%=weekad==5?"Selected" : "" %>>Tuesday</option>
										<option value = "6" <%=weekad==6?"Selected" : "" %>>Wednesday</option>
										<option value = "7" <%=weekad==7?"Selected" : "" %>>Thursday</option>
										<option value = "8" <%=weekad==8?"Selected" : "" %>>Friday</option>
										<option value = "9" <%=weekad==9?"Selected" : "" %>>Saturday</option>
										<option value = "10" <%=weekad==10?"Selected" : "" %>>Monday-Friday</option>
										<option value = "11" <%=weekad==11?"Selected" : "" %>>Monday-Saturday</option>
									</select>
								</td>
								<td>
									<select name="SHourAD<%=k%>" class="hourselect">
<%
				int shourad = 0;
				if(k==1){
					shourad = ad.getSHour1();
				}else if(k==2){
					shourad = ad.getSHour2();
				}else if(k==3){
					shourad = ad.getSHour3();
				}else if(k==4){
					shourad = ad.getSHour4();
				}else if(k==5){
					shourad = ad.getSHour5();
				}else if(k==6){
					shourad = ad.getSHour6();
				}else if(k==7){
					shourad = ad.getSHour7();
				}else if(k==8){
					shourad = ad.getSHour8();
				}else if(k==9){
					shourad = ad.getSHour9();
				}else if(k==10){
					shourad = ad.getSHour10();
				}
				for(int i=1;i<25;i++){
%>							
										<option value = "<%=i%>" <%=shourad==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
									<select name="SMinuteAD<%=k%>" class="hourselect">
<%
				int sminutead = 0;
				if(k==1){
					sminutead = ad.getSMinute1();
				}else if(k==2){
					sminutead = ad.getSMinute2();
				}else if(k==3){
					sminutead = ad.getSMinute3();
				}else if(k==4){
					sminutead = ad.getSMinute4();
				}else if(k==5){
					sminutead = ad.getSMinute5();
				}else if(k==6){
					sminutead = ad.getSMinute6();
				}else if(k==7){
					sminutead = ad.getSMinute7();
				}else if(k==8){
					sminutead = ad.getSMinute8();
				}else if(k==9){
					sminutead = ad.getSMinute9();
				}else if(k==10){
					sminutead = ad.getSMinute10();
				}
				for(int i=0;i<60;i++){
%>							
										<option value = "<%=i%>" <%=sminutead==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
								</td>
								<td>
									<select name="EHourAD<%=k%>" class="hourselect">
<%
				int ehourad = 0;
				if(k==1){
					ehourad = ad.getEHour1();
				}else if(k==2){
					ehourad = ad.getEHour2();
				}else if(k==3){
					ehourad = ad.getEHour3();
				}else if(k==4){
					ehourad = ad.getEHour4();
				}else if(k==5){
					ehourad = ad.getEHour5();
				}else if(k==6){
					ehourad = ad.getEHour6();
				}else if(k==7){
					ehourad = ad.getEHour7();
				}else if(k==8){
					ehourad = ad.getEHour8();
				}else if(k==9){
					ehourad = ad.getEHour9();
				}else if(k==10){
					ehourad = ad.getEHour10();
				}
				
				for(int i=1;i<25;i++){
%>							
										<option value = "<%=i%>" <%=ehourad==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
									<select name="EMinuteAD<%=k%>" class="hourselect">
<%
				int eminute = 0;
				if(k==1){
					eminute = ad.getEMinute1();
				}else if(k==2){
					eminute = ad.getEMinute2();
				}else if(k==3){
					eminute = ad.getEMinute3();
				}else if(k==4){
					eminute = ad.getEMinute4();
				}else if(k==5){
					eminute = ad.getEMinute5();
				}else if(k==6){
					eminute = ad.getEMinute6();
				}else if(k==7){
					eminute = ad.getEMinute7();
				}else if(k==8){
					eminute = ad.getEMinute8();
				}else if(k==9){
					eminute = ad.getEMinute9();
				}else if(k==10){
					eminute = ad.getEMinute10();
				}
				
				for(int i=0;i<60;i++){
%>							
										<option value = "<%=i%>" <%=eminute==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
								</td>
							</tr>
<%
			}
%>
						</table>
					</div>
				</div>
				<div class="InfoButtom bt_device"  style="width:300px; float:left; margin-top:163px; margin-left:5px;position:absolute;">
					<!-- <a style="margin-right: 0px;padding-top:4px;padding-right:8px;" class="button"><span> <img src="/TrustWinPro/action/image/interface/device_com2.png" style="height:28px; width:28px;border-radius:7px;"></span></a> -->
					<a href="#" title="Send" onclick="Enroll('S,D,E,2,5,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%-- <%=lanFunc.language(lan, 183)%> --%>Send</a>
					<a href="#" style="display:none;" title="Delete" onclick="Delete('S,D,D,2,5,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%=lanFunc.language(lan, 88)%></a>
				</div>
			</div>
<%
		AutoKey ak = new AutoKey();
		ak = autoKey.SelAutoKey(rs.getInt(2));
%>
			<div class="AutoKey" id="tab6" style="display:none">
				<div class="InfoBox">
					<div class="block">
						<table>
							<colgroup>
								<col width="30%">
								<col width="20%">
								<col width="20%">
							</colgroup>
							<tr>
								<th><%=lanFunc.language(lan, 19)%></th>
								<th><%=lanFunc.language(lan, 14)%></th>
								<th><%=lanFunc.language(lan, 20)%></th>
								<th><%=lanFunc.language(lan, 22)%></th>
							</tr>
<%
			for(int k=1;k<6;k++){
				int weeak = 0;
				if(k==1){
					weeak = ak.getWeek1();
				}else if(k==2){
					weeak = ak.getWeek2();
				}else if(k==3){
					weeak = ak.getWeek3();
				}else if(k==4){
					weeak = ak.getWeek4();
				}else if(k==5){
					weeak = ak.getWeek5();
				}else if(k==6){
					weeak = ak.getWeek6();
				}else if(k==7){
					weeak = ak.getWeek7();
				}else if(k==8){
					weeak = ak.getWeek8();
				}else if(k==9){
					weeak = ak.getWeek9();
				}else if(k==10){
					weeak = ak.getWeek10();
				}
%>
							<tr>
								<td>
									<select name="WeekAK<%=k%>" class="hourselect">
										<option value = "0" <%=weeak==0?"Selected" : "" %>>None</option>
										<option value = "255" <%=weeak==255?"Selected" : "" %>>All Day</option>
										<option value = "1" <%=weeak==1?"Selected" : "" %>>Holiday</option>
										<option value = "2" <%=weeak==2?"Selected" : "" %>>Sunday</option>
										<option value = "3" <%=weeak==3?"Selected" : "" %>>Holiday+Sunday</option>
										<option value = "4" <%=weeak==4?"Selected" : "" %>>Monday</option>
										<option value = "5" <%=weeak==5?"Selected" : "" %>>Tuesday</option>
										<option value = "6" <%=weeak==6?"Selected" : "" %>>Wednesday</option>
										<option value = "7" <%=weeak==7?"Selected" : "" %>>Thursday</option>
										<option value = "8" <%=weeak==8?"Selected" : "" %>>Friday</option>
										<option value = "9" <%=weeak==9?"Selected" : "" %>>Saturday</option>
										<option value = "10" <%=weeak==10?"Selected" : "" %>>Monday-Friday</option>
										<option value = "11" <%=weeak==11?"Selected" : "" %>>Monday-Saturday</option>
									</select>
								</td>
								<td>
									<select name="SHourAK<%=k%>" class="hourselect">
<%
				int shourak = 0;
				if(k==1){
					shourak = ak.getSHour1();
				}else if(k==2){
					shourak = ak.getSHour2();
				}else if(k==3){
					shourak = ak.getSHour3();
				}else if(k==4){
					shourak = ak.getSHour4();
				}else if(k==5){
					shourak = ak.getSHour5();
				}else if(k==6){
					shourak = ak.getSHour6();
				}else if(k==7){
					shourak = ak.getSHour7();
				}else if(k==8){
					shourak = ak.getSHour8();
				}else if(k==9){
					shourak = ak.getSHour9();
				}else if(k==10){
					shourak = ak.getSHour10();
				}
				for(int i=1;i<25;i++){
%>							
										<option value = "<%=i%>" <%=shourak==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
									<select name="SMinuteAK<%=k%>" class="hourselect">
<%
				int sminuteak = 0;
				if(k==1){
					sminuteak = ak.getSMinute1();
				}else if(k==2){
					sminuteak = ak.getSMinute2();
				}else if(k==3){
					sminuteak = ak.getSMinute3();
				}else if(k==4){
					sminuteak = ak.getSMinute4();
				}else if(k==5){
					sminuteak = ak.getSMinute5();
				}else if(k==6){
					sminuteak = ak.getSMinute6();
				}else if(k==7){
					sminuteak = ak.getSMinute7();
				}else if(k==8){
					sminuteak = ak.getSMinute8();
				}else if(k==9){
					sminuteak = ak.getSMinute9();
				}else if(k==10){
					sminuteak = ak.getSMinute10();
				}
				
				for(int i=0;i<60;i++){
%>							
										<option value = "<%=i%>" <%=sminuteak ==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
								</td>
								<td>
									<select name="EHourAK<%=k%>" class="hourselect">
<%
				int ehourak = 0;
				if(k==1){
					ehourak = ak.getEHour1();
				}else if(k==2){
					ehourak = ak.getEHour2();
				}else if(k==3){
					ehourak = ak.getEHour3();
				}else if(k==4){
					ehourak = ak.getEHour4();
				}else if(k==5){
					ehourak = ak.getEHour5();
				}else if(k==6){
					ehourak = ak.getEHour6();
				}else if(k==7){
					ehourak = ak.getEHour7();
				}else if(k==8){
					ehourak = ak.getEHour8();
				}else if(k==9){
					ehourak = ak.getEHour9();
				}else if(k==10){
					ehourak = ak.getEHour10();
				}
				for(int i=1;i<25;i++){
%>							
										<option value = "<%=i%>" <%=ehourak ==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
									<select name="EMinuteAK<%=k%>" class="hourselect">
<%
				int eminuteak = 0;
				if(k==1){
					eminuteak = ak.getEMinute1();
				}else if(k==2){
					eminuteak = ak.getEMinute2();
				}else if(k==3){
					eminuteak = ak.getEMinute3();
				}else if(k==4){
					eminuteak = ak.getEMinute4();
				}else if(k==5){
					eminuteak = ak.getEMinute5();
				}else if(k==6){
					eminuteak = ak.getEMinute6();
				}else if(k==7){
					eminuteak = ak.getEMinute7();
				}else if(k==8){
					eminuteak = ak.getEMinute8();
				}else if(k==9){
					eminuteak = ak.getEMinute9();
				}else if(k==10){
					eminuteak = ak.getEMinute10();
				}
				
				for(int i=0;i<60;i++){
%>							
										<option value = "<%=i%>" <%=eminuteak ==i?"Selected" : "" %>><%=i%></option>
<%
				}
%>
									</select>
								</td>
								<td>
									<select name="FunctionKeyAK<%=k%>" class="key" >
<%
				int keyak = 0;
				if(k==1){
					keyak = ak.getKey1();
				}else if(k==2){
					keyak = ak.getKey2();
				}else if(k==3){
					keyak = ak.getKey3();
				}else if(k==4){
					keyak = ak.getKey4();
				}else if(k==5){
					keyak = ak.getKey5();
				}else if(k==6){
					keyak = ak.getKey6();
				}else if(k==7){
					keyak = ak.getKey7();
				}else if(k==8){
					keyak = ak.getKey8();
				}else if(k==9){
					keyak = ak.getKey9();
				}else if(k==10){
					keyak = ak.getKey10();
				}

				for(int i=1;i<5;i++)
				{
					for(int j=1;j<10;j++){
						String value = Integer.toString(i-1) + Integer.toString(j); 
							if(i==1){
%>
								<option value = "<%=j%>" <%=keyak ==Integer.parseInt(value)?"Selected" : "" %>>F<%=i%>-<%=j%></option>
<%		
							} else {
%>
								<option value = "<%=i-1%><%=j%>" <%=keyak ==Integer.parseInt(value)?"Selected" : "" %>>F<%=i%>-<%=j%></option>
<%									
							}
					}
					
				}
%>									
									</select>
								</td>
							</tr>
<%
			}
%>
						</table>
					</div>
				</div>
				<div class="InfoButtom bt_device" style="width:300px; float:left; margin-top:195px; margin-left:5px;position:absolute;">
					<!-- <a style="margin-right: 0px;padding-top:4px;padding-right:8px;" class="button"><span> <img src="/TrustWinPro/action/image/interface/device_com2.png" style="height:28px; width:28px;border-radius:7px;"></span></a> -->
					<a href="#" title="Send" onclick="Enroll('S,D,E,2,6,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%-- <%=lanFunc.language(lan, 183)%> --%>Send</a>
					<a href="#" style="display:none;" title="Delete" onclick="Delete('S,D,D,2,6,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%=lanFunc.language(lan, 88)%></a>
				</div>
			</div>
<%
			NoActKey nak = new NoActKey();
			nak = devFunc.SelNoActKey(rs.getInt(2));
%>
			<div class="NoAct" id="tab7" style="display:none">
				<div class="InfoBox">
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 23)%> <%=lanFunc.language(lan, 22)%></div>
						<div class="main">
							<select name="OneFK" class="minuteselect">
<%
			for(int i=1;i<5;i++)
			{
				for(int j=1;j<10;j++){
					String value = Integer.toString(i-1) + Integer.toString(j); 
					if(i==1){
%>
								<option value = "<%=j%>" <%=nak.getFirstKey() ==Integer.parseInt(value)?"Selected" : "" %>>F<%=i%>-<%=j%></option>
<%
					}else{
%>
								<option value = "<%=i-1%><%=j%>" <%=nak.getFirstKey() ==Integer.parseInt(value)?"Selected" : "" %>>F<%=i%>-<%=j%></option>
<%		
					}
				}
			}
%>		
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 24)%> <%=lanFunc.language(lan, 22)%></div>
						<div class="main">
							<select name="TwoFK" class="minuteselect">
<%
			for(int i=1;i<5;i++)
			{
				for(int j=1;j<10;j++){
					String value = Integer.toString(i-1) + Integer.toString(j); 
					if(i==1){
%>
								<option value = "<%=j%>" <%=nak.getSecondKey() ==Integer.parseInt(value)?"Selected" : "" %>>F<%=i%>-<%=j%></option>
<%		
					}else{
%>
								<option value = "<%=i-1%><%=j%>" <%=nak.getSecondKey() ==Integer.parseInt(value)?"Selected" : "" %>>F<%=i%>-<%=j%></option>
<%					
					}
					
				}
			}
%>		
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 25)%> <%=lanFunc.language(lan, 22)%></div>
						<div class="main">
							<select name="ThreeFK" class="minuteselect">
<%
			for(int i=1;i<5;i++)
			{
				for(int j=1;j<10;j++){
					String value = Integer.toString(i-1) + Integer.toString(j); 
					if(i==1){
%>			
								<option value = "<%=j%>" <%=nak.getThirdKey() ==Integer.parseInt(value)?"Selected" : "" %>>F<%=i%>-<%=j%></option>
<%		
					}else{
%>			
						<option value = "<%=i-1%><%=j%>" <%=nak.getThirdKey() ==Integer.parseInt(value)?"Selected" : "" %>>F<%=i%>-<%=j%></option>
<%							
					}
					
				}
					
					
			}
%>		
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=lanFunc.language(lan, 135)%> <%=lanFunc.language(lan, 22)%></div>
						<div class="main">
							<select name="FourFK" class="minuteselect">
<%
			for(int i=1;i<5;i++)
			{
				for(int j=1;j<10;j++){
					String value = Integer.toString(i-1) + Integer.toString(j); 
					if(i==1){
%>
								<option value = "<%=j%>" <%=nak.getFourthKey() ==Integer.parseInt(value)?"Selected" : "" %>>F<%=i%>-<%=j%></option>
<%		
					}else{
%>
								<option value = "<%=i-1%><%=j%>" <%=nak.getFourthKey() ==Integer.parseInt(value)?"Selected" : "" %>>F<%=i%>-<%=j%></option>
<%							
					}
					
				}
				
			}
%>		
							</select>
						</div>
					</div>
				</div>
				<div class="InfoButtom bt_device" style="width:300px; float:left; margin-top:250px; position:absolute;">
					<!-- <a style="margin-right: 0px;padding-top:4px;padding-right:8px;" class="button"><span> <img src="/TrustWinPro/action/image/interface/device_com2.png" style="height:28px; width:28px;border-radius:7px;"></span></a> -->
					<a href="#" title="Send" onclick="Enroll('S,D,E,2,7,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%-- <%=lanFunc.language(lan, 183)%> --%>Send</a>
					<a href="#" style="display:none;" title="Delete" onclick="Delete('S,D,D,2,7,<%=UID%>,E')"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%=lanFunc.language(lan, 88)%></a>
				</div>
			</div>
<%
	Event[] eventG = null;
	
	String start = null;
	String end = null;
	
	if(request.getParameter("start") == null){
		start = "";
	}else{
		start = (String)request.getParameter("start");
	}
	
	if(request.getParameter("end") == null){
		end = "";
	}else{
		end = (String)request.getParameter("end");
	}
	
	
	start = start.replace(" ", "");
	end = end.replace(" ", "");
	
	eventG = Evtfunc.EventDefindByDevice(start, end, UID);
%>
			<div class="Event" id="tab8" style="display:none">
			
				<div class="InfoBox">
				<table>
					<colgroup>
						<col width="20%" align="center" >
						<col width="80%">
					</colgroup>
					<tr >
						<td class="main" colspan="2">
							<div class="col-6" style="margin:1rem;">
								<div class="col-9">
								
								<!-- <p style="margin-left:2rem;"> -->
								<%=lanFunc.language(lan, 71).trim() %> : <input type="text" name="start" value="<%=start%>" id="startDate"  readonly="readOnly" onclick="fnPopUpCalendar(startDate,startDate,'yyyy-mm-dd')"  class="inputt"  /> 
								~ 
								<input type="text" name="end" value="<%=end%>" id="endDate"  readonly="readOnly" onclick="fnPopUpCalendar(endDate,endDate,'yyyy-mm-dd')" class="inputt"  /> 
								</div>
								<div class="col-3">
								<a href="#search" onclick="searchEventDevice(); " ><img src="/TrustWinPro/action/image/interface/search.png"></a>
							
								</div>
							<!-- </p> -->
							</div>
						</td>
					</tr>
				</table>					
					
				<div  style="overflow:auto; max-height: 230px;">
				<table>
					<colgroup>
						<col width="20%" align="center" >
						<col width="80%">
					</colgroup>
					<tr>
						<td colspan="2">
							<div id="devicelist">
								<table border=1 cellspacing="0"  class="titleEx1">
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="14%">
										<col width="10%">
										<col width="12%">
										<col width="12%">
										<col width="10%">
									</colgroup>
									<tr>
										<th><%=lanFunc.language(lan, 72) %></th>
										<th><%=lanFunc.language(lan, 73) %></th>
										<th><%=lanFunc.language(lan, 74) %></th>
										<th><%=lanFunc.language(lan, 75) %></th>
										<th><%=lanFunc.language(lan, 76) %></th>
										<th><%=lanFunc.language(lan, 77) %></th>
										<th><%=lanFunc.language(lan, 78) %></th>
										<th><%=lanFunc.language(lan, 79) %></th>
										<th><%=lanFunc.language(lan, 80) %></th>
									</tr>
								</table>
								<table class="ex1" cellspacing="0" >
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="14%">
										<col width="10%">
										<col width="12%">
										<col width="12%">
										<col width="10%">
									</colgroup>
									<tbody>

<%
		for(int i=0;i < eventG.length;i++){
				out.println("<tr>");
				out.println("<td>" + eventG[i].getEventType() + "</td>");
				out.println("<td>" + eventG[i].getEventDate() + "</td>");
				out.println("<td>" + eventG[i].getEventTime() + "</td>");
				out.println("<td>" + eventG[i].getEventPlace() + "</td>");
				out.println("<td>" + eventG[i].getEventName() + "</td>");
				out.println("<td>" + eventG[i].getEventUserid() + "</td>");
				out.println("<td>" + eventG[i].getEventUserName() + "</td>");
				out.println("<td>" + eventG[i].getEventDoorState() + "</td>");
				out.println("<td>" + eventG[i].getEventCompanyId() + "</td>");
				out.println("</tr>");
			}
%>
									</tbody>
								</table>
<%
		
%>
							</div>
						</td>
					</tr>
				</table>
				</div>
			</div>
			</div>
			
			<div class="AccessControl" id="tab9" style="display:none">
			<div class="InfoBox">
			<table>
					<colgroup>
						<col width="20%" align="center" >
						<col width="80%">
					</colgroup>
					<tr class="block">
						<td class="header">
						<p style="margin-left:3rem;"><%=lanFunc.language(lan, 133) %></p></td>
						<td class="main">
							<select onchange="accessList(this.value);" onload="accessList(this.value);" style = "height:28px">
								<option value = "0"  >-- <%=lanFunc.language(lan, 65) %> --</option>
<%

	AccessDevice[] accessDevice = Accfunc.SelAccessByDevice(Integer.parseInt(UID));
	int[] check_access_group = new int[accessDevice.length];
	for(int i=0;i<accessDevice.length;i++)
		check_access_group[i] = accessDevice[i].getAccess();
	
	AccessGroup[] accessGroup = null;
	accessGroup = Accfunc.AccessGroupMenu(); 
	int lengthA = accessGroup.length;
	AccessGroup[] acc = new AccessGroup[lengthA];	

	
	for(int i=0;i <lengthA; i++){
		int temp_flag =0;
		for(int tt=0;tt<accessDevice.length;tt++)
		{
			if(check_access_group[tt] == accessGroup[i].getIdx()){
%>
				<option disabled value = "<%=accessGroup[i].getIdx()%>" id="option<%=accessGroup[i].getIdx()%>" ><%=accessGroup[i].getName() %></option>
<%				
				temp_flag=1;
				continue;
			}
		}
		if(temp_flag==1) continue;
%>
		<option value = "<%=accessGroup[i].getIdx()%>" id="option<%=accessGroup[i].getIdx()%>" ><%=accessGroup[i].getName() %></option>
<%
	}
%>
							</select>
						</td>
					</tr>
				</table>
				<table>
					<colgroup>
						<col width="20%" align="center" >
						<col width="80%">
					</colgroup>
					<tr>
						<td colspan="2">
							<div id="devicelist">
								<table border=1 cellspacing="0"  class="titleEx1">
									<colgroup>
										<col width="10%">
										<col width="10%">
									</colgroup>
									<tr>
										<th><%=lanFunc.language(lan, 85)%><input type="checkbox" name="allcheck" onclick="allA_GroupInfoCheck();"></th>
										<th><%=lanFunc.language(lan, 81) %></th>
										<th><%=lanFunc.language(lan, 82) %></th>
									</tr>
								</table>
								<table class="ex1" cellspacing="0" id="access_group_table">
									<colgroup>
										<col width="10%">
										<col width="10%">
									</colgroup>
									<tbody>
<%
		for(int j=0; j<accessDevice.length; j++){
			AccessGroup accessGroup2 = Accfunc.SelAccessGroup(accessDevice[j].getAccess());
			out.println("<tr id='tr"+ accessGroup2.getIdx() +"'>");
			
			out.println("<td><input type='checkbox' class='access_class' name='AG_check' value='"+accessGroup2.getIdx()+"'></td>");

			
			out.println("<td>" + accessGroup2.getName() + "</td>");
			out.println("<td>");
			AccessDevice[] ad2 = Accfunc.SelAccessDevice(accessGroup2.getIdx());
			for(int k=0;k<ad2.length;k++){
				Device device = devFunc.selDevice(Integer.parseInt(ad2[k].getDevice()));
				out.print("<p style='margin:0;padding:0;'>"+device.getControllerName()+"</p>");
			}
			out.println("</td>");
			out.println("</tr>");
		}
%>

									</tbody>
							</table>
							</div>
					</td>
				</tr>
				</table>
					<div class="buttom bt_device"  align="right">
						<div class="image">
							<a href="#" onclick="AccessAdd(<%= Integer.parseInt(UID)%>);"><img src="/TrustWinPro/action/image/interface/submit.png"></a>
							<a href="#" onclick="AccessDelete(<%= Integer.parseInt(UID)%>);"><img  src="/TrustWinPro/action/image/interface/delete.png"></a>
						</div>
					</div>
				</div>
			</div>
	
<%
	UserList[] userlist = null;
	userlist = devFunc.DeviceUserList(UID);
	
%>		
			<div class="UserList" id="tab10" style="display:none; overflow:auto;">
			
				<div class="InfoBox" style="height:350px;">
				<table>
					<colgroup>
						<col width="20%" align="center" >
						<col width="80%">
					</colgroup>
					<tr>
						<td colspan="1">
							<div id="devicelist">
								<table border=1 cellspacing="0"  class="titleEx1">
									<colgroup>
										<col width="5%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="5%">
										<col width="5%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<tr>
										<th>No</th>
										<th><%=lanFunc.language(lan, 29) %></th>
										<th><%=lanFunc.language(lan, 81) %></th>
										<th><%=lanFunc.language(lan, 39) %></th>
										<th><%=lanFunc.language(lan, 30) %></th>
										<th><%=lanFunc.language(lan, 34) %></th>
										<th>FP1</th>
										<th>FP2</th>
										<th>����(Device)</th>
										<th>�����ȣ(Device)</th>
										<th>Etc</th>
									</tr>
								</table>
								<table class="ex1" cellspacing="0" id="DeviceUserList" >
									<colgroup>
										<col width="5%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="5%">
										<col width="5%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
									</colgroup>
									<tbody>

<%
		for(int i=0;i < userlist.length;i++){
			if(!(userlist[i].getEtc()).equals(""))
				out.println("<tr style='color:red;'>");
			else
				out.println("<tr>");
			
				out.println("<td>" + userlist[i].getNo() + "</td>");
				out.println("<td>" + userlist[i].getUserID() + "</td>");
				out.println("<td>" + userlist[i].getName() + "</td>");
				out.println("<td>" + userlist[i].getDepartment() + "</td>");
				out.println("<td>" + userlist[i].getUserClass() + "</td>");
				out.println("<td>" + userlist[i].getCard() + "</td>");
				out.println("<td>" + userlist[i].getFP1() + "</td>");
				out.println("<td>" + userlist[i].getFP2() + "</td>");
				out.println("<td>" + userlist[i].getDeviceName() + "</td>");
				out.println("<td>" + userlist[i].getDeviceID() + "</td>");
				out.println("<td>" + userlist[i].getEtc() + "</td>");
				out.println("</tr>");
			}
%>
									</tbody>
								</table>
<%
		
%>
							</div>
						</td>
					</tr>
				</table>
			</div>
				<div class="InfoButtom bt_device" style="width:300px; float:left; margin-top:5px; margin-left:5px;position:absolute;">
				<!-- 	<a style="margin-right: 0px;padding-top:4px;padding-right:8px;" class="button"><span> <img src="/TrustWinPro/action/image/interface/device_com2.png" style="height:28px; width:28px;border-radius:7px;"></span></a> -->
					<a href="#" title="Send" onclick="EnrollUserList('S,D,U,0,0,<%=UID%>,E','<%=UID%>');" class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px;  "></span><%-- <%=lanFunc.language(lan, 183)%> --%>Send</a>
				</div>
			</div>
			
			
		
			<div class="InfoButtom bt_device" >
				<a href="#DeviceInfo" onclick="DeviceInfoSubmit();" class="button gray" ><span class="icon-check"></span>Save</a>
				<a href="#DeviceInfo" onclick="DeviceDelete('<%= Integer.parseInt(UID)%>');"class="button gray" ><span class="icon-delete"></span>Remove</a>
			</div>
		</form>
	</div>
</div>
<form name="deviceDelete" id="deviceDelete" method="post" action="page/DeviceDelete.jsp" >
	<input type="hidden" name="id" value="<%=LangUtil.Empty(rs.getString(2)) %>" />
</form>

<form action="/TrustWinPro/action/index.jsp" name="eventLog" id="DeviceEventLog" method="post">
	<input type="hidden" value="Device" name="left" />
	<input type="hidden" value="DeviceInfo" name="content" />
	<input type="hidden" value="<%=UID %>" name="deviceID" />
	<input type="hidden" value="" name="start" />
	<input type="hidden" value="" name="end" />
	<input type="hidden" value="1" name="eventValue" />
</form>

<%
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
%>

<script type="text/javascript">
<%
if(request.getParameter("eventValue")!=null){
	if(request.getParameter("eventValue").equals("1")){
%>
		displayInfo(8);
<%
	}
}
%>
$(".Loading").css("display","none");
</script>