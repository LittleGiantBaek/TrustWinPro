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
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<%
	String currentUserClass = (String)session.getAttribute("userClass");
%>
<script type="text/javascript">
$(window).load(function() {
	$(".notcheck").css("display", "none");
	//alert("hello")
	//drawDevice();
}); 

function drawUser()
{
     var data = null;
     var table_data = null;
     $.ajax({
         url:'/TrustWinPro/action/ajax/userStatusProc.jsp',
         data: 'idx=',
         cache: false,
         success: function(res) {
        	table_data = eval("(" + res + ")");
        	$(".tablebor").html(args);
         }
    });
}

function printPage(){
	 var initBody;
	 window.onbeforeprint = function(){
	  initBody = document.body.innerHTML;
	  document.body.innerHTML =  document.getElementById('TrustPrint').innerHTML;
	 };
	 window.onafterprint = function(){
	  document.body.innerHTML = initBody;
	 };
	 window.print();
	 return false;
	}
/* When the user clicks on the button,
toggle between hiding and showing the dropdown content */
function myFunction() {
    document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {

    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}



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

		$(".Loading").css("display","inline");
		$("#progressbar").css("width","80%");
		//AllEnroll('userInfo');

	/* 	if(num==count){
			Enroll('S,U,E,0,E');
		}else{
			var value = 'S,U,E,1,';
			for(var i=0;i<count;i++){
				value = value + array[i] + ',';
			}
			value = value + 'E';
			alert(value);
			Enroll(value);
		} */
	}else if(v==2){	// 삭제
		if(num==count){
			Delete('S,U,D,0,E');
		}else{
			var value = 'S,U,D,1,';
			for(var i=0;i<count;i++){
				value = value + array[i] + ',';
			}
			value = value + 'E';
			alert(value);
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


function userSort(){
	document.getElementById("postitUserSort").style.display = "block";
	document.getElementById("postitUserSort").style.top = "200px";
}

function userExcel(){
	document.getElementById("postitUserExcel").style.display = "block";
	document.getElementById("postitUserExcel").style.top = "200px";
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
	if((String) request.getParameter("userGroupID") != null) {
		if(!((String)request.getParameter("userGroupID")).equals("")){
			Department = Integer.parseInt((String)request.getParameter("userGroupID"));
		} 
	}
	
	if((String)request.getParameter("searchDepartment")!=null ){
		if(!((String)request.getParameter("searchDepartment")).equals("")){
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
	
	List <Integer> ChildDepartmentArr = new ArrayList<Integer>();
	ChildDepartmentArr = Userfunc.departmentChildarr(Department);
	User[] users = Userfunc.searchUser(FirstName,MiddleName,LastName,ChildDepartmentArr,UserClass,CompanyID);
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
	
	String[] dev = {"1","2", "3", "4", "5", "6", "7", "8", "9"};
	EventFunc EFunc = new EventFunc();
	String user = EFunc.userVal();
	String[] userss = user.split(",");
	String statuss1 = "notcheck";
	String statuss2 = "notcheck";
	String statuss3 = "notcheck";
	String statuss4 = "notcheck";
	String statuss5 = "notcheck";
	String statuss6 = "notcheck";
	String statuss7 = "notcheck";
	String statuss8 = "notcheck";
	String statuss9 = "notcheck";
		for(int i=0;i<dev.length;i++){
			for(int j=0;j<userss.length;j++){
				if(dev[0].equals(userss[j])){
					 statuss1 = "checked";
				} else if(dev[1].equals(userss[j])) {
					 statuss2 = "checked";
				} else if(dev[2].equals(userss[j])) {
					 statuss3 = "checked";
				} else if(dev[3].equals(userss[j])) {
					 statuss4 = "checked";
				} else if(dev[4].equals(userss[j])) {
					 statuss5 = "checked";
				} else if(dev[5].equals(userss[j])) {
					 statuss6 = "checked";
				} else if(dev[6].equals(userss[j])) {
					 statuss7 = "checked";
				} else if(dev[7].equals(userss[j])) {
					 statuss8 = "checked";
				} else if(dev[8].equals(userss[j])) {
					 statuss9 = "checked";
				}
			}
		}

%>
<!-- 
<div class="meter">
  <span id="progressbar" style="width: 25%">25%</span>
</div>
 -->
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
				<select name="searchDepartment" class = "hourselect">
					<option value="<%=Department%>">== Select Option ==</option>
<%
	for(int i=0;i<cata.length;i++){


%>

					<option value="<%=cata[i].getIdx()%>" <%=cata[i].getIdx() == Department ? "selected" : "" %>><%=cata[i].getName() %></option>
					
<%
	}
%>
				</select>
				<input type="submit" name="submit" value="<%=Lanfunc.language(lan, 182)%>" class="ct-btn white"  style ="margin-left:5rem"/>
				<!-- <div style="float:right; margin-right:20px">
					<a href="#a" onclick="UserPrint();"><img src="/TrustWinPro/action/image/interface/printImage.jpg" alt="" ></a>
				</div> -->
			</form>
		</div>
	</section>
</div>

	<div class="dropdown" style="margin-left:1%; font-size:13px">
  	<button onclick="myFunction()" class="dropbtn">•••</button>
 	 <div id="myDropdown" class="dropdown-content">
    <a href="#" onclick="printPage();">Print</a>
    <a href="#" onclick="userExcel();">Excel</a>
    <a href="#" onclick="userSort();">Sort</a>
  	</div>
	</div>
	<form action="" name="userInfo" id="userInfo" method="post">
	<div class = "tablebor" id="TrustPrint">
		<table cellspacing="0" class="titleEx1">
			<colgroup>
				<col width="8%">
				<col width="8%" class="<%=statuss1%>">
				<col width="8%" class="<%=statuss2%>">
				<col width="8%" class="<%=statuss3%>">
				<col width="8%" class="<%=statuss4%>">
				<col width="8%" class="<%=statuss5%>">
				<col width="8%" class="<%=statuss6%>">
				<col width="8%" class="<%=statuss7%>">
				<col width="8%" class="<%=statuss8%>">
				<col width="8%" class="<%=statuss9%>">
				<col width="8%" >
				<col width="8%">
			</colgroup>
			<tr>
				<th><%=Lanfunc.language(lan, 85)%> <input type="checkbox" name="allcheck" onclick="allUserInfoCheck();" style="z-index:100;"></th>
				<th class="<%=statuss1%>"><%=Lanfunc.language(lan, 26)%></th>
				<th class="<%=statuss2%>"><%=Lanfunc.language(lan, 27)%></th>
				<th class="<%=statuss3%>"><%=Lanfunc.language(lan, 28)%></th>
				<th class="<%=statuss4%>"><%=Lanfunc.language(lan, 29)%></th>
				<th class="<%=statuss5%>"><%=Lanfunc.language(lan, 38)%></th>
				<th class="<%=statuss6%>"><%=Lanfunc.language(lan, 30)%></th>
				<th class="<%=statuss7%>"><%=Lanfunc.language(lan, 31)%></th>
				<th class="<%=statuss8%>"><%=Lanfunc.language(lan, 5)%></th>
				<th class="<%=statuss9%>"><%=Lanfunc.language(lan, 39)%></th>
				<th><%=Lanfunc.language(lan, 81)%></th>
				<th><%=Lanfunc.language(lan, 82)%></th>
			</tr>
		</table>
		<table cellspacing="0"  class="ex1">
			<colgroup>
				<col width="8%" >
				<col width="8%" class="<%=statuss1%>">
				<col width="8%" class="<%=statuss2%>">
				<col width="8%" class="<%=statuss3%>">
				<col width="8%" class="<%=statuss4%>">
				<col width="8%" class="<%=statuss5%>">
				<col width="8%" class="<%=statuss6%>">
				<col width="8%" class="<%=statuss7%>">
				<col width="8%" class="<%=statuss8%>">
				<col width="8%" class="<%=statuss9%>">
				<col width="8%" >
				<col width="8%">
			</colgroup>
			<tbody>
<%
		for(int i=0;i<users.length;i++){
%>

				<tr>
					<td class='date1'><input type="checkbox" name="check" value="'<%=users[i].getUserId()%>'"></td>
					<td class='date1 <%=statuss1%>'><a href="#a" onclick="submitUser('User','<%=users[i].getUserId() %>')"><%=users[i].getFirstName() %></a></td>
					<td class='date1 <%=statuss2%>'><a href="#a" onclick="submitUser('User','<%=users[i].getUserId() %>')"><%=users[i].getMiddleName() %></a></td>
					<td class='date1 <%=statuss3%>'><a href="#a" onclick="submitUser('User','<%=users[i].getUserId() %>')"><%=users[i].getLastName() %></a></td>
					<td class='date1 <%=statuss4%>'><a href="#a" onclick="submitUser('User','<%=users[i].getUserId() %>')"><%=users[i].getUserId() %></a></td>
					<td class='date1 <%=statuss5%>'><%=users[i].getCompanyID() %></td>
					<td class='date1 <%=statuss6%>'>
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
					<%
					if(currentUserClass.equals("128")){ %>
					<td class='date1 <%=statuss7%>'><%=users[i].getId() %></td>
					<td class='date1 <%=statuss8%>'><%=users[i].getPassWord() %></td>
					<% }
					else{
					%>
					<td class='date1'><%="*" %></td>
					<td class='date1'><%="*" %></td>
					<%
					}
					%>
					<td class='date1 <%=statuss9%>'>
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


		<div class="bottom">
			<a href="#" title="Send" onclick="checkedF(<%=users.length %>,1);"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/soket_logo.png" style="height:20px; width:17.5px"></span><%-- <%=Lanfunc.language(lan, 183)%> --%>Send</a>
			<a href="#" title="Recive" onclick="checkedF(<%=users.length %>,3);"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/soket_logo.png" style="height:20px; width:17.5px"></span><%=Lanfunc.language(lan, 184)%></a>
			<a href="#" title="Delete" onclick="checkedF(<%=users.length %>,2);"class="button yellow"><span style="margin-left: 0px;"><img src="/TrustWinPro/action/image/interface/soket_logo.png" style="height:20px; width:17.5px"></span><%=Lanfunc.language(lan, 88)%></a>
		</div>
	</form>
	
	
	<div class="postitUserSort" id="postitUserSort" style="display:none">
		<jsp:include page="UserSort.jsp" flush="true">
			<jsp:param name="searchFirstName" value="<%=LangUtil.Empty(FirstName)%>"/>
			<jsp:param name="searchMiddelName" value="<%=LangUtil.Empty(MiddleName)%>"/>
			<jsp:param name="searchLastName" value="<%=LangUtil.Empty(LastName)%>"/>
			<jsp:param name="searchUserclass" value="<%=LangUtil.Empty(UserClass)%>"/>
			<jsp:param name="searchCompanyID" value="<%=LangUtil.Empty(CompanyID)%>"/>
			<jsp:param name="searchDepartment" value="<%=Department%>"/>
			<jsp:param name="searchName" value="accessGroup.getName()"/>
			<jsp:param name="searchContollerName" value="device.getControllerName()"/>
		</jsp:include>
		</div>
		
		<div class="postitUserExcel" id="postitUserExcel">
		<jsp:include page="UserExcel.jsp" flush="true">
			<jsp:param name="searchFirstName" value="<%=LangUtil.Empty(FirstName)%>"/>
			<jsp:param name="searchMiddelName" value="<%=LangUtil.Empty(MiddleName)%>"/>
			<jsp:param name="searchLastName" value="<%=LangUtil.Empty(LastName)%>"/>
			<jsp:param name="searchUserclass" value="<%=LangUtil.Empty(UserClass)%>"/>
			<jsp:param name="searchCompanyID" value="<%=LangUtil.Empty(CompanyID)%>"/>
			<jsp:param name="searchDepartment" value="<%=Department%>"/>
			<jsp:param name="searchName" value="accessGroup.getName()"/>
			<jsp:param name="searchContollerName" value="device.getControllerName()"/>
		</jsp:include>
		</div>
	
	
</div>
<form action="/TrustWinPro/action/index.jsp" name="User" id="User" method="post">
	<input type="hidden" value="User" name="left" />
	<input type="hidden" value="" name="userID" />
	<input type="hidden" value="UserInfo" name="content" />
</form>
