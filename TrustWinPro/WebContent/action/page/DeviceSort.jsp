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
function DeviceList(form,CN,Add,ID,UID){
	var arrayObj = "";
	var count = 0;
	for(i=0;i<form.info.length;i++){
		if(form.info[i].checked){
			arrayObj = arrayObj + form.info[i].value + ",";
			count++;
		}
	}
	if(count==0){
		alert("항목을 선택하세요");
		return false;
	}else{
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/PrintDeviceList.jsp",
		    data: "array=" + arrayObj + "&CN="+CN+"&Add="+Add+"&ID="+ID+"&UID="+UID,
		    success:function(args){   
		        $("#DeviceList").html(args);      
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		});
	}
}
	
	
	
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
	
	function accessDevice(){
		document.getElementById("AccessDevice").submit();
	}
	
	function accessDeviceClose2(){
		document.getElementById("postitDeviceSort").style.display = "none";
	}
	
	

</script>
<div class="deviceSortPop">
<div class="selectBox">
<form name="devicelist2" id="devicelist2" method="post" action="/TrustWinPro/action/page/AllDeviceList.jsp">
<!-- <div class="printPage"> -->
		<div class="Title" style="text-align:center;color:white;padding-top:5px;height:30px;font-size:15px;background-color:#a49c9e">Device Sort
		<a href="#DeviceInfo" onclick="accessDeviceClose2();" style="float:right"><img src="/TrustWinPro/action/image/interface/delete.png"></a>	
		</div>
		<!-- <hr width="100%"> -->
		<table border="1" cellspacing="0" class="titleEx2" style="text-align:center" >
				<colgroup>
						<col width="10%">
						<col width="30%">
				</colgroup>
					<tbody>
					<tr>
						<th>Select  <input type="checkbox" name="allcheck" onclick="allDeviceCheck();"></th>
						<th>Column</th>
					</tr>
			</tbody>
		</table>
		<table cellspacing="0" class="ex1" id="hiddenSort">
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
<div id="DeviceList" class="tableList2"></div>
<div class="buttom">
<a href="#in" onclick="DeviceList2(document.getElementById('devicelist2'),'<%=ControllerName%>','<%=Address%>','<%=ID%>','<%=UniqueID%>')" class="button gray"><span class="icon-check"></span>Sort</a>
</div>

</form>
<!-- 	</div> -->
</div>
	</div>
	</div>