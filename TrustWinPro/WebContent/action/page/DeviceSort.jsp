<%@page import="com.Trustwin.Admin.Project.Event.EventFunc"%>
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
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
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
	
	String[] dev = {"1","2", "3", "4", "5", "6", "7"};
	EventFunc EFunc = new EventFunc();
	String device = EFunc.deviceVal();
	String[] devices = device.split(",");
	String status1 = "";
	String status2 = "";
	String status3 = "";
	String status4 = "";
	String status5 = "";
	String status6 = "";
	String status7 = "";
		for(int i=0;i<dev.length;i++){
			for(int j=0;j<devices.length;j++){
				if(dev[0].equals(devices[j])){
					status1 = "checked";
				} else if(dev[1].equals(devices[j])) {
					status2 = "checked";
				} else if(dev[2].equals(devices[j])) {
					status3 = "checked";
				} else if(dev[3].equals(devices[j])) {
					status4 = "checked";
				} else if(dev[4].equals(devices[j])) {
					status5 = "checked";
				} else if(dev[5].equals(devices[j])) {
					status6 = "checked";
				} else if(dev[6].equals(devices[j])) {
					status7 = "checked";
				}
			}
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
			console.log(arrayObj);
		}
	}
	if(count==0){
		alertify.alert("항목을 선택하세요");
		return false;
	}else{ 
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/PrintDeviceList.jsp",
		    data: "array=" + arrayObj + "&CN="+CN+"&Add="+Add+"&ID="+ID+"&UID="+UID,
		    success:function(args){   
				$(".tablebor").html(args);
				statusDevice();
		    },   
		    error:function(e){  
		    	alertify.alert(e.responseText);  
		    }  
		});
	 }
}


function statusDevice()
{
	var array = document.devicelist.info;
	var val = "";
	for(var i=0;i<array.length;i++){
		if(array[i].checked == true){
			val = val + array[i].id + ",";
		}
	}
     $.ajax({
         url:'/TrustWinPro/action/ajax/deviceStatusProc.jsp',
         data: 'val='+val,
         cache: false,
         success: function(res) {
      	  /* alert("StatusBar : " +val); */
      	location.reload(); 
        /* 	document.getElementById("devicelist").submit(); */
        	$(".tablebor").html(args);
         }
    });
}
	
	
	
	var change = 0;
	function allDeviceCheck(){
		//var check = document.getElementsByName("checkD");
		var check = document.getElementsByName("info");
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
	
	
/* 	function allDeviceInfoCheck(){
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
		
	} */
	
	function accessDeviceClose2(){
		document.getElementById("postitDeviceSort").style.display = "none";
	}
	

</script>
<div class="deviceSortPop">
<div class="selectBox">
<form name="devicelist" id="devicelist" method="post" action="">
<!-- <div class="printPage"> -->
		<div class="Title" style="text-align:center;color:white;padding-top:5px;height:30px;font-size:15px;background-color:#a49c9e">Device Sort
		<a href="#" onclick="accessDeviceClose2();" style="float:right"><img src="/TrustWinPro/action/image/interface/delete.png"></a>	
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
<td><input type="checkbox" name="info" value="devicename/1" id="1" <%=status1%>></td>
<td ><%=Lanfunc.language(lan, 1)%></td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="ID/2" id="2" <%=status2%>></td>
<td ><%=Lanfunc.language(lan, 2)%></td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="Address/3" id="3" <%=status3%>></td>
<td ><%=Lanfunc.language(lan, 3)%></td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="Port Number/4" id="4" <%=status4%>></td>
<td ><%=Lanfunc.language(lan, 4)%></td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="Password/5" id="5" <%=status5%>></td>
<td> <%=Lanfunc.language(lan, 5)%></td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="UniqueID/6" id="6" <%=status6%>></td>
<td ><%=Lanfunc.language(lan, 6)%></td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="Server Port/7" id="7" <%=status7%>></td>
<td > <%=Lanfunc.language(lan, 7)%></td>
</tr>

</tbody>
</table>
<div class="buttom">
<a href="#" id="sortBtn" onclick="DeviceSorts(document.getElementById('devicelist'),'<%=ControllerName%>','<%=Address%>','<%=ID%>','<%=UniqueID%>');" class="button gray"><span class="icon-check"></span>Sort</a>
</div>
<!-- div id="DeviceSorts" class="tableList2"></div> -->
</form>
<!-- 	</div> -->
</div>
	</div>
	</div>