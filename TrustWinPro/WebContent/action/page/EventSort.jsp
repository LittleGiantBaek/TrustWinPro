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
	
	String status = "";
	/* for(int i=0;i<dev.length;i++){
		String status = "";
		for(int j=0;j<barcharts.length;j++){
			if(dev[i].getID().equals(barcharts[j])){
				status = "checked";
				break;
			}
		} */

%>

<script type="text/javascript">

function UserSorts(form,FN,MN,LN,DP){
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
		alert("항목을 선택하세요");
		return false;
	}else{ 
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/PrintUserList.jsp",
		    data: "array=" + arrayObj + "&FN="+FN+"&MN="+MN+"&LN="+LN+"&DP="+DP,
		    success:function(args){   
				$(".tablebor").html(args);
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		});
	 }
}
	
	
	
	var change = 0;
	function allDeviceCheck(){
		//var check = document.devicelist1.check;
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
	
	
	
	function accessDeviceClose2(){
		document.getElementById("postitUserSort").style.display = "none";
	}
	
	/* if($("input[name=info]").is(":checked"))	{
		status = "checked";
	} */
	
	
	$(document).ready( function(){
		   // read the current/previous setting
		    $("input.box[type=checkbox]").each(function() {
		        var name = $(this).attr('id');
		        if ($.cookie(name) && $.cookie(name) == "true") {
		            $(this).prop('checked', $.cookie(name));
		        }
		    });
		   // event management
		    $("input.box[type=checkbox]").change(function() {
		        var name = $(this).attr('id');
		        $.cookie(name, $(this).prop('checked'), {
		            path: '/',
		            expires: 365
		        });
		    });
		});

</script>
<div class="deviceSortPop">
<div class="selectBox">
<form name="userlist" id="userlist" method="post" action="">
<!-- <div class="printPage"> -->
		<div class="Title" style="text-align:center;color:white;padding-top:5px;height:30px;font-size:15px;background-color:#a49c9e">User Sort
		<a href="#UserInfo" onclick="accessDeviceClose2();" style="float:right"><img src="/TrustWinPro/action/image/interface/delete.png"></a>	
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
<td><input type="checkbox" name="info" value="FirstName/26" id="1" ></td>
<td ><%=Lanfunc.language(lan, 26)%></td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="MiddleName/27" id="2" ></td>
<td ><%=Lanfunc.language(lan, 27)%></td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="LastName/28" id="3" ></td>
<td ><%=Lanfunc.language(lan, 28)%></td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="UserID/29" id="4" ></td>
<td ><%=Lanfunc.language(lan, 29)%></td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="UserClass/30" id="5" ></td>
<td> <%=Lanfunc.language(lan, 30)%></td>
</tr>
<tr >
<td ><input type="checkbox" name="info" value="ID/2" id="6" ></td>
<td ><%=Lanfunc.language(lan, 2)%></td>
</tr>
<tr class="odd">
<td ><input type="checkbox" name="info" value="Password/5" id="7" ></td>
<td > <%=Lanfunc.language(lan, 5)%></td>
</tr>
<tr>
<td ><input type="checkbox" name="info" value="Department/39" id="8" ></td>
<td > <%=Lanfunc.language(lan, 39)%></td>
</tr>
</tbody>
</table>
<div class="buttom">
<a href="#" id="sortBtn" onclick="UserSorts(document.getElementById('userlist'),'<%=FirstName%>','<%=MiddleName%>','<%=LastName%>','<%=Department%>');" class="button gray"><span class="icon-check"></span>Sort</a>
</div>
<!-- div id="DeviceSorts" class="tableList2"></div> -->
</form>
<!-- 	</div> -->
</div>
	</div>
	</div>