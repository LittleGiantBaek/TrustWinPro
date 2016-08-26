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
	
	String lan = (String)session.getAttribute("nation");
	String userClass = (String)session.getAttribute("userClass");

%>
<script type="text/javascript">
	function splitterClicked(){
	/* 	$( ".sm-nav>li>button" ).click(function() {
		    $(this).parent().addClass("on").siblings().removeClass("on");
		    return false;
		}); */
		//var box = $('.main-ng-view').css('display');
		var box = $('#pnlLNB').css('display');
		
		if(box == 'block'){
		$("#pnlLNB").css("display","none");
		$(".content").css("width","92%");
		$(".content").css("padding-bottom","0px");
		$("#left").css("width","8%");
		} else if(box == 'none') {			
			$("#pnlLNB").css("display","block");
			$(".content").css("width","78%");
			/* $(".content").css("height","100%"); */
			$("#left").css("width","22%");
		}
		return false;
	}
	
	function UserDelete(id){
		alertify.confirm("<%=Lanfunc.language(lan, 103)%>", function (e) {
			if (e) {
				$.ajax({      
				    type:"post",  
				    url:"/TrustWinPro/action/ajax/DeleteUser.jsp",   
				    data: "id="+id,
				    success:function(args){
				    	location.href = "/TrustWinPro/action/index.jsp?left=User&content=AllUser";
				    },   
				    error:function(e){  
				        alert(e.responseText);  
				    }  
				}); 
			    } else {
			        //location.reload();
			    }
			});
	<%-- 	var del = confirm("<%=Lanfunc.language(lan, 103)%>");
		if(del){
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/DeleteUser.jsp",   
			    data: "id="+id,
			    success:function(args){
			    	location.href = "/TrustWinPro/action/index.jsp?left=User&content=AllUser";
			    },   
			    error:function(e){  
			        alert(e.responseText);  
			    }  
			}); 
		} --%>
	}

	function DepartAdd(){
		if(document.getElementById("GroupN").value == '' || document.getElementById("GroupD").value == '')
		{
			alert('<%=Lanfunc.language(lan, 186)%>');
		} else {
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/AddDepart.jsp",   
			    data: "num="+document.getElementById("GroupN").value+"&dep="+document.getElementById("GroupD").value,
			    success:function(args){
			    	if(args == 1)
						alert("<%=Lanfunc.language(lan, 187)%>");
	
			    	location.href = "/TrustWinPro/action/index.jsp?left=User&content=AllUser";
			    },   
			    error:function(e){  
			        alert(e.responseText);  
			    }  
			}); 
		}
	}
	
	function DepartDelete(){
		if(document.getElementById("GroupN").value == '')
		{
			alert('<%=Lanfunc.language(lan, 186)%>');
		} else {
			
			alertify.confirm("<%=Lanfunc.language(lan, 188)%>", function (e) {
				if (e) {
					$.ajax({      
					    type:"post",  
					    url:"/TrustWinPro/action/ajax/DeleteDepart.jsp",   
					    data: "idx="+document.getElementById("GroupN").value,
					    success:function(args){   
					    	location.href = "/TrustWinPro/action/index.jsp?left=User&content=AllUser";
					    },   
					    error:function(e){  
					        alert(e.responseText);  
					    }  
					}); 
				    } else {
				        //location.reload();
				    }
				});
			
			<%-- var del = confirm("<%=Lanfunc.language(lan, 188)%>");
			$(".Loading").css("display","block");
			if(del){
				$.ajax({      
				    type:"post",  
				    url:"/TrustWinPro/action/ajax/DeleteDepart.jsp",   
				    data: "idx="+document.getElementById("GroupN").value,
				    success:function(args){   
				    	location.href = "/TrustWinPro/action/index.jsp?left=User&content=AllUser";
				    },   
				    error:function(e){  
				        alert(e.responseText);  
				    }  
				}); 
			} --%>
		}
	}

 	function DepartCheck(handleData){
 		var ret;
 		if(document.getElementById("GroupN").value == '' || document.getElementById("GroupD").value == '')
		{
			alert('<%=Lanfunc.language(lan, 186)%>');
		} else {
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/CheckDepartment.jsp",
			    async:false,
			    data: "num="+document.getElementById("GroupN").value+"&dep="+document.getElementById("GroupD").value,
			    success:function(args){
			    	if(args == 1){
						ret = 1;
			     		}
			    	else if(args == 2){
			     		ret = 2;
			    	}
			    	else if(args == 3){
			    		ret = 3;
			    	}
			    },   
			    error:function(e){  
			        alert(e.responseText);
			    }  
			}); 
		}
 		return ret;
	}
 	

 	function UserAdd(num){
 		$(".Loading").css("display","block");
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/AddUser.jsp",   
		    data: "depart="+num,
		    success:function(args){
		    	location.href = "/TrustWinPro/action/index.jsp?left=User&content=AllUser";
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		}); 
	}
	
	//device
	function DeviceAdd(num){
		$(".Loading").css("display","block");
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/AddDevice.jsp",   
		    data: "group="+num,
		    success:function(args){
		    	args = check(args);
		    	if(args != null && args != ""){
		    		alert(args);
		    	}
		    	
		    	location.href = "/TrustWinPro/action/index.jsp?left=Device&content=AllDevice";
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		}); 
	}


	function DeviceDelete(id){
		
		
		
		alertify.confirm("<%=Lanfunc.language(lan, 103)%>", function (e) {
			if (e) {
				$.ajax({      
				    type:"post",  
				    url:"/TrustWinPro/action/ajax/DeleteDevice.jsp",   
				    data: "id="+id,
				    success:function(args){
				    	location.href = "/TrustWinPro/action/index.jsp?left=Device&content=AllDevice";
				    },   
				    error:function(e){  
				        alert(e.responseText);  
				    }  
				}); 
			    } else {
			        //location.reload();
			    }
			});
		<%-- var del = alertify.confirm("<%=Lanfunc.language(lan, 103)%>") --%>
	/* 	if(del){
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/DeleteDevice.jsp",   
			    data: "id="+id,
			    success:function(args){
			    	location.href = "/TrustWinPro/action/index.jsp?left=Device&content=AllDevice";
			    },   
			    error:function(e){  
			        alert(e.responseText);  
			    }  
			}); 
		} */
	}
	
	
	function GroupAdd(){
		if(document.getElementById("GroupN").value == '' || document.getElementById("GroupD").value == '')
		{
			alert('<%=Lanfunc.language(lan, 189)%>');
		} else {
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/AddGroup.jsp",   
			    data: "num="+document.getElementById("GroupN").value+"&dep="+document.getElementById("GroupD").value,
			    success:function(args){   
			    	location.href = "/TrustWinPro/action/index.jsp?left=Device&content=AllDevice";
			    },   
			    error:function(e){  
			        alert(e.responseText);  
			    }  
			}); 
		}
	}
	
	function GroupDelete(){
		if(document.getElementById("GroupN").value == '')
		{
			alert('<%=Lanfunc.language(lan, 189)%>');
		} else {
			//$(".Loading").css("display","block");
			var idx = "";
			var Didx = "";
			if(document.getElementById("GroupN").value==""){
				Didx = <%=request.getParameter("deviceID")%>;
			}else{
				idx =  document.getElementById("GroupN").value;
			}
			alertify.confirm("<%=Lanfunc.language(lan, 103)%>", function (e) {
				if (e) {
					$.ajax({      
					    type:"post",  
					    url:"/TrustWinPro/action/ajax/DeleteGroup.jsp",   
					    data: "idx="+idx + "&Didx=" + Didx,
					    success:function(args){   
					    	location.href = "/TrustWinPro/action/index.jsp?left=Device&content=AllDevice";
					    },   
					    error:function(e){  
					        alert(e.responseText);  
					    }  
					}); 
				    } else {
				        //location.reload();
				    }
				});
			
	<%-- 		var del = confirm('<%=Lanfunc.language(lan, 103)%>');
			var idx = "";
			var Didx = "";
			if(document.getElementById("GroupN").value==""){
				Didx = <%=request.getParameter("deviceID")%>;
			}else{
				idx =  document.getElementById("GroupN").value;
			}
			
			if(del){
				$.ajax({      
				    type:"post",  
				    url:"/TrustWinPro/action/ajax/DeleteGroup.jsp",   
				    data: "idx="+idx + "&Didx=" + Didx,
				    success:function(args){   
				    	location.href = "/TrustWinPro/action/index.jsp?left=Device&content=AllDevice";
				    },   
				    error:function(e){  
				        alert(e.responseText);  
				    }  
				}); 
			} --%>
		}
	}
	
	
	function GroupCheck(handleData){
 		var ret;
 		
		if(document.getElementById("GroupN").value == '' || document.getElementById("GroupD").value == '')
		{
			alert('<%=Lanfunc.language(lan, 186)%>');
		} else {
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/CheckGroup.jsp",
			    async:false,
			    data: "num="+document.getElementById("GroupN").value+"&dep="+document.getElementById("GroupD").value,
			    success:function(args){
			    	if(args == 1){
						ret = 1;
			     		}
			    	else if(args == 2){
			     		ret = 2;
			    	}
			    	else if(args == 3){
			    		ret = 3;
			    	}
			    },   
			    error:function(e){  
			        alert(e.responseText);
			    }  
			}); 
		}
 		return ret;
	}
	
	$( ".sm-nav>li>button" ).click(function() {
	    $(this).parent().addClass("on").siblings().removeClass("on");
	    return false;
	});
	
</script>
<div id="left">
	<div class="left_bottom">
		<nav class="leftMainMenu" style="display: block;">
		    <ul class="sm-nav">
		        <li  class="DEVICE leftmenu" >
		           <button  onclick="location.href='/TrustWinPro/action/index.jsp?left=Device&content=AllDevice' "><img src="/TrustWinPro/action/image/interface/device icon.png" style="position:absolute;top:11px;left:30px;">
		           <br>DEVICE</button>
		        </li>
		        <li  class="USER leftmenu" >
		            <button onclick="location.href='/TrustWinPro/action/index.jsp?left=User&content=AllUser' "><img src="/TrustWinPro/action/image/interface/user icon.png" style="position:absolute;top:13px;left:30px;"><br>USER</button>
		        </li>
		        <li class="EVENT leftmenu" >
		           <button onclick="location.href='/TrustWinPro/action/index.jsp?left=Event' "><img src="/TrustWinPro/action/image/interface/event icon.png" style="position:absolute;top:13px;left:30px;"><br>EVENT</button>
		        </li>
		        <li  class="ACCESS_CONTROL leftmenu" >
		            <button onclick="location.href='/TrustWinPro/action/index.jsp?left=Time&content=AccessGroup' "><img src="/TrustWinPro/action/image/interface/time icon.png" style="position:absolute;top:13px;left:30px;width:22px;"><br>ACCESS<br>CONTROL</button>
		        </li>
		        <li  class="MORNITORING leftmenu" >
		            <button onclick="location.href='/TrustWinPro/action/index.jsp?left=Monitoring&content=Map' "><img src="/TrustWinPro/action/image/interface/monitoring_2.png" style="position:absolute;top:13px;left:30px;width:22px;"><br>MONITORING</button>
		        </li>
		    </ul>
		</nav>
		
	</div>


<div class="main-ng-view">
<div class="panelArea ng-scope" id="pnlLNB" style="-webkit-box-sizing: border-box;-moz-box-sizing: border-box;display:block;">
	<!-- <div class="left_bottom">  -->
	<%
	// userInfo
	Category[] category = null;
	
	category = Catefunc.CategoryDefind();

	int length = category.length;
	Category[] cata = new Category[length];	
	cata = Catefunc.SortCategoryOne(category);

	//DeviceInfo
	DeviceGroup[] device = null;
	device = Devfunc.GroupDefind();
	
	int lengthD = device.length;
	DeviceGroup[] dev = new DeviceGroup[lengthD];	
	dev = Devfunc.SortGroupOne(device);
	
	String left = "";
	if(request.getParameter("left")!=null){
		left = request.getParameter("left");
	}else{
		left = "Event";
	}
	if(left.equals("Device")){
%>
		<div class="Device">
			<ul>
				<li>
					<span><img src="/TrustWinPro/action/image/interface/device.png" alt=""></span>
					<span><a  id="dev1g" href="#DeviceInfo"  onclick="submitDeviceGroup('DeviceList','1','0','0');changeSpanDev(0,<%=lengthD %>,<%=dev[0].getDepth() %>,<%=dev[0].getIdx() %>,<%=request.getParameter("deviceID")%>)" id="span0" ><%=dev[0].getGroupname() %></a></span>
					<span onclick="changeInputBox(0)" id="text0" class="span devicespanroot"><%=dev[0].getGroupname() %></span>
					<span id="input0" class="spanInput"><input type="text" name="GroupName" id="GroupName0" class="inputText" value="<%=dev[0].getGroupname() %>" size="5" onkeypress="if(event.keyCode == 13) return UpdateDevice(this.value,'<%=dev[0].getIdx()%>')" onblur="UpdateDevice(this.value,'<%=dev[0].getIdx()%>')" /></span>
					<span><a href="#DeviceInfo" onclick="submit('AllDevice');" >All</a></span>
				</li>
<%
		int padding = 0;
		int[] depth;
		int LastDepth = 0;
		int LastDepth2 = 0;
		depth = new int[100];
		
		int devcot = -1;
		for(int i=1;i<lengthD;i++){
			padding = dev[i].getDepth() * 10;
			
			if(i!= lengthD-1){
				if(dev[i].getDepth()<dev[i+1].getDepth()){
					devcot++;
					depth[devcot] = dev[i].getIdx();
				}
			}else{
				LastDepth = dev[i].getIdx();
				LastDepth2 = dev[i].getDepth();
			}
			
%>
				<li style="padding-left:<%=padding%>px" >
					<span><img src="/TrustWinPro/action/image/interface/device.png" /></span>
					<%-- <span id="span<%=i %>" class = "deviceIDspan" > --%>
					<span id="span<%=i %>" class ="" >
						<a id="dev<%=dev[i].getIdx() %>g" href="#in" onclick="submitDeviceGroup('DeviceList','<%=dev[i].getIdx() %>','<%=dev[i].getDepth() %>','<%=i %>');changeSpanDev(<%=i %>,<%=lengthD %>,<%=dev[i].getDepth() %>,<%=dev[i].getIdx() %>,<%=request.getParameter("deviceID")%>);"><%=dev[i].getGroupname() %></a>
						 
						<%--  <a id="dev<%=dev[i].getIdx() %>g" href="#in" onclick="changeSpanDev(<%=i %>,<%=lengthD %>,<%=dev[i].getDepth() %>,<%=dev[i].getIdx() %>,<%=request.getParameter("deviceID")%>);"><%=dev[i].getGroupname() %></a>
						 --%>
						 <a href="#in" onclick="swich('0<%=i%>',<%=i%>)">
							<img src="/TrustWinPro/action/image/interface/close.png" class="close<%=i %>" id="close0<%=i %>" />
							<img src="/TrustWinPro/action/image/interface/open.png" class="open<%=i %>" id="open0<%=i %>" style="display:none;" />
						</a>
					</span>
					<span id="text<%=i%>" class="span">
						<a href="#in" onclick="changeInputBox(<%=i%>)"><%=dev[i].getGroupname() %></a>
						<a href="#in" onclick="swich(<%=i%>,<%=i%>)">
						<img src="/TrustWinPro/action/image/interface/close.png" class="close<%=i %>" id="close<%=i %>" />
						<img src="/TrustWinPro/action/image/interface/open.png" class="open<%=i %>" id="open<%=i %>" style="display:none;" />
						</a></span>
					<span id="input<%=i%>" class="spanInput">
						<input type="text" name="GroupName" id="GroupName<%=i%>" class="inputText" value="<%=dev[i].getGroupname() %>" size="5" onkeypress="if(event.keyCode == 13) return UpdateDevice(this.value,'<%=dev[i].getIdx()%>')" onblur="UpdateDevice(this.value,'<%=dev[i].getIdx()%>')"  />
					</span>
<%
			Device[] dev2 = Devfunc.DeviceSelect(dev[i].getIdx());
			if(dev2.length>0){
%>
						<%-- <a href="#in" onclick="swich(<%=i%>)">-</a> --%>
<%
			}
%>
<%
			
			if(dev2.length != 0){
				if(i!=lengthD-1){
					if(dev2!=null&&dev[i+1].getUpnumber() != dev[i].getIdx()){
						padding = (dev[i].getDepth()+1) * 15;
						if(0<dev2.length){
%>
					<ul id="<%=i%>">
<%
						}
						for(int j=0;j<dev2.length;j++){
%>
						<li id="dev<%=dev2[j].getID() %>" style="padding-left:15px;">
							<img src="/TrustWinPro/action/image/interface/deviceIcon.png"><a href="#content" onclick="submitDevice('Device','<%=dev2[j].getID() %>');" onkeypress="submitDevice('Device','<%=dev2[j].getID() %>');" id="dev<%=dev2[j].getID() %>a"><%=dev2[j].getControllerName() %></a>
<%
						if(j==dev2.length-1){
%>
							<a class = "bottom" href="#in" onclick="DeviceAdd(<%=dev2[j].getGroupIdx() %>);"><img src="/TrustWinPro/action/image/interface/plus.png"></a>
<%							
						}
%>
						</li>
<%
						}
						if(0<dev2.length){
%>
					</ul>
<%
						}
					}
				}
			}else if(i!= lengthD-1){
				if(dev[i].getDepth()>dev[i+1].getDepth()){
					if(dev[i+1].getDepth()<dev[i].getDepth()){
%>
					<ul id="<%=i%>">
<%
					}
					for(int k=dev[i+1].getDepth();k<dev[i].getDepth();k++){
						Device[] dev1 = Devfunc.DeviceSelect(depth[devcot]);
						padding = (devcot+2) * 15;
						for(int j=0;j<dev1.length;j++){
%>
						<li id="dev<%=dev1[j].getID() %>" style="padding-left:15px;">
							<img src="/TrustWinPro/action/image/interface/deviceIcon.png"><a href="#content" onclick="submitDevice('Device','<%=dev1[j].getID() %>');" onkeypress="submitDevice('Device','<%=dev1[j].getID() %>');" id="dev<%=dev1[j].getID() %>a"><%=dev1[j].getControllerName() %></a>
<%
						if(j==dev1.length-1){
%>
							<a class ="bottom" href="#in" onclick="DeviceAdd(<%=dev1[j].getGroupIdx() %>);"><img src="/TrustWinPro/action/image/interface/plus.png"></a>
<%							
						}
%>
						</li>
<% 
						}
						devcot--;
					}
					if(dev[i+1].getDepth()<dev[i].getDepth()){
%>
					</ul>
<%
					}
				}
			}
%>
				
<%
		}
		
		for(int i = 0;i<=LastDepth2;i++){
			if(i>0){
				LastDepth = Devfunc.GroupUpNum(LastDepth);
			}
			Device[] dev1 = Devfunc.DeviceSelect(LastDepth);
			if(0<dev1.length){
%>
					<ul id="<%=lengthD-1%>">
<%				
			}
			for(int j=0;j<dev1.length;j++){
%>
						<li id="dev<%=dev1[j].getID() %>" style="padding-left:15px;">
							<img src="/TrustWinPro/action/image/interface/deviceIcon.png"><a href="#content" onclick="submitDevice('Device','<%=dev1[j].getID() %>');" onkeypress="submitDevice('Device','<%=dev1[j].getID() %>');" id="dev<%=dev1[j].getID() %>a"><%=dev1[j].getControllerName() %></a>
<%
						if(j==dev1.length-1){
%>
							<a class = "bottom"  href="#in" onclick="DeviceAdd(<%=dev1[j].getGroupIdx() %>);"><img src="/TrustWinPro/action/image/interface/plus.png"></a>
<%							
						}
%>
						</li>
<% 
			}
			if(0<dev1.length){
%>
					</ul>
<%
			}
		}
%>
					
				</li>
			</ul>
		</div>
<!-- 		<div class="DeviceButtom" style="display:none">
			<a href="#in" onclick="GroupAdd();"><img src="/TrustWinPro/action/image/interface/add.jpg" /></a>
			<a href="#in" onclick="GroupDelete();"><img src="/TrustWinPro/action/image/interface/del.png" /></a>
			<a href="#in" onclick="DeviceAdd(document.getElementById('GroupN').value)"><img src="/TrustWinPro/action/image/interface/modify.png" /></a>
		</div> -->
<%
	}else if(left.equals("User")){
%>
		<div class="User">
			<ul>
				<li>
					<span><img src="/TrustWinPro/action/image/interface/user.png" /></span>
					<span><a  id="user1g" href="#UserInfo" onclick="submitUserGroup('UserList','1','0','0');changeSpanUser(0,<%=length %>,<%=cata[0].getDepth() %>,<%=cata[0].getIdx() %>,<%=request.getParameter("userID")%>)" id="span0" ><%=cata[0].getName() %></a></span>
					<span onclick="changeInputBox(0)" id="text0" class="span userspanroot"><%=cata[0].getName()%></span>
					<span id="input0" class="spanInput"><input type="text"  name="GroupName" id="GroupName0" class="inputText" value="<%=cata[0].getName()%>" size="10" onkeypress="if(event.keyCode == 13) return UpdateDepart(this.value,'<%=cata[0].getIdx()%>')" onblur="UpdateDepart(this.value,'<%=cata[0].getIdx()%>');"  /></span>
					<span><a href="#UserInfo" onclick="submit('AllUser');" >All</a></span> 
				</li>
			
<%
		int padding = 0;
		int[] depth;
		int LastDepth = 0;
		int LastDepth2 = 0;
		depth = new int[100];
		
		int depcot = -1;
		for(int i=1;i<length;i++){
			padding = cata[i].getDepth() * 15;

			if(i!= length-1){
				if(cata[i].getDepth()<cata[i+1].getDepth()){
					depcot++;
					depth[depcot] = cata[i].getIdx();
				}
			}else{
 				LastDepth = cata[i].getIdx();
				LastDepth2 = cata[i].getDepth();
			}
%>
				<li style="padding-left:<%=padding%>px">
					<span><img src="/TrustWinPro/action/image/interface/user.png" /></span>
					<%-- <span id="span<%=i %>" class="userIDspan" ><a href="#in" onclick="changeSpanUser(<%=i %>,<%=length %>,<%=cata[i].getDepth() %>,<%=cata[i].getIdx() %>,<%=request.getParameter("userID")%>)"><%=cata[i].getName() %></a>
					 --%>
		     		<span id="span<%=i %>" class="" >
					 	<a id="user<%=cata[i].getIdx() %>g"  href="#in" onclick="submitUserGroup('UserList','<%=cata[i].getIdx() %>','<%=cata[i].getDepth() %>','<%=i %>');changeSpanUser(<%=i %>,<%=length %>,<%=cata[i].getDepth() %>,<%=cata[i].getIdx() %>,<%=request.getParameter("userID")%>)"><%=cata[i].getName() %></a>
						<a href="#in" onclick="swich('0<%=i%>',<%=i%>)"><img src="/TrustWinPro/action/image/interface/close.png" class="close<%=i %>" id="close0<%=i %>" /></a>
						<a href="#in" onclick="swich('0<%=i%>',<%=i%>)"><img src="/TrustWinPro/action/image/interface/open.png" class="open<%=i %>" id="open0<%=i %>" style="display:none;" /></a>
					</span>

					<span id="text<%=i%>" class="span userGroupspan" >
						<a href="#in" onclick="changeInputBox(<%=i%>)" ><%=cata[i].getName() %></a>
						<a href="#in" onclick="swich(<%=i%>,<%=i%>)"><img src="/TrustWinPro/action/image/interface/close.png" class="close<%=i %>" id="close<%=i %>" /></a>
						<a href="#in" onclick="swich(<%=i%>,<%=i%>)"><img src="/TrustWinPro/action/image/interface/open.png" class="open<%=i %>" id="open<%=i %>" style="display:none;" /></a>
					</span>
	
					<span id="input<%=i%>" class="spanInput">
						<input type="text" name="GroupName" id="GroupName<%=i%>" class="inputText" value="<%=cata[i].getName() %>" size="10" onkeypress="if(event.keyCode == 13) return UpdateDepart(this.value,'<%=cata[i].getIdx()%>');" onblur="UpdateDepart(this.value,'<%=cata[i].getIdx()%>');" />
					</span> 

<%
			User[] user2 = Userfunc.UserSelect(cata[i].getIdx());
			
			if(i!=length-1){
				if(user2!=null&&cata[i+1].getUpnumber() != cata[i].getIdx()){
					if(user2.length>0){
%>
				<ul id="<%=i%>">
<%
					}
					for(int j=0;j<user2.length;j++){
%>
					<li id="user<%=user2[j].getUserId()%>" style="padding-left:15px;">
						<img src="/TrustWinPro/action/image/interface/leftusericon.png"><a href="#content" onclick="submitUser('User','<%=user2[j].getUserId()%>');" onkeypress="submit('User','<%=user2[j].getUserId() %>');" ><%=user2[j].getName() %></a>
<%
						if(j==user2.length-1){
%>
						<a class = "bottom"  href="#in" onclick="UserAdd(<%=user2[j].getDepartment() %>);"><img src="/TrustWinPro/action/image/interface/plus.png"></a>
<%							
						}
%>
					</li>
<%
					}
					if(user2.length>0){
%>
				</ul>
<%
					}
				}

				if(cata[i].getDepth()>cata[i+1].getDepth()){
					for(int k=cata[i+1].getDepth();k<cata[i].getDepth();k++){
						User[] user1 = Userfunc.UserSelect(depth[depcot]);
						if(user1.length>0){
%>
				<ul id="<%=i%>">
<%
						}
						for(int j=0;j<user1.length;j++){
%>
					<li id="user<%=user1[j].getUserId()%>" style="padding-left:15px;">
						<img src="/TrustWinPro/action/image/interface/leftusericon.png"><a href="#content" onclick="submitUser('User','<%=user1[j].getUserId() %>');" onkeypress="submit('User','<%=user1[j].getUserId() %>');" ><%=user1[j].getName() %></a>
<%

							if(j==user1.length-1){
%>						
						<a class = "bottom"  href="#in" onclick="UserAdd(<%=user1[j].getDepartment() %>);"><img src="/TrustWinPro/action/image/interface/plus.png"></a>
<%							
							}
%>
					</li>
<% 
						}
						depcot--;
						if(user1.length>0){
%>
				</ul>
<%
						}
					}
				}
			}
		}
		for(int i = 0;i<=LastDepth2;i++){
			if(i>0){
				LastDepth = Catefunc.CataUpNum(LastDepth);
			}
			User[] user1 = Userfunc.UserSelect(LastDepth);
		
			if(user1.length>0){
%>
				<ul id="<%=length-1%>">
<%
			}

			for(int j=0;j<user1.length;j++){
%>
					<li id="user<%=user1[j].getUserId()%>" style="padding-left:15px;">
						<img src="/TrustWinPro/action/image/interface/leftusericon.png"><a href="#content" onclick="submitUser('User','<%=user1[j].getUserId() %>');" onkeypress="submit('User','<%=user1[j].getUserId() %>');" ><%=user1[j].getName() %></a>
<%
						if(j==user1.length-1){
%>
						<a class = "bottom"  href="#in" onclick="UserAdd(<%=user1[j].getDepartment() %>);"><img src="/TrustWinPro/action/image/interface/plus.png"></a>
<%							
						}
%>
					</li>
<% 
			}	
			if(user1.length>0){
%>
				</ul>
<%
			}
		}
		
		
%>
				</li>
			</ul>
			
		</div>
		<div class="UserButtom" style="display:none">
			<a href="#in" onclick="DepartAdd();"><img src="/TrustWinPro/action/image/interface/add.jpg" /></a>
			<a href="#in" onclick="DepartDelete();"><img src="/TrustWinPro/action/image/interface/del.png" /></a>
			<a href="#in" onclick="UserAdd(document.getElementById('GroupN').value)"><img src="/TrustWinPro/action/image/interface/modify.png" /></a>
		</div>
<%
	}else if(left.equals("Event")){
%>
		<jsp:include page="left_event.jsp" flush="false"></jsp:include>
<%
	}else if(left.equals("Monitoring")){
%>
		<jsp:include page="left_Monitoring.jsp" flush="false"></jsp:include>
<%
	}else{
%>
		<jsp:include page="left_time.jsp" flush="false"></jsp:include>
<%
	}
		
%>
	</div> 
        </div>
   <!--  </div> -->
    <!-- splitter -->
  <div class="splitterDiv" style="margin-left:79px">
        <button href="javascript:void(0);" class="splitterRight ng-isolate-scope" onclick="splitterClicked()" ngbss-splitter="">+</button>
    </div>





<!-- <div id="left">
	<div class="left_bottom">
		<div class="left_buttom">
			<div>
				<a href="/TrustWinPro/action/index.jsp?left=Device&content=AllDevice"><img src="/TrustWinPro/action/image/interface/device icon.png" style="position:absolute;top:11px;left:30px;"><img src="/TrustWinPro/action/image/interface/leftButtom_off.png" id="deviceButtom" style="width:100%;height:41px;"><img src="/TrustWinPro/action/image/interface/leftarrow.png" style="position:absolute;top:15px;right:20px;"></a>
				<div class="Device LeftDevicetop">
					<a href="/TrustWinPro/action/index.jsp?left=Device&content=AllDevice">DEVICE</a>
				</div>
			</div>
			<div>	
				<a href="/TrustWinPro/action/index.jsp?left=User&content=AllUser"><img src="/TrustWinPro/action/image/interface/user icon.png" style="position:absolute;top:50px;left:30px;"><img src="/TrustWinPro/action/image/interface/leftButtom_off.png" id="userButtom" style="width:100%;height:41px;"><img src="/TrustWinPro/action/image/interface/leftarrow.png" style="position:absolute;top:55px;right:20px;"></a>
				<div class="User LeftUsertop">
					<a href="/TrustWinPro/action/index.jsp?left=User&content=AllUser">USER</a>
				</div>	
			</div>
			<div>	
				<a href="/TrustWinPro/action/index.jsp?left=Event"><img src="/TrustWinPro/action/image/interface/event icon.png" style="position:absolute;top:92px;left:30px;"><img src="/TrustWinPro/action/image/interface/leftButtom_off.png" id="eventButtom" style="width:100%;height:41px;"><img src="/TrustWinPro/action/image/interface/leftarrow.png" style="position:absolute;top:92px;right:20px;"></a>
				<div class="Event">
					<a href="/TrustWinPro/action/index.jsp?left=Event">EVENT</a>
				</div>
			</div>
			<div>
				<a href="/TrustWinPro/action/index.jsp?left=Time&content=AccessGroup"><img src="/TrustWinPro/action/image/interface/time icon.png" style="position:absolute;top:132px;left:30px;width:22px;"><img src="/TrustWinPro/action/image/interface/leftButtom_off.png" id="timeButtom" style="width:100%;height:41px;"><img src="/TrustWinPro/action/image/interface/leftarrow.png" style="position:absolute;top:132px;right:20px;"></a>
				<div class="Time LeftTimetop">
					<a href="/TrustWinPro/action/index.jsp?left=Time&content=AccessGroup">ACCESS CONTROL</a>
				</div>			
			</div>
			<div>
				<a href="/TrustWinPro/action/index.jsp?left=Monitoring&content=Map"><img src="/TrustWinPro/action/image/interface/time icon.png" style="position:absolute;top:172px;left:30px;width:22px;"><img src="/TrustWinPro/action/image/interface/leftButtom_off.png" id="monitoringButtom" style="width:100%;height:41px;"><img src="/TrustWinPro/action/image/interface/leftarrow.png" style="position:absolute;top:172px;right:20px;"></a>
				<div class="Monitoring LeftMonitoringtop">
					<a href="/TrustWinPro/action/index.jsp?left=Monitoring&content=Map">MONITORING</a>
				</div>
			</div>
		</div>
	</div> -->




<%-- <div class="left_top">
<%
	// userInfo
	Category[] category = null;
	
	category = Catefunc.CategoryDefind();

	int length = category.length;
	Category[] cata = new Category[length];	
	cata = Catefunc.SortCategoryOne(category);

	//DeviceInfo
	DeviceGroup[] device = null;
	device = Devfunc.GroupDefind();
	
	int lengthD = device.length;
	DeviceGroup[] dev = new DeviceGroup[lengthD];	
	dev = Devfunc.SortGroupOne(device);
	
	String left = "";
	if(request.getParameter("left")!=null){
		left = request.getParameter("left");
	}else{
		left = "Event";
	}
	if(left.equals("Device")){
%>
		<div class="Device">
			<ul>
				<li>
					<span><img src="/TrustWinPro/action/image/interface/device.png" alt=""></span>
					<span><a  href="#DeviceInfo"  onclick="changeSpanDev(0,<%=lengthD %>,<%=dev[0].getDepth() %>,<%=dev[0].getIdx() %>,<%=request.getParameter("deviceID")%>)" id="span0" ><%=dev[0].getGroupname() %></a></span>
					<span onclick="changeInputBox(0)" id="text0" class="span devicespanroot"><%=dev[0].getGroupname() %></span>
					<span id="input0" class="spanInput"><input type="text" name="GroupName" id="GroupName0" class="inputText" value="<%=dev[0].getGroupname() %>" size="5" onkeypress="if(event.keyCode == 13) return UpdateDevice(this.value,'<%=dev[0].getIdx()%>')" onblur="UpdateDevice(this.value,'<%=dev[0].getIdx()%>')" /></span>
					<span><a href="#DeviceInfo" onclick="submit('AllDevice');" >All</a></span>
				</li>
<%
		int padding = 0;
		int[] depth;
		int LastDepth = 0;
		int LastDepth2 = 0;
		depth = new int[100];
		
		int devcot = -1;
		for(int i=1;i<lengthD;i++){
			padding = dev[i].getDepth() * 20;
			
			if(i!= lengthD-1){
				if(dev[i].getDepth()<dev[i+1].getDepth()){
					devcot++;
					depth[devcot] = dev[i].getIdx();
				}
			}else{
				LastDepth = dev[i].getIdx();
				LastDepth2 = dev[i].getDepth();
			}
			
%>
				<li style="padding-left:<%=padding%>px" >
					<span><img src="/TrustWinPro/action/image/interface/device.png" /></span>
					<span id="span<%=i %>" class = "deviceIDspan" >
						<a href="#in" onclick="changeSpanDev(<%=i %>,<%=lengthD %>,<%=dev[i].getDepth() %>,<%=dev[i].getIdx() %>,<%=request.getParameter("deviceID")%>)"><%=dev[i].getGroupname() %></a>
						<a href="#in" onclick="swich('0<%=i%>',<%=i%>)">
							<img src="/TrustWinPro/action/image/interface/close.png" class="close<%=i %>" id="close0<%=i %>" />
							<img src="/TrustWinPro/action/image/interface/open.png" class="open<%=i %>" id="open0<%=i %>" style="display:none;" />
						</a>
					</span>
					<span id="text<%=i%>" class="span deviceGroupspan">
						<a href="#in" onclick="changeInputBox(<%=i%>)"><%=dev[i].getGroupname() %></a>
						<a href="#in" onclick="swich(<%=i%>,<%=i%>)">
						<img src="/TrustWinPro/action/image/interface/close.png" class="close<%=i %>" id="close<%=i %>" />
						<img src="/TrustWinPro/action/image/interface/open.png" class="open<%=i %>" id="open<%=i %>" style="display:none;" />
						</a></span>
					<span id="input<%=i%>" class="spanInput">
						<input type="text" name="GroupName" id="GroupName<%=i%>" class="inputText" value="<%=dev[i].getGroupname() %>" size="5" onkeypress="if(event.keyCode == 13) return UpdateDevice(this.value,'<%=dev[i].getIdx()%>')" onblur="UpdateDevice(this.value,'<%=dev[i].getIdx()%>')"  />
					</span>
<%
			Device[] dev2 = Devfunc.DeviceSelect(dev[i].getIdx());
			if(dev2.length>0){
%>
						<a href="#in" onclick="swich(<%=i%>)">-</a>
<%
			}
%>
<%
			
			if(dev2.length != 0){
				if(i!=lengthD-1){
					if(dev2!=null&&dev[i+1].getUpnumber() != dev[i].getIdx()){
						padding = (dev[i].getDepth()+1) * 30;
						if(0<dev2.length){
%>
					<ul id="<%=i%>">
<%
						}
						for(int j=0;j<dev2.length;j++){
%>
						<li id="dev<%=dev2[j].getID() %>" style="padding-left:15px;">
							<img src="/TrustWinPro/action/image/interface/deviceIcon.png"><a href="#content" onclick="submitDevice('Device','<%=dev2[j].getID() %>');" onkeypress="submitDevice('Device','<%=dev2[j].getID() %>');" id="dev<%=dev2[j].getID() %>a"><%=dev2[j].getControllerName() %></a>
<%
						if(j==dev2.length-1){
%>
							<a class = "bottom" href="#in" onclick="DeviceAdd(<%=dev2[j].getGroupIdx() %>);"><img src="/TrustWinPro/action/image/interface/plus.png"></a>
<%							
						}
%>
						</li>
<%
						}
						if(0<dev2.length){
%>
					</ul>
<%
						}
					}
				}
			}else if(i!= lengthD-1){
				if(dev[i].getDepth()>dev[i+1].getDepth()){
					if(dev[i+1].getDepth()<dev[i].getDepth()){
%>
					<ul id="<%=i%>">
<%
					}
					for(int k=dev[i+1].getDepth();k<dev[i].getDepth();k++){
						Device[] dev1 = Devfunc.DeviceSelect(depth[devcot]);
						padding = (devcot+2) * 30;
						for(int j=0;j<dev1.length;j++){
%>
						<li id="dev<%=dev1[j].getID() %>" style="padding-left:15px;">
							<img src="/TrustWinPro/action/image/interface/deviceIcon.png"><a href="#content" onclick="submitDevice('Device','<%=dev1[j].getID() %>');" onkeypress="submitDevice('Device','<%=dev1[j].getID() %>');" id="dev<%=dev1[j].getID() %>a"><%=dev1[j].getControllerName() %></a>
<%
						if(j==dev1.length-1){
%>
							<a class = "bottom" href="#in" onclick="DeviceAdd(<%=dev1[j].getGroupIdx() %>);"><img src="/TrustWinPro/action/image/interface/plus.png"></a>
<%							
						}
%>
						</li>
<% 
						}
						devcot--;
					}
					if(dev[i+1].getDepth()<dev[i].getDepth()){
%>
					</ul>
<%
					}
				}
			}
%>
				
<%
		}
		
		for(int i = 0;i<=LastDepth2;i++){
			if(i>0){
				LastDepth = Devfunc.GroupUpNum(LastDepth);
			}
			Device[] dev1 = Devfunc.DeviceSelect(LastDepth);
			if(0<dev1.length){
%>
					<ul id="<%=lengthD-1%>">
<%				
			}
			for(int j=0;j<dev1.length;j++){
%>
						<li id="dev<%=dev1[j].getID() %>" style="padding-left:15px;">
							<img src="/TrustWinPro/action/image/interface/deviceIcon.png"><a href="#content" onclick="submitDevice('Device','<%=dev1[j].getID() %>');" onkeypress="submitDevice('Device','<%=dev1[j].getID() %>');" id="dev<%=dev1[j].getID() %>a"><%=dev1[j].getControllerName() %></a>
<%
						if(j==dev1.length-1){
%>
							<a class = "bottom"  href="#in" onclick="DeviceAdd(<%=dev1[j].getGroupIdx() %>);"><img src="/TrustWinPro/action/image/interface/plus.png"></a>
<%							
						}
%>
						</li>
<% 
			}
			if(0<dev1.length){
%>
					</ul>
<%
			}
		}
%>
					
				</li>
			</ul>
		</div>
		<div class="DeviceButtom" style="display:none">
			<a href="#in" onclick="GroupAdd();"><img src="/TrustWinPro/action/image/interface/add.jpg" /></a>
			<a href="#in" onclick="GroupDelete();"><img src="/TrustWinPro/action/image/interface/del.png" /></a>
			<a href="#in" onclick="DeviceAdd(document.getElementById('GroupN').value)"><img src="/TrustWinPro/action/image/interface/modify.png" /></a>
		</div>
<%
	}else if(left.equals("User")){
%>
		<div class="User">
			<ul>
				<li>
					<span><img src="/TrustWinPro/action/image/interface/user.png" /></span>
					<span><a href="#UserInfo" onclick="changeSpanUser(0,<%=length %>,<%=cata[0].getDepth() %>,<%=cata[0].getIdx() %>,<%=request.getParameter("userID")%>)" id="span0" ><%=cata[0].getName() %></a></span>
					<span onclick="changeInputBox(0)" id="text0" class="span userspanroot"><%=cata[0].getName()%></span>
					<span id="input0" class="spanInput"><input type="text" name="name" id="name" class="inputText" value="<%=cata[0].getName()%>" size="10" onkeypress="if(event.keyCode == 13) return UpdateDepart(this.value,'<%=cata[0].getIdx()%>')" onblur="UpdateDepart(this.value,'<%=cata[0].getIdx()%>');"  /></span>
					<span><a href="#UserInfo" onclick="submit('AllUser');" >All</a></span> 
				</li>
			
<%
		int padding = 0;
		int[] depth;
		int LastDepth = 0;
		int LastDepth2 = 0;
		depth = new int[100];
		
		int depcot = -1;
		for(int i=1;i<length;i++){
			padding = cata[i].getDepth() * 30;

			if(i!= length-1){
				if(cata[i].getDepth()<cata[i+1].getDepth()){
					depcot++;
					depth[depcot] = cata[i].getIdx();
				}
			}else{
 				LastDepth = cata[i].getIdx();
				LastDepth2 = cata[i].getDepth();
			}
%>
				<li style="padding-left:<%=padding%>px">
					<span><img src="/TrustWinPro/action/image/interface/user.png" /></span>
					<span id="span<%=i %>" class = "userIDspan" ><a href="#in" onclick="changeSpanUser(<%=i %>,<%=length %>,<%=cata[i].getDepth() %>,<%=cata[i].getIdx() %>,<%=request.getParameter("userID")%>)"><%=cata[i].getName() %></a>
						<a href="#in" onclick="swich('0<%=i%>',<%=i%>)"><img src="/TrustWinPro/action/image/interface/close.png" class="close<%=i %>" id="close0<%=i %>" /></a>
						<a href="#in" onclick="swich('0<%=i%>',<%=i%>)"><img src="/TrustWinPro/action/image/interface/open.png" class="open<%=i %>" id="open0<%=i %>" style="display:none;" /></a>
					</span>

					<span id="text<%=i%>" class="span userGroupspan" >
						<a href="#in" onclick="changeInputBox(<%=i%>)" ><%=cata[i].getName() %></a>
						<a href="#in" onclick="swich(<%=i%>,<%=i%>)"><img src="/TrustWinPro/action/image/interface/close.png" class="close<%=i %>" id="close<%=i %>" /></a>
						<a href="#in" onclick="swich(<%=i%>,<%=i%>)"><img src="/TrustWinPro/action/image/interface/open.png" class="open<%=i %>" id="open<%=i %>" style="display:none;" /></a>
					</span>
	
					<span id="input<%=i%>" class="spanInput">
						<input type="text" name="name" id="name" class="inputText" value="<%=cata[i].getName() %>" size="10" onkeypress="if(event.keyCode == 13) return UpdateDepart(this.value,'<%=cata[i].getIdx()%>');" onblur="UpdateDepart(this.value,'<%=cata[i].getIdx()%>');" />
					</span> 

<%
			User[] user2 = Userfunc.UserSelect(cata[i].getIdx());
			
			if(i!=length-1){
				if(user2!=null&&cata[i+1].getUpnumber() != cata[i].getIdx()){
					if(user2.length>0){
%>
				<ul id="<%=i%>">
<%
					}
					for(int j=0;j<user2.length;j++){
%>
					<li id="user<%=user2[j].getUserId()%>" style="padding-left:15px;">
						<img src="/TrustWinPro/action/image/interface/leftusericon.png"><a href="#content" onclick="submitUser('User','<%=user2[j].getUserId()%>');" onkeypress="submit('User','<%=user2[j].getUserId() %>');" ><%=user2[j].getName() %></a>
<%
						if(j==user2.length-1){
%>
						<a class = "bottom"  href="#in" onclick="UserAdd(<%=user2[j].getDepartment() %>);"><img src="/TrustWinPro/action/image/interface/plus.png"></a>
<%							
						}
%>
					</li>
<%
					}
					if(user2.length>0){
%>
				</ul>
<%
					}
				}

				if(cata[i].getDepth()>cata[i+1].getDepth()){
					for(int k=cata[i+1].getDepth();k<cata[i].getDepth();k++){
						User[] user1 = Userfunc.UserSelect(depth[depcot]);
						if(user1.length>0){
%>
				<ul id="<%=i%>">
<%
						}
						for(int j=0;j<user1.length;j++){
%>
					<li id="user<%=user1[j].getUserId()%>" style="padding-left:15px;">
						<img src="/TrustWinPro/action/image/interface/leftusericon.png"><a href="#content" onclick="submitUser('User','<%=user1[j].getUserId() %>');" onkeypress="submit('User','<%=user1[j].getUserId() %>');" ><%=user1[j].getName() %></a>
<%

							if(j==user1.length-1){
%>						
						<a class = "bottom"  href="#in" onclick="UserAdd(<%=user1[j].getDepartment() %>);"><img src="/TrustWinPro/action/image/interface/plus.png"></a>
<%							
							}
%>
					</li>
<% 
						}
						depcot--;
						if(user1.length>0){
%>
				</ul>
<%
						}
					}
				}
			}
		}
		for(int i = 0;i<=LastDepth2;i++){
			if(i>0){
				LastDepth = Catefunc.CataUpNum(LastDepth);
			}
			User[] user1 = Userfunc.UserSelect(LastDepth);
		
			if(user1.length>0){
%>
				<ul id="<%=length-1%>">
<%
			}

			for(int j=0;j<user1.length;j++){
%>
					<li id="user<%=user1[j].getUserId()%>" style="padding-left:15px;">
						<img src="/TrustWinPro/action/image/interface/leftusericon.png"><a href="#content" onclick="submitUser('User','<%=user1[j].getUserId() %>');" onkeypress="submit('User','<%=user1[j].getUserId() %>');" ><%=user1[j].getName() %></a>
<%
						if(j==user1.length-1){
%>
						<a class = "bottom"  href="#in" onclick="UserAdd(<%=user1[j].getDepartment() %>);"><img src="/TrustWinPro/action/image/interface/plus.png"></a>
<%							
						}
%>
					</li>
<% 
			}	
			if(user1.length>0){
%>
				</ul>
<%
			}
		}
		
		
%>
				</li>
			</ul>
		</div>
		<div class="UserButtom" style="display:none">
			<a href="#in" onclick="DepartAdd();"><img src="/TrustWinPro/action/image/interface/add.jpg" /></a>
			<a href="#in" onclick="DepartDelete();"><img src="/TrustWinPro/action/image/interface/del.png" /></a>
			<a href="#in" onclick="UserAdd(document.getElementById('GroupN').value)"><img src="/TrustWinPro/action/image/interface/modify.png" /></a>
		</div>
<%
	}else if(left.equals("Event")){
%>
		<jsp:include page="left_event.jsp" flush="false"></jsp:include>
<%
	}else if(left.equals("Monitoring")){
%>
		<jsp:include page="left_Monitoring.jsp" flush="false"></jsp:include>
<%
	}else{
%>
		<jsp:include page="left_time.jsp" flush="false"></jsp:include>
<%
	}
		
%>
	</div>  --%>
</div>
<form>
	<input type="hidden" value="" name="deviceName" id="deviceName" />
	<input type="hidden" value="" name="GroupN" id="GroupN" />
	<input type="hidden" value="" name="GroupD" id="GroupD" />
</form>
<form action="/TrustWinPro/action/index.jsp" name="realLog" id="realLog" method="post">
	<input type="hidden" value="realLog"  name="logtype" />
	<input type="hidden" value="Event" name="left" />
	<input type="hidden" value="Log" name="content" />
</form>
<form action="/TrustWinPro/action/index.jsp" name="searchLog" id="searchLog" method="post">
	<input type="hidden" value="searchLog" name="logtype" />
	<input type="hidden" value="Event" name="left" />
	<input type="hidden" value="Log" name="content" />
</form>
<form action="/TrustWinPro/action/index.jsp" name="User" id="User" method="post">
	<input type="hidden" value="User" name="left" />
	<input type="hidden" value="" name="userID" />
	<input type="hidden" value="UserInfo" name="content" />
</form>
<form action="/TrustWinPro/action/index.jsp" name="AllUser" id="AllUser" method="post">
	<input type="hidden" value="User" name="left" />
	<input type="hidden" value="AllUser" name="content" />
</form>
<form action="/TrustWinPro/action/index.jsp" name="AllDevice" id="AllDevice" method="post">
	<input type="hidden" value="Device" name="left" />
	<input type="hidden" value="AllDevice" name="content" />
</form>
<% 
String selectdeviceGroupID = request.getParameter("deviceGroupID");
String selectdeviceGroupDepth = request.getParameter("deviceGroupDepth");
String selectdeviceGroupi = request.getParameter("deviceGroupi");
String selectdeviceID = request.getParameter("deviceID");


String selectuserGroupID = request.getParameter("userGroupID");
String selectuserGroupDepth = request.getParameter("userGroupDepth");
String selectuserGroupi = request.getParameter("userGroupi");
String selectuserID = request.getParameter("userID");
%>


<form action="/TrustWinPro/action/index.jsp" name="UserList" id="UserList" method="post">
	<input type="hidden" value="User" name="left" />
	<input type="hidden" value="<%=selectuserGroupID%>" name="userGroupID" id="valueOfUserGroupID"/>
	<input type="hidden" value="<%=selectuserGroupDepth%>" name="userGroupDepth" id="valueOfUserGroupDepth"/>
	<input type="hidden" value="<%=selectuserGroupi%>" name="userGroupi" id="valueOfUseri"/>
	<input type="hidden" value="AllUser" name="content" />
</form>

<form action="/TrustWinPro/action/index.jsp" name="DeviceList" id="DeviceList" method="post">
	<input type="hidden" value="Device" name="left" />
	<input type="hidden" value="<%=selectdeviceGroupID%>" name="deviceGroupID" id="valueOfDeviceGroupID"/>
	<input type="hidden" value="<%=selectdeviceGroupDepth%>" name="deviceGroupDepth" id="valueOfDeviceGroupDepth"/>
	<input type="hidden" value="<%=selectdeviceGroupi%>" name="deviceGroupi" id="valueOfDevicei"/>
	<input type="hidden" value="AllDevice" name="content" />
</form>

<form action="/TrustWinPro/action/index.jsp" name="Device" id="Device" method="post">
	<input type="hidden" value="Device" name="left" />
	<input type="hidden" value="<%=selectdeviceID%>" name="deviceID" id="valueOfDeviceID"/>
	<input type="hidden" value="DeviceInfo" name="content" />
</form>
<form action="/TrustWinPro/action/index.jsp" name="RightClick" id="RightClick" method="post">
	<input type="hidden" id="valueOfselectUserID" value="<%=selectuserID%>" name="selectUserID" />
	<input type="hidden" value="<%=selectdeviceID%>" name="deviceID" id="valueOfDeviceID"/>
</form>

<script type="text/javascript">
	function SpanDeviceClass(idx){
		document.getElementById("dev"+idx).className = "userspan deviceIDspan";
		document.getElementById("dev"+idx+"a").style.color = "#ffffff";
	}
	function SpanDeviceGroupClass(idx){
		document.getElementById("dev"+idx+"g").style.color = "#ffffff";
		document.getElementById("dev"+idx+"g").style.backgroundColor  = "#5c5c5b";
		document.getElementById("dev"+idx+"g").className = "deviceGroupspan";
	}
	
	if(<%=request.getParameter("deviceID")%>!=null){
		SpanDeviceClass(<%=request.getParameter("deviceID")%>);
	}
	if(<%=request.getParameter("deviceGroupID")%>!=null){
		SpanDeviceGroupClass(<%=request.getParameter("deviceGroupID")%>);
		document.getElementById("GroupN").value = <%=request.getParameter("deviceGroupID")%>;
		document.getElementById("GroupD").value = <%=request.getParameter("deviceGroupDepth")%>;
	}
	
	function SpanUserClass(idx){
		document.getElementById("user" +  idx).className = "userspan userIDspan";
		//document.getElementById("user" +  parseInt(idx,10)).className = "userspan";
	}

	function SpanUserGroupClass(idx){
		document.getElementById("user"+idx+"g").style.color = "#ffffff";
		document.getElementById("user"+idx+"g").style.backgroundColor  = "#5c5c5b";
		document.getElementById("user"+idx+"g").className = "userGroupspan";
	}
	if(<%=request.getParameter("userID")%>!=null){
		SpanUserClass("<%=request.getParameter("userID")%>");
	}

	if(<%=request.getParameter("userGroupID")%>!=null){
		SpanUserGroupClass(<%=request.getParameter("userGroupID")%>);
		document.getElementById("GroupN").value = <%=request.getParameter("userGroupID")%>;
		document.getElementById("GroupD").value = <%=request.getParameter("userGroupDepth")%>;
	}
	
	function swich(num,num2){
		if(document.getElementById(num2).style.display != "none"){
			document.getElementById("open"+num).style.display = "inline";
			document.getElementById("close"+num).style.display = "none";
			document.getElementById(num2).style.display = "none";
		}else{
			document.getElementById("open"+num).style.display = "none";
			document.getElementById("close"+num).style.display = "inline";
			document.getElementById(num2).style.display = "block";
		}
		
	}
	<%-- 
	function Buttom(val){
		if(val == "User"){
			document.getElementById("userButtom").src = "/TrustWinPro/action/image/interface/leftButtom_on.png";
			document.getElementById("deviceButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("eventButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("timeButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("monitoringButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
		}else if(val == "Device"){
			document.getElementById("userButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("deviceButtom").src = "/TrustWinPro/action/image/interface/leftButtom_on.png";
			document.getElementById("eventButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("timeButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("monitoringButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
		}else if(val == "Event"){
			document.getElementById("userButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("deviceButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("eventButtom").src = "/TrustWinPro/action/image/interface/leftButtom_on.png";
			document.getElementById("timeButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("monitoringButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
		}else if(val == "Time"){
			document.getElementById("userButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("deviceButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("eventButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("timeButtom").src = "/TrustWinPro/action/image/interface/leftButtom_on.png";
			document.getElementById("monitoringButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
		}else if(val == "Monitoring"){
			document.getElementById("userButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("deviceButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("eventButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("timeButtom").src = "/TrustWinPro/action/image/interface/leftButtom_off.png";
			document.getElementById("monitoringButtom").src = "/TrustWinPro/action/image/interface/leftButtom_on.png";
		}
	}
	
	Buttom('<%=request.getParameter("left")%>')
	 --%>
</script>

<script>
	$("#pnlLNB").css("height",$(".leftMainMenu").css("height"));
</script>

<%
			if(userClass != null && userClass.equals("128")){
		%>
			<jsp:include page="rightclickmenu.jsp" flush="false"></jsp:include>	

	<%
			}
	%>
