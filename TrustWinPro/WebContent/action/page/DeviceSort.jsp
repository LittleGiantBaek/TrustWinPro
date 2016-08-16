<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Access.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Timezone.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	CategoryFunc func = new CategoryFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	
	String lan = (String)session.getAttribute("nation");
	String ControllerName = (String)request.getParameter("searchControllerName");
	if(ControllerName != null){
		ControllerName = new String(ControllerName.getBytes("8859_1"), "UTF-8");	
	}
	String Address = (String)request.getParameter("searchAddress");
	if(Address != null){
		Address = new String(Address.getBytes("8859_1"), "UTF-8");	
	}
	
	String ID = (String)request.getParameter("searchID");
	if(ID != null){
		ID = new String(ID.getBytes("8859_1"), "UTF-8");	
	}
	
	String UniqueID = (String)request.getParameter("searchUniqueID");
	if((String)request.getParameter("searchUniqueID")!=null){
		UniqueID = new String(UniqueID.getBytes("8859_1"), "UTF-8");
	}
%>
<%-- <%
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
%> --%>
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
<div class="deviceSortPop">
<div class="selectBox">
<form name="devicelist" id="devicelist" method="post" action="">
<!-- <div class="printPage"> -->
		<div class="Title" style="text-align:center;color:white;padding-top:5px;height:30px;font-size:15px;background-color:#a49c9e"><%=Lanfunc.language(lan, 176)%></div>
		<!-- <hr width="100%"> -->
		<table border="1" cellspacing="0" class="titleEx2" style="text-align:center">
				<colgroup>
						<col width="10%">
						<col width="30%">
				</colgroup>
					<tbody>
					<tr>
						<th>Select  <input type="checkbox" name="allcheck" onclick="allDeviceCheck();"></th>
						<th><%=Lanfunc.language(lan, 177)%> </th>
					</tr>
			</tbody>
		</table>
		<table cellspacing="0" class="ex1">
		<colgroup>
			<col width="10%">
			<col width="30%">
			<col width="20%">
			<col width="20%">
			<col width="20%">
		</colgroup>
		<tbody>
	
<tr class="odd">
<td><input type="checkbox" name="info" value="devicename/1"></td>
<td ><%=Lanfunc.language(lan, 1)%></td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="ID/2"></td>
<td ><%=Lanfunc.language(lan, 2)%></td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="Address/3"></td>
<td ><%=Lanfunc.language(lan, 3)%></td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="Port Number/4"></td>
<td ><%=Lanfunc.language(lan, 4)%></td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="Password/5"></td>
<td> <%=Lanfunc.language(lan, 5)%></td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="UniqueID/6"></td>
<td ><%=Lanfunc.language(lan, 6)%></td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="Server Port/7"></td>
<td > <%=Lanfunc.language(lan, 7)%></td>
</tr>
</tbody>
</table>
<div class="buttom">
			<a href="#DeviceInfo" onclick="accessDevice();"><img src="/TrustWinPro/action/image/interface/submit.png"></a>
			<a href="#DeviceInfo" onclick="accessDeviceClose();"><img src="/TrustWinPro/action/image/interface/delete.png"></a>
</div>

</form>
<!-- 	</div> -->
</div>
	</div>
	</div>