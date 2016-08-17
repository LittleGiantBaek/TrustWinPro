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

<script type="text/javascript">

function DeviceSorts(form,CN,Add,ID,UID){
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
		    data: "div=" + "sort" + "array=" + arrayObj + "&CN="+CN+"&Add="+Add+"&ID="+ID+"&UID="+UID,
		    success:function(args){   
		        $("#DeviceSorts").html(args);     
				/* $(".Loading").css("display","none");  */
				$("#hiddenSort").css("display","none");   
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		});
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
	
	function accessDeviceClose2(){
		document.getElementById("postitDeviceSort").style.display = "none";
	}
	
	

</script>
<div class="deviceSortPop">
<div class="selectBox" style="height:400px">
<form name="devicelist" id="devicelist2" method="post" action="">
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
<div class="buttom">
<a href="#" onclick="DeviceSorts(document.getElementById('devicelist2'),'<%=ControllerName%>','<%=Address%>','<%=ID%>','<%=UniqueID%>');" class="button gray"><span class="icon-check"></span>Sort</a>
</div>
<div id="DeviceSorts" class="tableList2"></div>
</form>
<!-- 	</div> -->
</div>
	</div>
	</div>