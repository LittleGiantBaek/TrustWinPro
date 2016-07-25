<%@ page contentType="text/html; charset=euc-kr" %>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Access.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	CategoryFunc Catafunc = new CategoryFunc();
	AccessFunc Accfunc = new AccessFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	
	int idxs = 0;
	if(request.getParameter("num") == null || request.getParameter("num").equals("")){
		AccessGroup[] group =  Accfunc.AccessGroupMenu();
		idxs = group[0].getIdx();
	}else{
		idxs = Integer.parseInt(request.getParameter("num"));
	}
	String lan = (String)session.getAttribute("nation");
%>
<script type="text/javascript">
	
	var change = 0;

	function accessUserList(v){
		
		if(v!=0){
			$(".Loading").css("display","block");
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/AccessUserList.jsp",   
			    data: "group=" + v,
			    success:function(args){   
			        $("#userlist").html(args);   
					$(".Loading").css("display","none"); 			        
			    },   
			    error:function(e){  
			        alert(e.responseText);  
			    }  
			}); 
		}else{
			
		}
	}
	
	function allUserCheck(){
		var check = document.getElementsByName("checkU");
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
	
	function accessUser(){
		document.getElementById("AccessUser").submit();
	}
	
	function accessUserClose(){
		document.getElementById("postitUser").style.display = "none";
	}

</script>
<div style="overflow:auto;" class="accessUser">
	<form name="AccessUser" id="AccessUser" method="post" action="/TrustWinPro/action/page/AccessUserAdd.jsp">
	<input type="hidden" name="idx" id="idx" value="<%=idxs %>" >
		<table >
			<colgroup>
				<col width="20%" align="center" >
				<col width="80%">
			</colgroup>
			<tr class="block">
				<td class="header"  style="padding:13px;"><%=Lanfunc.language(lan, 134) %></td>
				<td class="main">
					<select name="User" onchange="accessUserList(this.value);" onload="accessUserList(this.value);">
						<option value = "0" >-- <%=Lanfunc.language(lan, 65) %> --</option>
<%
	Category[] category = null;
	category = Catafunc.CategoryDefind();
	
	int lengthC = category.length;
	Category[] cate = new Category[lengthC];	
	cate = Catafunc.SortCategoryOne(category);
	for(int i=0;i < cate.length;i++){
%>
						<option value = "<%=cate[i].getIdx()%>"><%=cate[i].getName() %></option>
<%
	}
%>
					</select>
				</td>
			</tr>
			<tr>
				<td colspan="2">
					<div id="userlist">
						<table border=1 cellspacing="0"  class="titleEx2">
							<colcate>
								<col width="10%">
								<col width="30%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
							</colcate>
							<tr>
								<th><%=Lanfunc.language(lan, 85) %> <input type="checkbox" name="order" id="order" onclick="allUserCheck();" ></th>
								<th><%=Lanfunc.language(lan, 29) %></th>
								<th><%=Lanfunc.language(lan, 81) %></th>
								<th><%=Lanfunc.language(lan, 125) %></th>
								<th><%=Lanfunc.language(lan, 126) %></th>
							</tr>
						</table>
						<table cellspacing="0"  class="ex1">
							<colgroup>
								<col width="10%">
								<col width="30%">
								<col width="20%">
								<col width="20%">
								<col width="20%">
							</colgroup>
							<tbody>
							</tbody>
						</table>
					</div>
				</td>
			</tr>
		</table>
		<div class="buttom">
			<a href="#DeviceInfo" onclick="accessUser();"><img src="/TrustWinPro/action/image/interface/submit.png"></a>
			<a href="#DeviceInfo" onclick="accessUserClose();"><img src="/TrustWinPro/action/image/interface/delete.png"></a>
		</div>
	</form>
</div>