<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
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
	
	if(request.getParameter("Num")!=null){
		if(!request.getParameter("Num").equals("")){
			Num = (String)request.getParameter("Num");
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
<script type="text/javascript">

function refresh(){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/LogA.jsp",   
	    data: "num=<%=Num%>&searchStartDate=<%=SDate%>&searchEndDate=<%=EDate%>&searchStartHour=<%=SHour%>&searchStartMinute=<%=SMin%>&searchStartSec=<%=SSec%>&searchEndHour=<%=EHour%>&searchEndMinute=<%=EMin%>&searchEndSec=<%=ESec%>&searchName=<%=Name%>&searchUser=<%=User%>&month=<%=Month%>",
	    success:function(args){   
	        $("#logdata").html(args);      
	    },   
	    error:function(e){  
	        //alert("refresh" + e.responseText);  
	    }  
	});  
}

function optionSubmit(){
	var count = 0;
	var array = "";
	var arrayName = "";
	var check = document.colorO.check;
	var name = document.colorO.colorName;
	for(var i = 0; i< check.length; i++){
		if(check[i].checked){
			array = array + "1" + check[i].value + ",";
			arrayName = arrayName + name[i].value + ",";
			count++;
		}else{
			array = array + "0" + check[i].value + ","
			arrayName = arrayName + name[i].value + ",";
		}
	}
	
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/ColorOption.jsp",   
	    data: "array=" + array + "&color="+arrayName,
	    success:function(args){   
	    	document.getElementById("colorO").submit();
	    },   
	    error:function(e){  
	        alert("optionSubmit error" + e.responseText);  
	    }  
	});  
	
}

function closeColor(){
	document.getElementById("colorOption").style.display = "none";
}

function openColor(){
	if(document.getElementById("colorOption").style.display == "none"){
		document.getElementById("colorOption").style.display = "block";	
	}else{
		document.getElementById("colorOption").style.display = "none";
	}
	
	
}

refresh();
$(document).attr("timer",setInterval(refresh,1000));

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
						<a href="#a" onclick="UserPrint();"><img src="/TrustWinPro/action/image/interface/printImage.jpg" alt="" ></a>
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
	
	<div  class="tablebor" id="logdata">
	
	</div>
</div>