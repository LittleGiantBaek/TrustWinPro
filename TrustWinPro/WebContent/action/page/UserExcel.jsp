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
	
	String FirstName = (String)request.getParameter("searchFirstName");
	if(FirstName != null){
		FirstName = new String(FirstName .getBytes("8859_1"), "UTF-8");	
	}
	
	String MiddleName = (String)request.getParameter("searchMiddelName");
	if(MiddleName != null){
		MiddleName = new String(MiddleName .getBytes("8859_1"), "UTF-8");	
	}
	
	String LastName = (String)request.getParameter("searchLastName");
	if(LastName != null){
		LastName = new String(LastName .getBytes("8859_1"), "UTF-8");	
	}

	int Department = 0;
	if((String)request.getParameter("searchDepartment")!=null){
		String temp = (String)request.getParameter("searchDepartment");
		if(!temp.equals("")){
			Department = Integer.parseInt((String)request.getParameter("searchDepartment"));
		}
	}
	
	String UserClass = (String)request.getParameter("searchUserClass");
	String CompanyID = (String)request.getParameter("searchCompanyID");
%>

<script type="text/javascript">
	var change = 0;

	
	
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
	
	function accessDeviceClose(){
		document.getElementById("postitUserExcel").style.display = "none";
	}

</script>
<div class="deviceSortPop">
<form name="userlist1" id="userlist1" method="post" action="">
<div class="selectBox">
<!-- <div class="printPage"> -->
		<div class="Title" style="text-align:center;color:white;padding-top:5px;height:30px;font-size:15px;background-color:#a49c9e">User Excel
		<a href="#UserInfo" onclick="accessDeviceClose();" style="float:right"><img src="/TrustWinPro/action/image/interface/delete.png"></a>	
		</div >
		<!-- <hr width="100%"> -->
		<!-- <div id="DeviceList" class="tableList"> -->
		<table border="1" cellspacing="0" class="titleEx2" style="text-align:center">
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
		<table cellspacing="0" class="ex1">
		<colgroup>
			<col width="10%">
			<col width="30%">
			<col width="20%">
			<col width="20%">
			<col width="20%">
			<col width="20%">
		</colgroup>
		<tbody>
	
<tr class="odd">
<td><input type="checkbox" name="info" value="FirstName/26"></td>
<td ><%=Lanfunc.language(lan, 26)%></td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="MiddleName/27"></td>
<td ><%=Lanfunc.language(lan, 27)%></td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="LastName/28"></td>
<td ><%=Lanfunc.language(lan, 28)%></td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="UserID/29"></td>
<td ><%=Lanfunc.language(lan, 29)%></td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="UserClass/30"></td>
<td> <%=Lanfunc.language(lan, 30)%></td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="ID/2"></td>
<td ><%=Lanfunc.language(lan, 2)%></td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="Password/5"></td>
<td > <%=Lanfunc.language(lan, 5)%></td>
</tr>
<tr>
<td ><input type="checkbox" name="info" value="Department/39"></td>
<td > <%=Lanfunc.language(lan, 39)%></td>
</tr>
</tbody>
</table>
<div class="buttom" >
<a href="#UserInfo" onclick="UserExcel(document.getElementById('userlist1'),'<%=FirstName%>','<%=MiddleName%>','<%=LastName%>','<%=Department%>');" class="button gray"><span class="icon-check"></span>Excel</a>
</div>

</div>
</form>
<!-- 	</div> -->
	</div>
	</div>