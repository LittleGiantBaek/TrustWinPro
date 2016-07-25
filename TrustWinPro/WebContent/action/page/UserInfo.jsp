<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.User.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Access.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<%@ page import="com.Trustwin.Admin.Project.Timezone.*" %>
<%
	String ID = (String)request.getParameter("userID");

	UserFunc Userfunc = new UserFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	CategoryFunc Catefunc = new CategoryFunc();
	AccessFunc Accfunc = new AccessFunc();
	DeviceFunc Devfunc = new DeviceFunc();
	EventFunc Evtfunc = new EventFunc();
	TimeZoneFunc Timfunc = new TimeZoneFunc();

	//Catefunc.test123123();
	
	String lan = (String)session.getAttribute("nation");
	if(ID == null){
		ID = Userfunc.UserTop();
	}
	Connection conn = null;
	String sql = "select FirstName, MiddleName, LastName, UserID, UserClass, ID, Password, CompanyID, Department, "+
	"Position, TelOffice, EngagedDay, LatestPromoted, RetiredDay, License1, License2, License3, HourlyWage, EMail, Sex, "+
	"Married, ResidentRegNo, TelHome, MobilePhone, CarName, ZipCode, Address, CardID, CardType, FacilityCode, CardAttribute, "+
	"TimeZoneNo1, TimeZoneNo2, UserMode, UseSubSensor, UseDuressFinger, photo, DeviceGroup, ReAccessLimitTime from member where UserID = '" + ID + "'";
	try {
	
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
	conn = ds.getConnection();
	Statement pstmt = conn.createStatement();
	ResultSet rs = pstmt.executeQuery(sql);
	if(!rs.next()){
%>
		<script>
			alert("정보가 없습니다.");
			location.replace("index.jsp?left=User");
		</script>
<%
			}else{
%>
<script type="text/javascript">

var cardid = 0;
var companyid = 0;
function previewImage(targetObj, View_area) {
	var preview = document.getElementById(View_area); //div id
	var ua = window.navigator.userAgent;
	var ImagePrev = document.getElementById("prev_"+View_area);
	if(ImagePrev != null){
		preview.removeChild(ImagePrev);	
	}
	
	
	 if (ua.indexOf("MSIE") > -1) {


           try {
               var src = ""; // get file full path 
               
               if (targetObj.value.indexOf("\\fakepath\\") < 0) {
            	   src = targetObj.value;
               } else {
            	  
               }
               
               var ie_preview_error = document
                       .getElementById("ie_preview_error_" + View_area);

               if (ie_preview_error) {
                   preview.removeChild(ie_preview_error); 
               }
               var img = document.getElementById(View_area); 
               img.style.filter = "progid:DXImageTransform.Microsoft.AlphaImageLoader(src='" + src + "', sizingMethod=scale)"; 
           } catch (e) {
        	  
               if (!document.getElementById("ie_preview_error_" + View_area)) {
                   var info = document.createElement("<p>");
                   info.id = "ie_preview_error_" + previewId;
                   info.innerHTML = "a";
                   preview.insertBefore(info, null);
               }
           }
           
           
           
       } else {
		var files = targetObj.files;
		for ( var i = 0; i < files.length; i++) {
			var file = files[i];
			var imageType = /image.*/; 
			if (!file.type.match(imageType))
				continue;
			var prevImg = document.getElementById("prev_" + View_area); 
			if (prevImg) {
				preview.removeChild(prevImg);
			}
			var img = document.createElement("img"); 
			img.id = "prev_" + View_area;
			img.classList.add("obj");
			img.file = file;
			img.style.width = '100px'; 
			img.style.height = '100px';
			preview.appendChild(img);
			if (window.FileReader) { // FireFox, Chrome, Opera Ȯ��.
				var reader = new FileReader();
				reader.onloadend = (function(aImg) {
					return function(e) {
						aImg.src = e.target.result;
					};
				})(img);
				reader.readAsDataURL(file);
			} else { // safari is not supported FileReader
				//alert('not supported FileReader');
				if (!document.getElementById("sfr_preview_error_"
						+ View_area)) {
					var info = document.createElement("p");
					info.id = "sfr_preview_error_" + View_area;
					info.innerHTML = "not supported FileReader";
					preview.insertBefore(info, null);
				}
			}
		}
	}
}

function displayInfo(z){
	for(var i=1;i<7;i++){
		if(i==z){
			document.getElementById("tab0"+i).className = "here";
			document.getElementById("tab"+i).style.display = "block";		
		}else{
			document.getElementById("tab0"+i).className = "";
			document.getElementById("tab"+i).style.display = "none";
		}
	}
}

function UpdateInfo(){
	document.getElementById("UserInfomation").submit();
}

function RedundancyEmployee(num,userid){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/RedEmp.jsp",   
	    data: "num="+num + "&userid="+userid,
	    success:function(args){
	    	if(args > 0){
	    		alert("<%=Lanfunc.language(lan, 114)%>");
	    		companyid = 0;
	    	}else{
	    		alert("<%=Lanfunc.language(lan, 115)%>");
	    		companyid = 1;
	    	}
	    },   
	    error:function(e){  
	        alert(e.responseText);  
	    }  
	}); 
}

function RedundancyCard(num,userid){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/RedCard.jsp",   
	    data: "num="+num + "&userid="+userid,
	    success:function(args){
	    	if(args > 0){
	    		alert("<%=Lanfunc.language(lan, 116)%>");
	    		cardid = 0;
	    	}else{
	    		alert("<%=Lanfunc.language(lan, 117)%>");
	    		cardid = 1;
	    	}
	    },   
	    error:function(e){  
	        alert(e.responseText);  
	    }  
	}); 
}

function UserInfoSubmit(){
	/*if(cardid == 0){
		return false;
	}
	
	if(companyid == 0){
		return false;
	}
	*/
	UserInfomation.submit();
	
}

function UserDelete(){
	var del = confirm("<%=Lanfunc.language(lan, 103)%>")
	if(del){
		userDelete.submit();
	}
}

function deviceList(v){
	if(v!=0){
		$(".Loading").css("display","block");
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/DeviceList.jsp",   
		    data: "group=" + v,
		    success:function(args){   
		        $("#devicelist").html(args);   
				$(".Loading").css("display","none");   
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		}); 
	}else{
		
	}
}

function accessList(v){
	if(v!=0){
		$(".Loading").css("display","block");
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/AccessGroupList.jsp",   
		    data: "access=" + v,
		    success:function(args){   
		    	$("#option" + v).attr('disabled', true);
		    	$('#access_group').val($('#access_group').val() + v);
		    	$('#access_group_table > tbody:last-child').append(args);
		    	$(".Loading").css("display","none");   
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		}); 
	}else{
		
	}
}

function searchEvent(){
	var eventLog = document.getElementById("eventLog");
	eventLog.start.value = document.getElementById("startDate").value;
	eventLog.end.value = document.getElementById("endDate").value;
	eventLog.submit();
}


function allA_GroupInfoCheck(){
    $('.access_class').each(function(){
    	if($('#allcheck').prop('checked')){
			    $(this).prop('checked', true);
    	  }else{
    	        $(this).prop('checked', false);
    	 }
    });;
}

function AccessDelete(UserID){
    $('.access_class').each(function(){
    	if($(this).prop('checked'))
    	{	
    		var access = $(this).val();
    		var user_id = parseInt(UserID,10);
    		$(".Loading").css("display","block");
    		$.ajax({      
    		    type:"post",  
    		    url:"/TrustWinPro/action/ajax/DelAccessUser.jsp",   
    		    data: "access=" + access + "&id=" + user_id, 
    		    success:function(args){   
    		    	$("#tr" + access).remove();
    		    	$(".Loading").css("display","none");   
    		    },   
    		    error:function(e){  
    		        alert(e.responseText);  
    		    }  
    		}); 
    	}
    	
    });;

}

function AccessAdd(UserID){
    $('.access_class').each(function(){
    
    		var access = $(this).val();
    		var user_id = parseInt(UserID,10);
    		$(".Loading").css("display","block");
    		$.ajax({      
    		    type:"post",  
    		    url:"/TrustWinPro/action/ajax/AddAccessUser.jsp",   
    		    data: "access=" + access + "&id=" + user_id, 
    		    success:function(args){   
    		    	//$("#tr" + access).remove();
    		    	$(".Loading").css("display","none");   
    		    },   
    		    error:function(e){  
    		        alert(e.responseText);  
    		    }  
    		});
    		
    });;

}
</script>
<%
	Category[] catagory = null;


	
	catagory = Catefunc.CategoryDefind();
	
	
	int length = catagory.length;
	Category[] cata = new Category[length];	
	cata = Catefunc.SortCategoryOne(catagory);
	String realFolder = "";
	ServletContext scontext = getServletContext();
	realFolder = request.getContextPath() + "/upload/image/user/";
	realFolder = realFolder + rs.getString(37);
	


	Category[] leaf_catagory = null;
	//Catefunc.findleaf(catagory);
	
%>
<div id="UserInfo">
	<div class="basic">
		<form action="/TrustWinPro/action/page/UserInfoUpdate.jsp" name="UserInfomation" id="UserInfomation" method="post"  enctype="multipart/form-data" >
			<input type="hidden" name="userID" value="<%=LangUtil.Empty(rs.getString(4)) %>">
			
			<section class = "sectionji">
				<ul class = "ulji">
				</ul>
				<div class="picture">
									<div id='View_area' style='color: black; border: 0px solid black; dispaly: inline;float:left;'>
<%
	if(rs.getString(37)!=null){
%>
										<img src="<%=realFolder %>" alt="" style="width:200px;height:200px;" id="prev_View_area" />
<%		
	}
%>							

									<div>
										<div id="shadow" style="position:absolute;z-index:100;">
											<input type="file" name="saveFile" id="saveFile"  style="filter:alpha(opacity:0);z-index:2;width:30;opacity:0;position: absolute;left:-180px;" onchange="previewImage(this,'View_area');" value="" >
										</div>
										<img src="/TrustWinPro/action/image/interface/search.png"  border='0' align="absmiddle">
									</div>	
									</div>
									<p></p>				
				</div>
				<div class="Info">		
							<div class="block" style="margin-left:50rem;">
								<p><div class = "headerji">
								<%=Lanfunc.language(lan, 29)%> : 
								</div>		
								<input class="inputt" type="text" value="<%=LangUtil.Empty(rs.getString(4)) %>"  size="20rem" disabled>				
							</div>
							<div class="block" style="margin-left:50rem;">
								<p><div class = "headerji">
								<%=Lanfunc.language(lan, 26)%> : 
								</div>
								<input class = "inputt" type="text" name="firstName" value="<%=LangUtil.Empty(rs.getString(1)) %>"  size="30um">
							</div>
							<div class="block" style="margin-left:50rem;">
								<p><div class = "headerji">
								<%=Lanfunc.language(lan, 27)%> : 
								</div>
								<input class = "inputt" type="text" name="middleName" value="<%=LangUtil.Empty(rs.getString(2)) %>"  size="30um">
							</div>					
							<div class="block" style="margin-left:50rem;">
								<p><div class = "headerji">
								<%=Lanfunc.language(lan, 28)%> : 
								</div>
								<input class = "inputt" type="text" name="lastName" value="<%=LangUtil.Empty(rs.getString(3)) %>"  size="30um">
							</div>				
							<div class="block" style="margin-left:50rem;">
								<p><div class = "headerji">
								<%=Lanfunc.language(lan, 30)%> : 
								</div>
								<div class="main">
								<select name="userClass" class="mainselect" style="height:28px;">
								<option value="1" <%if(rs.getString(5)!=null){if(rs.getString(5).equals("1")){out.print("selected");}} %>><%=Lanfunc.language(lan, 170)%></option>
								<option value="128" <%if(rs.getString(5)!=null){if(rs.getString(5).equals("128")){out.print("selected");}}  %>><%=Lanfunc.language(lan, 171)%></option>
								</select>
								</div>
							</div>					
							<div class="block" style="margin-left:50rem;">
								<p><div class = "headerji">
								<%=Lanfunc.language(lan, 2)%> : 
								</div>
								<input class="inputt" type="text" name="ID" value="<%=LangUtil.Empty(rs.getString(6)) %>" size="30um">
							</div>				
							<div class="block" style="margin-left:50rem;">
								<p><div class = "headerji">
								<%=Lanfunc.language(lan, 5)%> : 
								</div>
								<input class="inputt" type="text" name="Password" value="<%=LangUtil.Empty(rs.getString(7)) %>" size="30um">
							</div>	
				</div>
			</section>
			
			
			<div class="tab">
				<ul id="globalnav">
					<li class="tab1">
						<a href="#a" onclick="displayInfo(1)" class="here" id="tab01"><%=Lanfunc.language(lan, 32)%></a>
					</li>
					<li class="tab2">
						<a href="#a" onclick="displayInfo(2)" id="tab02"><%=Lanfunc.language(lan, 33)%></a>
					</li>
					<li class="tab3">
						<a href="#a" onclick="displayInfo(3)" id="tab03" ><%=Lanfunc.language(lan, 34)%></a>
					</li>
					<li class="tab4" style="display:none;">
						<a href="#a" onclick="displayInfo(4)" id="tab04" ><%=Lanfunc.language(lan, 35)%></a>
					</li>
					<li class="tab5">
						<a href="#a" onclick="displayInfo(5)" id="tab05" ><%=Lanfunc.language(lan, 36)%></a>
					</li>
					<li class="tab6">
						<a href="#a" onclick="displayInfo(6)" id="tab06" ><%=Lanfunc.language(lan, 37)%></a>
					</li>
				</ul>
			</div>
			
			<div class="Official" id="tab1">
				<div class="InfoBox">
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 38)%></div>
						<div class="main"><input type="text" name="CompanyID" id="CompanyID" value="<%=LangUtil.Empty(rs.getString(8)) %>" size="40um"><a href="#content" onclick="RedundancyEmployee(document.getElementById('CompanyID').value,<%=LangUtil.Empty(LangUtil.Empty(rs.getString(6))) %>)"><img src="/TrustWinPro/action/image/interface/search.png" class="search"></a></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 39)%></div>
						<div >
						<select name="Department" class="mainselect">
<%

	int[] id_ary = new int[cata.length];
	int[] root_id_ary = new int[cata.length];
	
	for(int i=0;i < cata.length;i++){
		id_ary[i] = cata[i].getIdx();
		root_id_ary[i] = Catefunc.CataUpNum(cata[i].getIdx());
	}

	for(int i=0;i < cata.length;i++){
		boolean leaf = true;	
		for(int j = 0; j <cata.length; j++)
		{
			if(id_ary[i] == root_id_ary[j]){ 
				leaf = false;
				break;
				}
		}	
		
		if(leaf){
%>
							<option value = "<%=cata[i].getIdx()%>" <%=cata[i].getIdx() == rs.getInt(9) ? "selected" : "" %>><%=cata[i].getName() %></option>
<%
	
		}
	}
%>
						</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 40)%></div>
						<div class="main"><input type="text" name="Position" value="<%=LangUtil.Empty(rs.getString(10)) %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 41)%></div>
						<div class="main"><input type="text" name="TelOffice" value="<%=LangUtil.Empty(rs.getString(11)) %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 42)%></div>
						<div class="main">
							<input type="text" name="EngagedDay" readonly="readOnly" value="<%=LangUtil.Empty(rs.getString(12)) %>" size="40um" onclick="fnPopUpCalendar(EngagedDay,EngagedDay,'yyyy-mm-dd')">
						</div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 43) %></div>
						<div class="main"><input type="text" name="LatestPromoted" readonly="readOnly" value="<%=LangUtil.Empty(rs.getString(13)) %>" size="40um" onclick="fnPopUpCalendar(LatestPromoted,LatestPromoted,'yyyy-mm-dd')"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 44) %></div>
						<div class="main"><input type="text" name="RetiredDay" readonly="readOnly" value="<%=LangUtil.Empty(rs.getString(14)) %>" size="40um" onclick="fnPopUpCalendar(RetiredDay,RetiredDay,'yyyy-mm-dd')"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 45) %>1</div>
						<div class="main"><input type="text" name="License1" value="<%=LangUtil.Empty(rs.getString(15)) %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 45) %>2</div>
						<div class="main"><input type="text" name="License2" value="<%=LangUtil.Empty(rs.getString(16)) %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 45) %>3</div>
						<div class="main"><input type="text" name="License3" value="<%=LangUtil.Empty(rs.getString(17)) %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 46) %></div>
						<div class="main"><input type="text" name="HourlyWage" value="<%=LangUtil.Empty(rs.getString(18)) %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 47) %></div>
						<div class="main"><input type="text" name="Email" value="<%=LangUtil.Empty(rs.getString(19)) %>" size="40um"></div>
					</div>
				</div>
			</div>
			<div class="Private" id="tab2">
				<div class="InfoBox">
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 48) %></div>
						<div >
							<select name="Sex" class="mainselect">
								<option value = "0" <%if(rs.getString(20)!=null){if(!rs.getString(20).equals("")){if(Integer.parseInt(rs.getString(20)) == 0){out.println("selected");}}} %>><%=Lanfunc.language(lan, 172) %></option>
								<option value = "1" <%if(rs.getString(20)!=null){if(!rs.getString(20).equals("")){if(Integer.parseInt(rs.getString(20)) == 1){out.println("selected");}}} %>><%=Lanfunc.language(lan, 173) %></option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 49) %></div>
						<div >
							<select name="Married" class="mainselect">
								<option value = "0" <%if(rs.getString(21)!=null){if(!rs.getString(21).equals("")){if(Integer.parseInt(rs.getString(21)) == 0){out.println("selected");}}} %>><%=Lanfunc.language(lan, 174) %></option>
								<option value = "1" <%if(rs.getString(21)!=null){if(!rs.getString(21).equals("")){if(Integer.parseInt(rs.getString(21)) == 1){out.println("selected");}}} %>><%=Lanfunc.language(lan, 175) %></option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 50) %></div>
						<div class="main"><input type="text" name="ResidentRegNo" value="<%=LangUtil.Empty(rs.getString(22)) %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 51) %></div>
						<div class="main"><input type="text" name="TelHome" value="<%=LangUtil.Empty(rs.getString(23)) %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 52) %></div>
						<div class="main"><input type="text" name="MobilePhone" value="<%=LangUtil.Empty(rs.getString(24)) %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 53) %></div>
						<div class="main"><input type="text" name="CarName" value="<%=LangUtil.Empty(rs.getString(25)) %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 54) %></div>
						<div class="main"><input type="text" name="Zipcode" value="<%=LangUtil.Empty(rs.getString(26)) %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 3)  %></div>
						<div class="main"><input type="text" name="Address" value="<%=LangUtil.Empty(rs.getString(27)) %>" size="40um"></div>
					</div>
				</div>
			</div>
			<div class="Card" id="tab3">
				<div class="InfoBox">
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 55) %></div>
						<div class="main"><input type="text" name="CardID" id="CardID" value="<%=LangUtil.Empty(rs.getString(28)) %>" size="40um"><a href="#content" onclick="RedundancyCard(document.getElementById('CardID').value,<%=LangUtil.Empty(LangUtil.Empty(rs.getString(6))) %>)"><img src="/TrustWinPro/action/image/interface/search.png" class="search"></a></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 56) %></div>
						<div >
							<select name="CardType" class="mainselect">
								<option value = "0" <%if(rs.getString(29)!=null){if(!rs.getString(29).equals("")){if(Integer.parseInt(rs.getString(29)) == 0){out.println("selected");}}} %>>Standard 26 Bit</option>
								<option value = "1" <%if(rs.getString(29)!=null){if(!rs.getString(29).equals("")){if(Integer.parseInt(rs.getString(29)) == 1){out.println("selected");}}} %>>Binary(Mifare 34 Bit)</option>
								<option value = "2" <%if(rs.getString(29)!=null){if(!rs.getString(29).equals("")){if(Integer.parseInt(rs.getString(29)) == 2){out.println("selected");}}} %>>Keico 37bit</option>
								<option value = "3" <%if(rs.getString(29)!=null){if(!rs.getString(29).equals("")){if(Integer.parseInt(rs.getString(29)) == 3){out.println("selected");}}} %>>SSMT 37bit</option>
								<option value = "4" <%if(rs.getString(29)!=null){if(!rs.getString(29).equals("")){if(Integer.parseInt(rs.getString(29)) == 4){out.println("selected");}}} %>>Standard 36bit</option>
								<option value = "5" <%if(rs.getString(29)!=null){if(!rs.getString(29).equals("")){if(Integer.parseInt(rs.getString(29)) == 5){out.println("selected");}}} %>>Corporation-1000 35bit</option>
								<option value = "6" <%if(rs.getString(29)!=null){if(!rs.getString(29).equals("")){if(Integer.parseInt(rs.getString(29)) == 6){out.println("selected");}}} %>>PCSC 37bit</option>
								<option value = "7" <%if(rs.getString(29)!=null){if(!rs.getString(29).equals("")){if(Integer.parseInt(rs.getString(29)) == 7){out.println("selected");}}} %>>Binary(Mifare 32 Bit)</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 57) %></div>
						<div class="main"><input type="text" name="FacilityCode" value="<%=LangUtil.Empty(rs.getString(30)) %>" size="40um"></div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 58) %></div>
						<div >
							<select name="CardAttribute" class="mainselect">
								<option value = "0" <%if(rs.getString(31)!=null){if(!rs.getString(29).equals("")){if(Integer.parseInt(rs.getString(31)) == 0){out.println("selected");}}} %>>Normal</option>
								<option value = "1" <%if(rs.getString(31)!=null){if(!rs.getString(29).equals("")){if(Integer.parseInt(rs.getString(31)) == 1){out.println("selected");}}} %>>Handicapped</option>
								<option value = "2" <%if(rs.getString(31)!=null){if(!rs.getString(29).equals("")){if(Integer.parseInt(rs.getString(31)) == 2){out.println("selected");}}} %>>Lost Card</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 59) %>1</div>
						<div >
							<select name="TimeZoneNo1" class="mainselect">
								<option value = "0" >All</option>
<%
	TimeZone[] zones = Timfunc.TimeMenu();
	AccessGroup[] access = Accfunc.AccessGroupMenu();
	
	for(int i = 0;zones.length>i;i++){	
		if((zones[i].getTimeZoneNo()).equals(rs.getString(32))){

%>
		<option selected value = "<%=zones[i].getTimeZoneNo() %>" ><%=zones[i].getTimeZoneName() %></option>
<%
		}else{
%>
		<option value = "<%=zones[i].getTimeZoneNo() %>" ><%=zones[i].getTimeZoneName() %></option>
<%
		}	
	}

%>							
								<option value = "257" >None Time</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 59) %>2</div>
						<div >
							<select name="TimeZoneNo2" class="mainselect">
								<option value = "0" >All</option>
<%
	for(int i = 0;zones.length>i;i++){	
		if((zones[i].getTimeZoneNo()).equals(rs.getString(33))){

%>
	<option selected value = "<%=zones[i].getTimeZoneNo() %>" ><%=zones[i].getTimeZoneName() %></option>
<%
	}else{
%>
	<option value = "<%=zones[i].getTimeZoneNo() %>" ><%=zones[i].getTimeZoneName() %></option>
<%
	}	
}

%>			
								<option value = "257" >None Time</option>						
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 60) %></div>
						<div >
							<select name="UserMode" class="mainselect">
								<option value = "0" <%if(rs.getString(34)!=null){if(!rs.getString(34).equals("")){if(Integer.parseInt(rs.getString(34)) == 0){out.println("selected");}}} %>>Normal User</option>
								<option value = "1" <%if(rs.getString(34)!=null){if(!rs.getString(34).equals("")){if(Integer.parseInt(rs.getString(34)) == 1){out.println("selected");}}} %>>AnyOne(ID or Card) User</option>
								<option value = "2" <%if(rs.getString(34)!=null){if(!rs.getString(34).equals("")){if(Integer.parseInt(rs.getString(34)) == 2){out.println("selected");}}} %>>Black List</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 61) %></div>
						<div >
							<select name="ReAccessLimitTime" class="mainselect">
								<option value = "0" >None</option>
<%
	for(int i=1;i<128;i++){
%>
								<option value = "<%=i %>" <%if(rs.getString(39)!=null){if(rs.getString(39).equals(Integer.toString(i))){out.print("selected");}} %>><%=i%>Min</option>
<%
	}
%>								
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 62) %></div>
						<div >
							<select name="UseSubSensor" class="mainselect">
								<option value = "0" <%if(rs.getString(35)!=null){if(!rs.getString(35).equals("")){if(Integer.parseInt(rs.getString(35)) == 0){out.println("selected");}}} %>>No</option>
								<option value = "1" <%if(rs.getString(35)!=null){if(!rs.getString(35).equals("")){if(Integer.parseInt(rs.getString(35)) == 1){out.println("selected");}}} %>>YES</option>
							</select>
						</div>
					</div>
					<div class="block">
						<div class="header"><%=Lanfunc.language(lan, 63) %></div>
						<div >
							<select name="UseDuressFinger" class="mainselect">
								<option value = "0" <%if(rs.getString(36)!=null){if(!rs.getString(36).equals("")){if(Integer.parseInt(rs.getString(36)) == 0){out.println("selected");}}} %>>No</option>
								<option value = "1" <%if(rs.getString(36)!=null){if(!rs.getString(36).equals("")){if(Integer.parseInt(rs.getString(36)) == 1){out.println("selected");}}} %>>FingerPrint1</option>
								<option value = "2" <%if(rs.getString(36)!=null){if(!rs.getString(36).equals("")){if(Integer.parseInt(rs.getString(36)) == 2){out.println("selected");}}} %>>FingerPrint2</option>
							</select>
						</div>
					</div>
				</div>
			</div>
			<div class="Device" id="tab4" style="display:none;">
				
			</div>
<%
	Event[] eventG = null;
	
	String start = null;
	String end = null;
	
	if(request.getParameter("start") == null){
		start = "";
	}else{
		start = (String)request.getParameter("start");
	}
	
	if(request.getParameter("end") == null){
		end = "";
	}else{
		end = (String)request.getParameter("end");
	}
	
	
	start = start.replace(" ", "");
	end = end.replace(" ", "");
	eventG = Evtfunc.EventDefind(start, end,ID);
%>
			<div class="Event" id="tab5">
				<table>
					<colgroup>
						<col width="20%" align="center" >
						<col width="80%">
					</colgroup>
					<tr >
						<td class="main" colspan="2">
						
							<p style="margin-left:2rem;">
							<%=Lanfunc.language(lan, 71).trim() %> : <input type="text" name="start" value="<%=start%>" id="startDate"  readonly="readOnly" onclick="fnPopUpCalendar(startDate,startDate,'yyyy-mm-dd')"  class="inputt"  /> 
							~ 
							<input type="text" name="end" value="<%=end%>" id="endDate"  readonly="readOnly" onclick="fnPopUpCalendar(endDate,endDate,'yyyy-mm-dd')"  class="inputt"  /> 
							<a href="#search" onclick="searchEvent(); " ><img src="/TrustWinPro/action/image/interface/search.png"></a>
							</p>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<div id="devicelist">
								<table border=1 cellspacing="0"  class="titleEx1">
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="14%">
										<col width="10%">
										<col width="12%">
										<col width="12%">
										<col width="10%">
									</colgroup>
									<tr>
										<th><%=Lanfunc.language(lan, 72) %></th>
										<th><%=Lanfunc.language(lan, 73) %></th>
										<th><%=Lanfunc.language(lan, 74) %></th>
										<th><%=Lanfunc.language(lan, 75) %></th>
										<th><%=Lanfunc.language(lan, 76) %></th>
										<th><%=Lanfunc.language(lan, 77) %></th>
										<th><%=Lanfunc.language(lan, 78) %></th>
										<th><%=Lanfunc.language(lan, 79) %></th>
										<th><%=Lanfunc.language(lan, 80) %></th>
									</tr>
								</table>
								<table class="ex1" cellspacing="0" >
									<colgroup>
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="10%">
										<col width="14%">
										<col width="10%">
										<col width="12%">
										<col width="12%">
										<col width="10%">
									</colgroup>
									<tbody>

<%
		for(int i=0;i < eventG.length;i++){
				out.println("<tr>");
				out.println("<td>" + eventG[i].getEventType() + "</td>");
				out.println("<td>" + eventG[i].getEventDate() + "</td>");
				out.println("<td>" + eventG[i].getEventTime() + "</td>");
				out.println("<td>" + eventG[i].getEventPlace() + "</td>");
				out.println("<td>" + eventG[i].getEventName() + "</td>");
				out.println("<td>" + eventG[i].getEventUserid() + "</td>");
				out.println("<td>" + eventG[i].getEventUserName() + "</td>");
				out.println("<td>" + eventG[i].getEventDoorState() + "</td>");
				out.println("<td>" + eventG[i].getEventCompanyId() + "</td>");
				out.println("</tr>");
			}
%>
									</tbody>
								</table>
<%
		
%>
							</div>
						</td>
					</tr>
				</table>
			</div>
			<div class="AccessControl" id="tab6">
			<table>
					<colgroup>
						<col width="20%" align="center" >
						<col width="80%">
					</colgroup>
					<tr class="block" >					
						<td class="header">
						<p style="margin-left:3rem;"><%=Lanfunc.language(lan, 133) %></p></td>
						<td class="main">
							<select name="Device" onchange="accessList(this.value);" onload="accessList(this.value);" style = "height:28px">
								<option value = "0"  >-- <%=Lanfunc.language(lan, 65) %> --</option>
<%

	AccessUser[] accessUser2 = Accfunc.SelAccessUserId(Integer.parseInt(ID));
	int[] check_access_group = new int[accessUser2.length];
	for(int i=0;i<accessUser2.length;i++)
		check_access_group[i] = accessUser2[i].getAccess();
	
	AccessGroup[] accessGroup2 = null;
	accessGroup2 = Accfunc.AccessGroupMenu(); 
	int lengthA = accessGroup2.length;
	AccessGroup[] acc = new AccessGroup[lengthA];	

	
	for(int i=0;i <lengthA; i++){
		int temp_flag =0;
		for(int tt=0;tt<accessUser2.length;tt++)
		{
			if(check_access_group[tt] == accessGroup2[i].getIdx()){
%>
				<option disabled value = "<%=accessGroup2[i].getIdx()%>" id="option<%=accessGroup2[i].getIdx()%>" <%=accessGroup2[i].getIdx() == rs.getInt(38) ? "selected" : "" %>><%=accessGroup2[i].getName() %></option>
<%				
				temp_flag=1;
				continue;
			}
		}
		if(temp_flag==1) continue;
%>
		<option value = "<%=accessGroup2[i].getIdx()%>" id="option<%=accessGroup2[i].getIdx()%>" <%=accessGroup2[i].getIdx() == rs.getInt(38) ? "selected" : "" %>><%=accessGroup2[i].getName() %></option>
<%
	}
%>
							</select>
						</td>
					</tr>
				</table>
				
				<table>
					<colgroup>
						<col width="20%" align="center" >
						<col width="80%">
					</colgroup>
					<tr>
						<td colspan="2">
							<div id="devicelist">
								<table border=1 cellspacing="0"  class="titleEx1">
									<colgroup>
										<col width="10%">
										<col width="10%">
									</colgroup>
									<tr>
										<th><%=Lanfunc.language(lan, 85)%><input type="checkbox" id="allcheck" onclick="allA_GroupInfoCheck()"></th>
										<th><%=Lanfunc.language(lan, 81) %></th>
										<th><%=Lanfunc.language(lan, 82) %></th>
									</tr>
								</table>
								<table class="ex1" cellspacing="0" id="access_group_table">
									<colgroup>
										<col width="10%">
										<col width="10%">
									</colgroup>
									<tbody >

<%
		AccessUser[] accessUser = Accfunc.SelAccessUserId(Integer.parseInt(ID));
		for(int j=0;j<accessUser.length;j++){
			AccessGroup accessGroup = Accfunc.SelAccessGroup(accessUser[j].getAccess());
			out.println("<tr id='tr"+ accessGroup.getIdx() +"'>");

			out.println("<td><input class='access_class' type='checkbox' name='AG_check' value='"+accessGroup.getIdx()+"'></td>");

			
			out.println("<td>" + accessGroup.getName() + "</td>");
			out.println("<td>");
			AccessDevice[] ad = Accfunc.SelAccessDevice(accessGroup.getIdx());
			for(int k=0;k<ad.length;k++){
				Device device = Devfunc.selDevice(Integer.parseInt(ad[k].getDevice()));
				out.print("<p style='margin:0;padding:0;'>"+device.getControllerName()+"</p>");
			}
			out.println("</td>");
			out.println("</tr>");
		}
%>
									</tbody>
								</table>
							</div>
						</td>
					</tr>
				</table>
				
				<div class="buttom"  align="right">
					<div class="image">
						<a href="#" onclick="AccessAdd(<%= Integer.parseInt(ID)%>);"><img src="/TrustWinPro/action/image/interface/submit.png"></a>
						<a href="#" onclick="AccessDelete(<%= Integer.parseInt(ID)%>);""><img src="/TrustWinPro/action/image/interface/delete.png"></a>
					</div>
				</div>
			</div>
			
			<div class="buttonBox">
				<div class="bottom" id="web-buttons-idrmij3">
					<a href="#" title="Enroll" onclick="Recive('S,U,R,1,<%=ID%>,E');"><%=Lanfunc.language(lan, 184)%></a>
					<a href="#" title="Delete" onclick="Delete('S,U,D,1,<%=ID%>,E');"><%=Lanfunc.language(lan, 88)%></a>
					<a href="#" title="Recive" onclick="Enroll('S,U,E,1,<%=ID%>,E');"><%=Lanfunc.language(lan, 183)%></a>
				</div>
				<div class="InfoButtom">
					<a href="#UserInfo" onclick="UserInfoSubmit();"><img src="/TrustWinPro/action/image/interface/submit.png"></a>
					<a href="#UserInfo" onclick="UserDelete();" ><img src="/TrustWinPro/action/image/interface/delete.png"></a>
				</div>
			</div>
		</form>
	</div>
</div>
<form name="userDelete" id="userDelete" method="post" action="page/UserInfoDelete.jsp" >
	<input type="hidden" name="id" value="<%=rs.getString(6) %>" />
</form>
<form action="/TrustWinPro/action/index.jsp" name="eventLog" id="eventLog" method="post">
	<input type="hidden" value="User" name="left" />
	<input type="hidden" value="UserInfo" name="content" />
	<input type="hidden" value="<%=ID %>" name="userID" />
	<input type="hidden" value="" name="start" />
	<input type="hidden" value="" name="end" />
	<input type="hidden" value="1" name="eventValue" />
	<input type="hidden"  id="access_group" value="" name="access_group" />
</form>
<%
			}
			rs.close();
			pstmt.close();
			conn.close();
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
%>
<script type="text/javascript">
<%
if(request.getParameter("eventValue")!=null){
	if(request.getParameter("eventValue").equals("1")){
%>
		displayInfo(5);
<%
	}
}
%>
$(".Loading").css("display","none");
</script>