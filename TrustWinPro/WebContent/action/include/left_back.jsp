<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.User.*" %>
<script type="text/javascript">
	
	//user
	
	function UserAdd(depart){
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/AddUser.jsp",   
		    data: "depart="+depart,
		    success:function(args){
		    	location.reload(); 
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		}); 
	}
	
	function UserDelete(id){
		var del = confirm("정말 삭제하시겠습니까?")
		if(del){
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/DeleteUser.jsp",   
			    data: "id="+id,
			    success:function(args){
			    	alert(id);
			    	location.reload();
			    },   
			    error:function(e){  
			        alert(e.responseText);  
			    }  
			}); 
		}
	}
	
	function DepartAdd(num,dep){
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/AddDepart.jsp",   
		    data: "num="+num+"&dep="+dep,
		    success:function(args){   
		    	location.reload();
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		}); 
	}
	
	function DepartDelete(num){
		var del = confirm("정말 삭제하시겠습니까?")
		if(del){
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/DeleteDepart.jsp",   
			    data: "idx="+num,
			    success:function(args){   
			    	location.reload();
			    },   
			    error:function(e){  
			        alert(e.responseText);  
			    }  
			}); 
		}
	}
	
	//device
	function DeviceAdd(group){
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/AddDevice.jsp",   
		    data: "group="+group,
		    success:function(args){
		    	location.reload(); 
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		}); 
	}
	
	function DeviceDelete(id){
		var del = confirm("정말 삭제하시겠습니까?")
		if(del){
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/DeleteDevice.jsp",   
			    data: "id="+id,
			    success:function(args){
			    	location.reload();
			    },   
			    error:function(e){  
			        alert(e.responseText);  
			    }  
			}); 
		}
	}
	
	function GroupAdd(num,dep){
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/AddGroup.jsp",   
		    data: "num="+num+"&dep="+dep,
		    success:function(args){   
		    	location.reload();
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		}); 
	}
	
	function GroupDelete(num){
		var del = confirm("정말 삭제하시겠습니까?")
		if(del){
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/DeleteGroup.jsp",   
			    data: "idx="+num,
			    success:function(args){   
			    	location.reload();
			    },   
			    error:function(e){  
			        alert(e.responseText);  
			    }  
			}); 
		}
	}
	
	function changeInputBox(num){
		document.getElementById("text" + num).style.display = "none";
		document.getElementById("input" + num).style.display = "block";
	}
	
	function UpdateDevice(name,idx){
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/UpdateDevice.jsp",   
		    data: "deviceName="+name+"&idx="+idx,
		    success:function(args){   
		    	location.reload();
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		}); 
	}
	
	function UpdateDepart(name,idx){
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/UpdateDepart.jsp",   
		    data: "name="+name+"&idx="+idx,
		    success:function(args){   
		    	location.reload();
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		}); 
	}
</script>
<div id="left">
	<div class="left_top">
<%
	// userInfo
	Category[] category = null;
	CategoryFunc func = new CategoryFunc();
	category = func.CategoryDefind();

	int length = category.length;
	Category[] cata = new Category[length];	
	cata = func.SortCategoryOne(category);

	//DeviceInfo
	DeviceGroup[] device = null;
	device = func.GroupDefind();
	
	int lengthD = device.length;
	DeviceGroup[] dev = new DeviceGroup[lengthD];	
	dev = func.SortGroupOne(device);
	
	String left = "";
	if(request.getParameter("left")!=null){
		left = request.getParameter("left");
	}
	if(left.equals("Device")){
%>
		<div class="Device">
			<ul>
				<li><span onclick="changeInputBox(0)" id="text0" ><%=dev[0].getGroupname() %></span>
				<span id="input0" class="spanInput"><input type="text" name="GroupName" id="GroupName" class="inputText" value="<%=dev[0].getGroupname() %>" size="5" onkeypress="if(event.keyCode == 13) return UpdateDevice(this.value,'<%=dev[0].getIdx()%>')" onblur="return UpdateDevice(this.value,'<%=dev[0].getIdx()%>')" /></span>
				<font size="0.5"> &nbsp;DevGroup<a href="#in" onclick="GroupAdd(<%=dev[0].getIdx()%>,<%=dev[0].getDepth()+1%>);">+</a>|Device<a href="#in" onclick="DeviceAdd('<%=dev[0].getIdx()%>');">+</a></font></li>
			
<%
		int padding = 0;
		int[] depth;
		int LastDepth = 0;
		int LastDepth2 = 0;
		depth = new int[100];
		
		int devcot = -1;
		for(int i=1;i<lengthD;i++){
			padding = dev[i].getDepth() * 30;
			
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
				<li style="padding-left:<%=padding%>px">
				<span onclick="changeInputBox(<%=i%>)" id="text<%=i%>" ><%=dev[i].getGroupname() %></span>
				<span id="input<%=i%>" class="spanInput"><input type="text" name="GroupName" id="GroupName" class="inputText" value="<%=dev[i].getGroupname() %>" size="5" onkeypress="if(event.keyCode == 13) return UpdateDevice(this.value,'<%=dev[i].getIdx()%>')" onblur="return UpdateDevice(this.value,'<%=dev[0].getIdx()%>')"  /></span> 
				<font size="0.5">DevGroup<a href="#in" onclick="GroupAdd(<%=dev[i].getIdx()%>,<%=dev[i].getDepth()+1%>);">+</a>/<a href="#in" onclick="GroupDelete(<%=dev[i].getIdx()%>);">-</a>
				|Device<a href="#in" onclick="DeviceAdd(<%=dev[i].getIdx()%>);">+</a></font></li>
<%
			Device[] dev2 = func.DeviceSelect(dev[i].getIdx());
			if(i!=lengthD-1||i==1){
				if(i==1){
					padding = (dev[i].getDepth()+1) * 30;
					for(int j=0;j<dev2.length;j++){
%>
				<li style="padding-left:<%=padding%>px"><a href="#content" onclick="submitDevice('Device','<%=dev2[j].getUniqueID() %>');" onkeypress="submit('Device');" ><%=dev2[j].getControllerName() %></a><font size="0.5">Device<a href="#in" onclick="DeviceDelete('<%=dev2[j].getUniqueID()%>');">-</a></font></li>
<%
					}
				}else if(dev2!=null&&dev[i+1].getUpnumber() != dev[i].getIdx()){
					padding = (dev[i].getDepth()+1) * 30;
					for(int j=0;j<dev2.length;j++){
%>
				<li style="padding-left:<%=padding%>px"><a href="#content" onclick="submitDevice('Device','<%=dev2[j].getUniqueID() %>');" onkeypress="submit('Device');" ><%=dev2[j].getControllerName() %></a><font size="0.5">Device<a href="#in" onclick="DeviceDelete('<%=dev2[j].getUniqueID()%>');">-</a></font></li>
<%
					}
				}
			}
			if(i!= lengthD-1){
				if(dev[i].getDepth()>dev[i+1].getDepth()){
					for(int k=dev[i+1].getDepth();k<dev[i].getDepth();k++){
						Device[] dev1 = func.DeviceSelect(depth[devcot]);
						padding = (devcot+2) * 30;
						for(int j=0;j<dev1.length;j++){
%>
				<li style="padding-left:<%=padding%>px"><a href="#content" onclick="submitDevice('Device','<%=dev1[j].getUniqueID() %>');" onkeypress="submit('Device');" ><%=dev1[j].getControllerName() %></a><font size="0.5">Device<a href="#in" onclick="DeviceDelete('<%=dev1[j].getUniqueID()%>');">-</a></font></li>
<% 
						}
						devcot--;
					}
				}
			}
		}
		
		for(int i = 0;i<=LastDepth2;i++){
			if(i>0){
				LastDepth = func.GroupUpNum(LastDepth);
			}
			Device[] dev1 = func.DeviceSelect(LastDepth);
			padding = (LastDepth2+1-i) * 30;
			for(int j=0;j<dev1.length;j++){
%>
				<li style="padding-left:<%=padding%>px"><a href="#content" onclick="submitDevice('Device','<%=dev1[j].getUniqueID() %>');" onkeypress="submit('User');" ><%=dev1[j].getControllerName() %></a><font size="0.5">Device<a href="#in" onclick="DeviceDelete('<%=dev1[j].getUniqueID()%>');">-</a></font></li>
<% 
			}
			
		}
%>
			</ul>
		</div>
<%
	}else if(left.equals("User")){
%>
		<div class="User">
			<ul>
				<li><span onclick="changeInputBox(0)" id="text0" ><%=cata[0].getName() %></span>
				<span id="input0" class="spanInput"><input type="text" name="name" id="name" class="inputText" value="<%=cata[0].getName() %>" size="10" onkeypress="if(event.keyCode == 13) return UpdateDepart(this.value,'<%=cata[0].getIdx()%>')" onblur="UpdateDepart(this.value,'<%=cata[0].getIdx()%>');"  /></span> 
				<font size="0.5">부서<a href="#in" onclick="DepartAdd(<%=cata[0].getIdx()%>,<%=cata[0].getDepth()+1%>);">+</a>|사용자<a href="#in" onclick="UserAdd('<%=cata[0].getIdx()%>');">+</a></font></li>
			
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
				<li style="padding-left:<%=padding%>px"><span onclick="changeInputBox(<%=i%>)" id="text<%=i%>" ><%=cata[i].getName() %></span>
				<span id="input<%=i%>" class="spanInput"><input type="text" name="name" id="name" class="inputText" value="<%=cata[i].getName() %>" size="10" onkeypress="if(event.keyCode == 13) return UpdateDepart(this.value,'<%=cata[i].getIdx()%>');" onblur="UpdateDepart(this.value,'<%=cata[i].getIdx()%>');" /></span> 
				<font size="0.5">부서<a href="#in" onclick="DepartAdd(<%=cata[i].getIdx()%>,<%=cata[i].getDepth()+1%>);">+</a>/<a href="#in" onclick="DepartDelete(<%=cata[i].getIdx()%>);">-</a>|사용자<a href="#in" onclick="UserAdd(<%=cata[i].getIdx()%>);">+</a></font></li>
<%
			User[] user2 = func.UserSelect(cata[i].getIdx());
			if(i!=length-1){
				if(user2!=null&&cata[i+1].getUpnumber() != cata[i].getIdx()){
					padding = (cata[i].getDepth()+1) * 30;
					for(int j=0;j<user2.length;j++){
%>
				<li style="padding-left:<%=padding%>px"><a href="#content" onclick="submitUser('User','<%=user2[j].getId() %>');" onkeypress="submit('User');" ><%=user2[j].getName() %></a><font size="0.5">사용자<a href="#in" onclick="UserDelete('<%=user2[j].getId()%>');">-</a></font></li>
<%
					}
				}
			}
			if(i!= length-1){
				if(cata[i].getDepth()>cata[i+1].getDepth()){
					for(int k=cata[i+1].getDepth();k<cata[i].getDepth();k++){
						User[] user1 = func.UserSelect(depth[depcot]);
						padding = (depcot+2) * 30;
						for(int j=0;j<user1.length;j++){
%>
				<li style="padding-left:<%=padding%>px"><a href="#content" onclick="submitUser('User','<%=user1[j].getId() %>');" onkeypress="submit('User');" ><%=user1[j].getName() %></a><font size="0.5">사용자<a href="#in" onclick="UserDelete('<%=user1[j].getId()%>');">-</a></font></li>
<% 
						}
						depcot--;
					}
				}
			}
			
		}
		for(int i = 0;i<=LastDepth2;i++){
			if(i>0){
				LastDepth = func.CataUpNum(LastDepth);
			}
			User[] user1 = func.UserSelect(LastDepth);
			padding = (LastDepth2+1-i) * 30;
			for(int j=0;j<user1.length;j++){
%>
				<li style="padding-left:<%=padding%>px"><a href="#content" onclick="submitUser('User','<%=user1[j].getId() %>');" onkeypress="submit('User');" ><%=user1[j].getName() %></a><font size="0.5">사용자<a href="#in" onclick="UserDelete('<%=user1[j].getId()%>');">-</a></font></li>
<% 
			}
			
		}
%>
			</ul>
		</div>
<%
	}else if(left.equals("Event")){
%>
		<div class="left_box">
			<a href="#content" onclick="submit('realLog');" onkeypress="submit('realLog');" >realLog</a>
			<a href="#content" onclick="submit('searchLog');" onkeypress="submit('searchLog');" >searchlog</a>
		</div>
<%
	}else{
%>
		<div>
				&nbsp;
		</div>
<%
	}
		
%>
	</div>
	<div class="left_bottom">
		<div class="left_buttom">
			<ul>
				<li class="button01"><a href="/TrustWinPro/action/index.jsp?left=Device&content=DeviceInfo">Device</a></li>
				<li class="button01"><a href="/TrustWinPro/action/index.jsp?left=User&content=UserInfo">User</a></li>
				<li class="button01"><a href="/TrustWinPro/action/index.jsp?left=Event">Event</a></li>
			</ul>
		</div>
	</div>
</div>
<form action="/TrustWinPro/action/index.jsp" name="realLog" id="realLog" method="get">
	<input type="hidden" value="realLog"  name="logtype" />
	<input type="hidden" value="Event" name="left" />
	<input type="hidden" value="Log" name="content" />
</form>
<form action="/TrustWinPro/action/index.jsp" name="searchLog" id="searchLog" method="get">
	<input type="hidden" value="searchLog" name="logtype" />
	<input type="hidden" value="Event" name="left" />
	<input type="hidden" value="Log" name="content" />
</form>
<form action="/TrustWinPro/action/index.jsp" name="User" id="User" method="get">
	<input type="hidden" value="User" name="left" />
	<input type="hidden" value="" name="userID" />
	<input type="hidden" value="UserInfo" name="content" />
</form>
<form action="/TrustWinPro/action/index.jsp" name="Device" id="Device" method="get">
	<input type="hidden" value="Device" name="left" />
	<input type="hidden" value="" name="deviceID" />
	<input type="hidden" value="DeviceInfo" name="content" />
</form>