<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.User.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Access.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<script type="text/javascript">
var change = 0;
function allUserInfoCheck(){
	var check = document.userInfo.check;
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

function checkedF(num,v){
	var count = 0;
	var array = new Array();
	var check = document.userInfo.check;
	for(var i = 0; i< check.length; i++){
		if(check[i].checked){
			array[count] = check[i].value;
			count++;
		}
	}
	
	if(v==1){ // 전송
		if(num==count){
			Enroll('S,U,E,0,E');
		}else{
			var value = 'S,U,E,1,';
			for(var i=0;i<count;i++){
				value = value + array[i] + ',';
			}
			value = value + 'E';
			Enroll(value);
		}
	}else if(v==2){	// 삭제
		if(num==count){
			Delete('S,U,D,0,E');
		}else{
			var value = 'S,U,D,1,';
			for(var i=0;i<count;i++){
				value = value + array[i] + ',';
			}
			value = value + 'E';
			Delete(value);
		}
	}else{	// 수신
		if(num==count){
			Recive('S,U,R,0,E');
		}else{
			var value = 'S,U,R,1,';
			for(var i=0;i<count;i++){
				value = value + array[i] + ',';
			}
			value = value + 'E';
			Recive(value);
		}
	}
	
	
}

</script>
<div id="userdata">
<%
	request.setCharacterEncoding("utf-8");
	Connection conn = null;
	String FirstName = (String)request.getParameter("searchFirstName");
	if(FirstName != null){
		FirstName = new String(FirstName .getBytes("8859_1"), "UTF-8");	
	}
	String MiddleName = (String)request.getParameter("searchMiddleName");
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
	
	CategoryFunc Catefunc = new CategoryFunc();
	UserFunc Userfunc = new UserFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	AccessFunc Accfunc = new AccessFunc();
	DeviceFunc Devfunc = new DeviceFunc();
	
	User[] users = Userfunc.searchUser(FirstName,MiddleName,LastName,Department,UserClass,CompanyID);
	String lan = (String)session.getAttribute("nation");

	int top = 0;
	
	if(request.getParameter("Num")==null){
		top = 100;
	}else{
	 	top = Integer.parseInt(request.getParameter("Num"));
	}
	
	Category[] catagory = null;
	
	catagory = Catefunc.CategoryDefind();
	
	int length = catagory.length;
	Category[] cata = new Category[length];	
	cata = Catefunc.SortCategoryOne(catagory);

%>

<div>
		<section class = "sectionji">
			<ul class = "ulji">
				</ul>

<!--  class="searchForm" !-->
		<div>
			<form action="/TrustWinPro/action/index.jsp" name="allUser" id="allUser" method="post">
				<input type="hidden" value="User" name="left" />
				<input type="hidden" value="AllUser" name="content" />
				<p><div class = "headerji">
				<%=Lanfunc.language(lan, 26)%> : 
				</div>
				<input type="text" class = "inputt" name="searchFirstName" value="<%=LangUtil.Empty(FirstName)%>" /> 
				</p>

				<p><div class = "headerji">
				<%=Lanfunc.language(lan, 27)%> : 
				</div>
				<input type="text" class = "inputt" name="searchMiddleName" value="<%=LangUtil.Empty(MiddleName)%>" />
				</p>
				
				<p><div class = "headerji">
				<%=Lanfunc.language(lan, 28)%> : 
				</div>
				<input type="text" class = "inputt" name="searchLastName" value="<%=LangUtil.Empty(LastName)%>" />
				</p>

				<p><div class = "headerji">
				<%=Lanfunc.language(lan, 38)%> : 
				</div>
				<input type="text" class = "inputt" name="searchCompanyID" value="<%=LangUtil.Empty(CompanyID)%>" />
				</p>
				
				<p><div class = "headerji">
				<%=Lanfunc.language(lan, 29)%> : 
				</div>
				<input type="text" class = "inputt" name="searchUserClass" value="<%=LangUtil.Empty(UserClass)%>" />
				</p>

				<p><div class = "headerji">
				<%=Lanfunc.language(lan, 39)%> : 
				</div>
				<select name="searchDepartment" class = "hourselect">>
					<option value="">== Select Option ==</option>
<%
	for(int i=0;i<cata.length;i++){


%>

					<option value="<%=cata[i].getIdx()%>" <%=cata[i].getIdx() == Department ? "selected" : "" %>><%=cata[i].getName() %></option>
<%
	}
%>
				</select>
				<input type="submit" name="submit" value="<%=Lanfunc.language(lan, 182)%>" class="ct-btn white"  style ="margin-left:5rem"/>
				<div style="float:right; margin-right:20px">
					<a href="#a" onclick="UserPrint();"><img src="/TrustWinPro/action/image/interface/printImage.jpg" alt="" ></a>
				</div>
			</form>
		</div>


	</section>
</div>

	<form action="" name="userInfo" id="userInfo" method="post">

	<div class = "tablebor">
		<table cellspacing="0" class="titleEx1">
			<colgroup>
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
			</colgroup>
			<tr>
				<th><%=Lanfunc.language(lan, 85)%> <input type="checkbox" name="allcheck" onclick="allUserInfoCheck();" style="z-index:100;"></th>
				<th><%=Lanfunc.language(lan, 26)%></th>
				<th><%=Lanfunc.language(lan, 27)%></th>
				<th><%=Lanfunc.language(lan, 28)%></th>
				<th><%=Lanfunc.language(lan, 29)%></th>
				<th><%=Lanfunc.language(lan, 38)%></th>
				<th><%=Lanfunc.language(lan, 30)%></th>
				<th><%=Lanfunc.language(lan, 31)%></th>
				<th><%=Lanfunc.language(lan, 5)%></th>
				<th><%=Lanfunc.language(lan, 39)%></th>
				<th><%=Lanfunc.language(lan, 81)%></th>
				<th><%=Lanfunc.language(lan, 82)%></th>
			</tr>
		</table>
		<table cellspacing="0"  class="ex1">
			<colgroup>
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
				<col width="8%">
			</colgroup>
			<tbody>
<%
		for(int i=0;i<users.length;i++){
%>

				<tr>
					<td class='date1'><input type="checkbox" name="check" value="<%=users[i].getId()%>"></td>
					<td class='date1'><a href="#a" onclick="submitUser('User','<%=users[i].getUserId() %>')"><%=users[i].getFirstName() %></a></td>
					<td class='date1'><a href="#a" onclick="submitUser('User','<%=users[i].getUserId() %>')"><%=users[i].getMiddleName() %></a></td>
					<td class='date1'><a href="#a" onclick="submitUser('User','<%=users[i].getUserId() %>')"><%=users[i].getLastName() %></a></td>
					<td class='date1'><a href="#a" onclick="submitUser('User','<%=users[i].getUserId() %>')"><%=users[i].getUserId() %></a></td>
					<td class='date1'><%=users[i].getCompanyID() %></td>
					<td class='date1'>
<%
	if(users[i].getUserClass()==null){
%>
						User
<% 
	}else if(users[i].getUserClass().equals("")){
%>
						User
<%
	}else if(users[i].getUserClass().equals("1")){
%>
						User
<%
	}else if(users[i].getUserClass().equals("128")){
%>
						Admin
<%
	}
%>
					</td>
					<td class='date1'><%=users[i].getId() %></td>
					<td class='date1'><%=users[i].getPassWord() %></td>
					<td class='date1'>
<%
					String Name = Catefunc.selCategory(users[i].getDepartment()); //오류발생
					out.println(Name);

%>
					</td>
					<td class='date1'>
<%
			AccessUser[] accessUser = Accfunc.SelAccessUserId(Integer.parseInt(users[i].getUserId()));
			for(int j=0;j<accessUser.length;j++){
				AccessGroup accessGroup = Accfunc.SelAccessGroup(accessUser[j].getAccess());
				out.println(accessGroup.getName());
			}		
%>
					</td>
					<td class='date1'>
<%	
			for(int j=0;j<accessUser.length;j++){
				AccessGroup accessGroup = Accfunc.SelAccessGroup(accessUser[j].getAccess());
				AccessDevice[] ad = Accfunc.SelAccessDevice(accessGroup.getIdx());
				for(int k=0;k<ad.length;k++){
					Device device = Devfunc.selDevice(Integer.parseInt(ad[k].getDevice()));
					out.print("<p style='margin:0;padding:0;'>"+device.getControllerName()+"</p>");
				}
			}
%>
					</td>
				</tr>
<%
		}

%>	
			</tbody>
		</table>

	</div>


		<div class="bottom" id="web-buttons-idrmij3">
			<a href="#" title="Enroll" onclick="checkedF(<%=users.length %>,3);"><%=Lanfunc.language(lan, 184)%></a>
			<a href="#" title="Delete" onclick="checkedF(<%=users.length %>,2);"><%=Lanfunc.language(lan, 88)%></a>
			<a href="#" title="Recive" onclick="checkedF(<%=users.length %>,1);"><%=Lanfunc.language(lan, 183)%></a>
		</div>
	</form>
</div>
<form action="/TrustWinPro/action/index.jsp" name="User" id="User" method="post">
	<input type="hidden" value="User" name="left" />
	<input type="hidden" value="" name="userID" />
	<input type="hidden" value="UserInfo" name="content" />
</form>
