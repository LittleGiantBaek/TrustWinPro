<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>

<%
	String SDate = (String)request.getParameter("searchStartDate")==null?"":request.getParameter("searchStartDate");
	String EDate = (String)request.getParameter("searchEndDate")==null?"":request.getParameter("searchEndDate");
	String SHour = (String)request.getParameter("searchStartHour")==null?"":request.getParameter("searchStartHour");
	String SMin = (String)request.getParameter("searchStartMinute")==null?"":request.getParameter("searchStartMinute");
	String SSec = (String)request.getParameter("searchStartSec")==null?"":request.getParameter("searchStartSec");
	String EHour = (String)request.getParameter("searchEndHour")==null?"":request.getParameter("searchEndHour");
	String EMin = (String)request.getParameter("searchEndMinute")==null?"":request.getParameter("searchEndMinute");
	String ESec = (String)request.getParameter("searchEndSec")==null?"":request.getParameter("searchEndSec");
	String Name = (String)request.getParameter("searchName");
	String User = (String)request.getParameter("searchUser");
	String Month = (String)request.getParameter("month");
	
	String Num = "40";
	LanguageFunc Lanfunc = new LanguageFunc();
	EventFunc Evtfunc = new EventFunc();
	
	if(request.getParameter("top")!=null){
		if(!request.getParameter("top").equals("")){
			Num = (String)request.getParameter("top");
		}
	}
	String lan = (String)session.getAttribute("nation");
	
	String STime = "";
	String ETime = "";
	
	if(SHour == null || SMin == null || SSec == null || EHour == null || EMin == null || ESec == null){
		SHour = "";
		SMin = "";
		SSec = "";
		EHour = "";
		EMin = "";
		ESec = "";
	}else{
		if((!SHour.equals("")&&!SHour.equals("null"))||(!SMin.equals("")&&!SMin.equals("null"))||(!SSec.equals("")&&!SSec.equals("null"))||(!EHour.equals("")&&!EHour.equals("null"))||(!EMin.equals("")&&!EMin.equals("null"))||(!ESec.equals("")&&!ESec.equals("null"))){
	if((!SHour.equals("0")&&!EHour.equals("0"))){
		if(Integer.parseInt(SHour)<10){
	SHour = "0" + SHour;
		}
		if(Integer.parseInt(SMin)<10){
	SMin = "0" + SMin;
		}
		if(Integer.parseInt(SSec)<10){
	SSec = "0" + SSec;
		}
		if(Integer.parseInt(EHour)<10){
	EHour = "0" + EHour;
		}
		if(Integer.parseInt(EMin)<10){
	EMin = "0" + EMin;
		}
		if(Integer.parseInt(ESec)<10){
	ESec = "0" + ESec;
		}
		STime = SHour+":"+SMin+":"+SSec;
		ETime = EHour+":"+EMin+":"+ESec;
	}
		}
	}
	
	
	
%>

<%-- <%
request.setCharacterEncoding("utf-8");
	Connection conn = null;
	String SDate = (String)request.getParameter("searchStartDate");
	String EDate = (String)request.getParameter("searchEndDate");
	String SHour = (String)request.getParameter("searchStartHour");
	String SMin = (String)request.getParameter("searchStartMinute");
	String SSec = (String)request.getParameter("searchStartSec");
	String EHour = (String)request.getParameter("searchEndHour");
	String EMin = (String)request.getParameter("searchEndMinute");
	String ESec = (String)request.getParameter("searchEndSec");
	String Name = (String)request.getParameter("searchName");
	String User = (String)request.getParameter("searchUser");
	String Month = (String)request.getParameter("month");
	String STime = "";
	String ETime = "";
	
	CategoryFunc func = new CategoryFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	EventFunc Eventfunc = new EventFunc();
	
	
	
	if(Month != null){
		if(Integer.parseInt(Month) > 9){
	
		}else{
	Month = "0" + Month;
		}
	}
	String Year = (String)request.getParameter("year");
	String where = " where 1=1 ";
	
	if(SDate == null || EDate ==null){
		SDate = "";
		EDate = "";
	}else{
		if((!SDate.equals("")&&!SDate.equals("null"))||(!EDate.equals("")&&!EDate.equals("null"))){
	where = where + " and EventDate between '" + SDate + "' and '"+EDate+"'";
		}
	} 
	
	if(SHour == null || SMin == null || SSec == null || EHour == null || EMin == null || ESec == null){
		SHour = "0";
		SMin = "0";
		SSec = "0";
		EHour = "0";
		EMin = "0";
		ESec = "0";
	}else{
		if((!SHour.equals("")&&!SHour.equals("null"))||(!SMin.equals("")&&!SMin.equals("null"))||(!SSec.equals("")&&!SSec.equals("null"))||(!EHour.equals("")&&!EHour.equals("null"))||(!EMin.equals("")&&!EMin.equals("null"))||(!ESec.equals("")&&!ESec.equals("null"))){
	if(Integer.parseInt(SHour)<10){
		SHour = "0" + SHour;
	}
	if(Integer.parseInt(SMin)<10){
		SMin = "0" + SMin;
	}
	if(Integer.parseInt(SSec)<10){
		SSec = "0" + SSec;
	}
	if(Integer.parseInt(EHour)<10){
		EHour = "0" + EHour;
	}
	if(Integer.parseInt(EMin)<10){
		EMin = "0" + EMin;
	}
	if(Integer.parseInt(ESec)<10){
		ESec = "0" + ESec;
	}
	STime = SHour + ":"+SMin+":"+SSec;
	ETime = EHour + ":"+EMin+":"+ESec;
	where = where + " and EventTime between '" + SHour + ":"+SMin+":"+SSec+"' and '" + EHour + ":"+EMin+":"+ESec+"'";
		}
	}
	
	if(Name == null){
		Name = "";
	}else{
		if(!Name.equals("")){
	where = where + " and EventName = '" + Name + "'";
		}
	}
	
	if(User == null){
		User = "";		
	}else{
		if(!User.equals("")){
	where = where + " and EventUserName = '" + User + "'";
		}
	}
	
	if(Month==null||Year==null){
		
	}else{
		if(!Month.equals("")&&!Year.equals("")){
	where = where + " and EventDate like '" + Year + "-" + Month + "-%' ";
		}
	}
	
	 
	int maxPageNum=-1;                 // 전체 페이지의 수.
	int limitPage,pagerSize = 10;              // limitPage : 마지막 페이지 넘버. pageSize : 페이지 넘버가 보여지는 간격.
	int currentPage = 0;
	if(request.getAttribute("currentPage")!=null){
		currentPage = Integer.parseInt((String)request.getAttribute("currentPage")); // 현재 페이지 
	}
	
	int top = 0;
	
	if(request.getParameter("Num")==null){
		top = 40;
	}else{
	 	top = Integer.parseInt(request.getParameter("Num"));
	}
		
	String sql = "select top "+top+" EventType,EventDate,EventTime,EventPlace,EventName,EventUserID,EventUserName,EventDoorState,EventCompanyID from dbo.History  ";
	sql = sql + where;
	sql = sql +	" order by EventDate desc; ";
		try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		
		ResultSet rs = pstmt.executeQuery(sql);
		
		
		Event[] devices = Eventfunc.searchEvent(SDate, EDate, STime, ETime, Name, User, Integer.toString(top));
		String lan = (String)session.getAttribute("nation");
		
		String[] dev = {"1","2", "3", "4", "5", "6", "7","8", "9"};
		EventFunc EFunc = new EventFunc();
		String device = EFunc.eventVal();
		String[] devicess = device.split(",");
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
				for(int j=0;j<devicess.length;j++){
					if(dev[0].equals(devicess[j])){
						 statuss1 = "checked";
					} else if(dev[1].equals(devicess[j])) {
						 statuss2 = "checked";
					} else if(dev[2].equals(devicess[j])) {
						 statuss3 = "checked";
					} else if(dev[3].equals(devicess[j])) {
						 statuss4 = "checked";
					} else if(dev[4].equals(devicess[j])) {
						 statuss5 = "checked";
					} else if(dev[5].equals(devicess[j])) {
						 statuss6 = "checked";
					} else if(dev[6].equals(devicess[j])) {
						 statuss7 = "checked";
					} else if(dev[7].equals(devicess[j])) {
						 statuss8 = "checked";
					} else if(dev[8].equals(devicess[j])) {
						 statuss9 = "checked";
					}
				}
			}
			
			
		
		
%> --%>
<script type="text/javascript">

$(window).load(function() {
	$(".notcheck").css("display", "none");
	refresh();
	//alert("hello")
	//drawDevice();
}); 

function refresh(){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/LogC.jsp",   
	    data: "num=<%=Num%>&searchStartDate=<%=SDate%>&searchEndDate=<%=EDate%>&searchStartHour=<%=SHour%>&searchStartMinute=<%=SMin%>&searchStartSec=<%=SSec%>&searchEndHour=<%=EHour%>&searchEndMinute=<%=EMin%>&searchEndSec=<%=ESec%>&searchName=<%=Name%>&searchUser=<%=User%>&month=<%=Month%>",
	    success:function(args){
	    	$(".tablebor").html(args);
	        //$("#logdata").html(args);      
	    },   
	    error:function(e){  
	        //alert("refresh" + e.responseText);  
	    }  
	});  
}

function drawEvent()
{
     var data = null;
     var table_data = null;
     $.ajax({
         url:'/TrustWinPro/action/ajax/eventStatusProc.jsp',
         data: 'idx=',
         cache: false,
         success: function(res) {
        	table_data = eval("(" + res + ")");
        	$(".tablebor").html(args);
         }
    });
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

function eventSort(){
	document.getElementById("postitEventSort").style.display = "block";
	document.getElementById("postitEventSort").style.top = "200px";
}

function eventExcel(){
	document.getElementById("postitEventExcel").style.display = "block";
	document.getElementById("postitEventExcel").style.top = "200px";
}
//refresh();
//$(document).attr("timer",setInterval(refresh,1000)); 
</script>
<div id="userdata">
	<section class="sectionji">
		<ul class="ulji"></ul>
		<div>
				<form action="/TrustWinPro/action/index.jsp" name="allEvent" id="allEvent" method="post">
					<input type="hidden" value="realLog" name="logtype" />
					<input type="hidden" value="Log" name="content" />
					<input type="hidden" value="<%=STime %>" name="STime" />
					<input type="hidden" value="<%=ETime %>" name="ETime" />
					<input type="hidden" value="<%=SDate %>" name="SDate" />
					<input type="hidden" value="<%=EDate %>" name="EDate" />
					
					<p><div class = "headerji">
					<%=Lanfunc.language(lan, 71)%> : 
					</div>
					<input type="text" class="inputt" name="searchStartDate" id="searchStartDate" readonly="readOnly" value="<%=LangUtil.Empty(SDate)%>" readonly="readOnly" onclick="fnPopUpCalendar(searchStartDate,searchStartDate,'yyyy-mm-dd')" /> 
					~ <input type="text" class="inputt" name="searchEndDate" id="searchEndDate" readonly="readOnly" value="<%=LangUtil.Empty(EDate)%>" readonly="readOnly" onclick="fnPopUpCalendar(searchEndDate,searchEndDate,'yyyy-mm-dd')" />
					</p>
					
					
					<p><div class = "headerji">
					<%=Lanfunc.language(lan, 106)%> : 
					</div>
					<select name="searchStartHour"  class="hourselect" id="searchStartHour">
						<option value="0" >0</option>
		<%
			for(int i=1;i<25;i++){
		%>
						<option value="<%=i%>" <%=SHour.equals(Integer.toString(i)) ?"selected":""%> ><%=i%></option>
		<%
			}
		%>				
					</select>
					<select name="searchStartMinute" class="hourselect"  id="searchStartMinute">
						<option value="0" >00</option>
		<%
			for(int i=1;i<61;i++){
		%>
						<option value="<%=i%>" <%=SMin.equals(Integer.toString(i)) ?"selected":""%> ><%=i%></option>
		<%
			}
		%>				
					</select>
					
					<select name="searchStartSec" class="hourselect"  id="searchStartSec">
						<option value="0" >00</option>
		<%
			for(int i=1;i<61;i++){
		%>
						<option value="<%=i%>" <%=SSec.equals(Integer.toString(i)) ?"selected":""%> ><%=i%></option>
		<%
			}
		%>				
					</select>
					~
					<select name="searchEndHour" class="hourselect"  id="searchEndHour">
						<option value="0" >0</option>
		<%
			for(int i=1;i<25;i++){
		%>
						<option value="<%=i%>" <%=EHour.equals(Integer.toString(i)) ?"selected":""%> ><%=i%></option>
		<%
			}
		%>				
					</select>
					
					<select name="searchEndMinute" class="hourselect"  id="searchEndMinute">
						<option value="0" >00</option>
		<%
			for(int i=1;i<61;i++){
		%>
						<option value="<%=i%>" <%=EMin.equals(Integer.toString(i)) ?"selected":""%> ><%=i%></option>
		<%
			}
		%>				
					</select>
					
					<select name="searchEndSec" class="hourselect"  id="searchEndSec">
						<option value="0" >00</option>
		<%
			for(int i=1;i<61;i++){
		%>
						<option value="<%=i%>" <%=ESec.equals(Integer.toString(i)) ?"selected":""%> ><%=i%></option>
		<%
			}
		%>				
					</select>
					</p>					
					
					<p><div class = "headerji">
					<%=Lanfunc.language(lan, 81)%> : 
					</div>
					<input type="text" class="inputt" name="searchName" value="<%=LangUtil.Empty(Name)%>" /> 
					</p>
					
					<p><div class = "headerji">
					<%=Lanfunc.language(lan, 108)%> :  
					</div>
					<input type="text" class="inputt" name="searchUser" value="<%=LangUtil.Empty(User)%>" />
					<input name="content" class="inputt" type="hidden" value="Log" />
					</p>					
					
					<p><div class = "headerji">
					<%=Lanfunc.language(lan, 91)%> : 	
					</div>
					<input name="Num" class="inputt" type="text" value="<%=Num%>" size="20" />
					<input type="submit" name="submit" value="<%=Lanfunc.language(lan, 182)%>" class="ct-btn white" />
					<div style="float:right; margin-right:20px">
						<!-- <a href="#a" onclick="UserPrint();"><img src="/TrustWinPro/action/image/interface/printImage.jpg" alt="" ></a> -->
						<a href="#" onclick="openColor();" ><img src="/TrustWinPro/action/image/interface/option.png" alt="" height="24" width="24" /></a>
					</div>
					</p>
				</form>
		</div>
	</section>
	
	<div class="colorOption" id="colorOption">
	<form action="/TrustWinPro/action/index.jsp" name="colorO" id="colorO" method="post">
		<table cellspacing="0"  class="titleEx1">
			<colgroup>
				<col width="20%">
				<col width="40%">
				<col width="40%">
			</colgroup>
			<tr>
				<th>Type</th>
				<th>Display</th>
				<th>Color</th>
			</tr>
		</table>
		<table cellspacing="0"  class="ex1">
			<colgroup>
				<col width="20%">
				<col width="40%">
				<col width="40%">
			</colgroup>
			<tbody>
<%
	EventOption[] eo = Evtfunc.selOption();
	for(int i=0; i < eo.length;i++){
%>
			<tr>
				<td><%=eo[i].getType() %></td>
				<td><input type="checkbox" value="<%=eo[i].getIdx()%>" name="check" <%=eo[i].getDisplay().equals("1")?"checked":"" %>></td>
				<td><input class="color" name="colorName" value="<%=eo[i].getColor() %>"></td>
			</tr>
<%
	}
%>
			</tbody>
		</table>
		<div class="button" id="web-buttons-idrmij3">
			<a href="#"  onclick="closeColor();"><%=Lanfunc.language(lan, 185)%></a>
			<a href="#"  onclick="optionSubmit();"><%=Lanfunc.language(lan, 92)%></a>
		</div>
	</form>
	</div>
<%-- 		<section class="sectionji">
		<ul class="ulji"></ul>
		<div>
			<form action="/TrustWinPro/action/index.jsp" name="searchLog" method="post">
				<input type="hidden" value="searchLog" name="logtype" />
				<input type="hidden" value="Log" name="content" />
				<input type="hidden" value="" name="EventType" />
				<input type="hidden" value="" name="EventPlace" />
				<input type="hidden" value="" name="EventName" />
				<input type="hidden" value="" name="EventDoorState" />
				<input type="hidden" value="" name="EventCompanyID" />
				<input type="hidden" value="" name="EventDate" />
				<input type="hidden" value="" name="EventTime" />
				<input type="hidden" value="" name="searchEndTime" />
				<input type="hidden" value="<%=STime %>" name="STime" />
				<input type="hidden" value="<%=ETime %>" name="ETime" />
				<input type="hidden" value="<%=SDate %>" name="SDate" />
				<input type="hidden" value="<%=EDate %>" name="EDate" />
				
				
				<p><div class = "headerji">
				<%=Lanfunc.language(lan, 71)%> : 
				</div>
				<input type="text" class="inputt" name="searchStartDate" id="searchStartDate" readonly="readOnly" value="<%=LangUtil.Empty(SDate)%>" readonly="readOnly" onclick="fnPopUpCalendar(searchStartDate,searchStartDate,'yyyy-mm-dd')" /> 
				~ <input type="text" class="inputt"  name="searchEndDate" id="searchEndDate" readonly="readOnly" value="<%=LangUtil.Empty(EDate)%>" readonly="readOnly" onclick="fnPopUpCalendar(searchEndDate,searchEndDate,'yyyy-mm-dd')" />
				</p>
				
				<p><div class = "headerji">
				<%=Lanfunc.language(lan, 106)%> : 
				</div>
				<select name="searchStartHour" class="hourselect" id="searchStartHour">
					<option value="0" >0</option>
<%
	for(int i=1;i<25;i++){
%>
					<option value="<%=i%>" <%=Integer.parseInt(SHour) == i ?"selected":""%> ><%=i%></option>
<%
	}
%>				
				</select>
			
				<select name="searchStartMinute" class="hourselect"  id="searchStartMinute">
					<option value="0" >00</option>
<%
	for(int i=1;i<61;i++){
%>
					<option value="<%=i%>" <%=Integer.parseInt(SMin) == i ?"selected":""%> ><%=i%></option>
<%
	}
%>				
				</select>
			
				<select name="searchStartSec" class="hourselect"  id="searchStartSec">
					<option value="0" >00</option>
<%
	for(int i=1;i<61;i++){
%>
					<option value="<%=i%>" <%=Integer.parseInt(SSec) == i ?"selected":""%> ><%=i%></option>
<%
	}
%>				
				</select>
				~
				<select name="searchEndHour" class="hourselect"  id="searchEndHour">
					<option value="0" >0</option>
<%
	for(int i=1;i<25;i++){
%>
					<option value="<%=i%>" <%=Integer.parseInt(EHour) == i ?"selected":""%> ><%=i%></option>
<%
	}
%>				
				</select>
				
				<select name="searchEndMinute" class="hourselect"  id="searchEndMinute">
					<option value="0" >00</option>
<%
	for(int i=1;i<61;i++){
%>
					<option value="<%=i%>" <%=Integer.parseInt(EMin) == i ?"selected":""%> ><%=i%></option>
<%
	}
%>				
				</select>
				
				<select name="searchEndSec" class="hourselect"  id="searchEndSec">
					<option value="0" >00</option>
<%
	for(int i=1;i<61;i++){
%>
					<option value="<%=i%>" <%=Integer.parseInt(ESec) == i ?"selected":""%> ><%=i%></option>
<%
	}
%>				
				</select>					
				</p>				
				
				
				<p><div class = "headerji">
				<%=Lanfunc.language(lan, 81)%> :
				</div>
				 <input type="text" class="inputt"  name="searchName" value="<%=Name%>" /> 
				 </p>
				 
				<p><div class = "headerji">
				 <%=Lanfunc.language(lan, 108)%> : 
				 </div>
				 <input type="text" class="inputt" name="searchUser" value="<%=User%>" />
				 </p>
				 
				<p><div class="headerji">
				<%=Lanfunc.language(lan, 91)%>
				</div> 
				<input name="content" type="hidden" value="Log" />
				<input name="top" class="inputt" type="text" value="<%=top %>" size="20" />
				<input type="submit" name="submit" value="<%=Lanfunc.language(lan, 182)%>" class="ct-btn white" />
				</p>
			</form>
			</div>
		</section> --%>
		
			<div class="dropdown" style="margin-left:1%; font-size:13px;">
  <button onclick="myFunction()" class="dropbtn">•••</button>
  <div id="myDropdown" class="dropdown-content">
  <!--ieExecWB();  -->
    <a href="#" onclick="printPage();">Print</a>
    <a href="#" onclick="eventExcel();">Excel</a>
    <a href="#" onclick="eventSort();">Sort</a>
  </div>
</div>


<div  class="tablebor" id="logdata">
</div>
<%-- 	<div  class="tablebor" id="logdata">
	<table border=1 cellspacing="0" class="titleEx1">
		<colgroup>
			<col width="9%" class="<%=statuss1%>">
			<col width="10%" class="<%=statuss2%>">
			<col width="10%" class="<%=statuss3%>">
			<col width="10%" class="<%=statuss4%>">
			<col width="14%" class="<%=statuss5%>">
			<col width="10%" class="<%=statuss6%>">
			<col width="12%" class="<%=statuss7%>">
			<col width="12%" class="<%=statuss8%>">
			<col width="13%" class="<%=statuss9%>">
		</colgroup>
		<tr>
			<th class="<%=statuss1%>"><%=Lanfunc.language(lan, 72)%></th>
			<th class="<%=statuss2%>"><%=Lanfunc.language(lan, 73)%></th>
			<th class="<%=statuss3%>"><%=Lanfunc.language(lan, 74)%></th>
			<th class="<%=statuss4%>"><%=Lanfunc.language(lan, 75)%></th>
			<th class="<%=statuss5%>"><%=Lanfunc.language(lan, 76)%></th>
			<th class="<%=statuss6%>"><%=Lanfunc.language(lan, 77)%></th>
			<th class="<%=statuss7%>"><%=Lanfunc.language(lan, 78)%></th>
			<th class="<%=statuss8%>"><%=Lanfunc.language(lan, 79)%></th>
			<th class="<%=statuss9%>"><%=Lanfunc.language(lan, 80)%></th>
		</tr>
	</table>
	<table cellspacing="0"  class="ex1">
		<colgroup>
			<col width="9%" class="<%=statuss1%>">
			<col width="10%" class="<%=statuss2%>">
			<col width="10%" class="<%=statuss3%>">
			<col width="10%" class="<%=statuss4%>">
			<col width="14%" class="<%=statuss5%>">
			<col width="10%" class="<%=statuss6%>">
			<col width="12%" class="<%=statuss7%>">
			<col width="12%" class="<%=statuss8%>">
			<col width="13%" class="<%=statuss9%>">
		</colgroup>
		<tbody>
<%			
				int i = 0;
				while(rs.next()){
					if(i%2==0){
						out.println("<tr  class='odd'>");
					}else{
						out.println("<tr>");	
					}
%>
				<td class='date1 <%=statuss1%>'><%=rs.getString(1) %></td>
				<td class='date1 <%=statuss2%>'><%=rs.getString(2) %></td>
				<td class='date1 <%=statuss3%>'><%=rs.getString(3) %></td>
				<td class='date1 <%=statuss4%>'><%=rs.getString(4) %></td>
				<td class='date1 <%=statuss5%>'><%=rs.getString(5) %></td>
				<td class='date1 <%=statuss6%>'><%=rs.getString(6) %></td>
				<td class='date1 <%=statuss7%>'><%=rs.getString(7) %></td>
				<td class='date1 <%=statuss8%>'><%=rs.getString(8) %></td>
				<td class='date1 <%=statuss9%>'><%=rs.getString(9) %></td>
			</tr>
		</tbody>
		<%
i++;
				}
%>
	</table>
	</div>


<% 				
	
				rs.close();
				conn.close();
				
%>	
<%
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
%> --%>

<div class="postitEventSort" id="postitEventSort" style="display:none">
		<jsp:include page="EventSort.jsp" flush="true">
			<jsp:param name="EventType" value=""/>
			<jsp:param name="EventDate" value=""/>
			<jsp:param name="EventTime" value=""/>
			<jsp:param name="EventPlace" value=""/>
			<jsp:param name="EventName" value=""/>
			<jsp:param name="searchUser" value="<%=User%>"/>
			<jsp:param name="searchName" value=""/>
			<jsp:param name="top" value="<%=Num%>"/>
			<jsp:param name="EventDoorState" value=""/>
			<jsp:param name="EventCompanyID" value=""/>
			<jsp:param name="searchStartDate" value="<%=LangUtil.Empty(SDate)%>"/>
			<jsp:param name="searchEndDate" value="<%=LangUtil.Empty(EDate)%>"/>
			<jsp:param name="searchEndTime" value=""/>
			<jsp:param name="searchStartHour" value=""/>
			<jsp:param name="searchStartMinute" value=""/>
			<jsp:param name="searchStartSec" value=""/>
			<jsp:param name="searchEndHour" value=""/>
			<jsp:param name="searchEndMinute" value=""/>
			<jsp:param name="searchEndSec" value=""/>
		</jsp:include>
</div>

<div class="postitEventExcel" id="postitEventExcel">
		<jsp:include page="EventExcel.jsp" flush="true">
			<jsp:param name="EventType" value=""/>
			<jsp:param name="EventDate" value=""/>
			<jsp:param name="EventTime" value=""/>
			<jsp:param name="EventPlace" value=""/>
			<jsp:param name="EventName" value=""/>
			<jsp:param name="searchUser" value="<%=User%>"/>
			<jsp:param name="searchName" value=""/>
			<jsp:param name="top" value="<%=Num%>"/>
			<jsp:param name="EventDoorState" value=""/>
			<jsp:param name="EventCompanyID" value=""/>
			<jsp:param name="searchStartDate" value=""/>
			<jsp:param name="searchEndDate" value=""/>
			<jsp:param name="searchEndTime" value=""/>
			<jsp:param name="searchStartHour" value=""/>
			<jsp:param name="searchStartMinute" value=""/>
			<jsp:param name="searchStartSec" value=""/>
			<jsp:param name="searchEndHour" value=""/>
			<jsp:param name="searchEndMinute" value=""/>
			<jsp:param name="searchEndSec" value=""/>
		</jsp:include>
		</div>
