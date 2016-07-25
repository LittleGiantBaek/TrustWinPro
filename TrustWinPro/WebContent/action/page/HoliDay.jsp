<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Holiday.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	HoliDayFunc Holfunc = new HoliDayFunc();
	CategoryFunc Catefunc = new CategoryFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	HoliDay[] holi = Holfunc.selHoliDay();
	String lan = (String)session.getAttribute("nation");
%>
<script type="text/javascript">
var change = 0;

function HoliDayAdd(){
	var name = document.getElementById("AddName").value;
	var date = document.getElementById("AddDate").value;
	if(name == "" || date == ""){
		alert("<%=Lanfunc.language(lan, 118) %>");
	}else{
		var used = 1;
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/HoliDayAdd.jsp",   
		    data: "name="+name + "&date="+date+"&used=" + used ,
		    success:function(args){
		    	document.getElementById("Holiday").submit();
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		});
	}
}

function HoliDayDel(){
	document.getElementById("HoliDay").submit();	
}

function HoliDayAllDel(){
	document.getElementById("AllDelHoliday").submit();
}

function HoliDayModify(){
	document.getElementById("HoliDay").action = "page/HoliDayChange.jsp";
	document.getElementById("HoliDay").submit();
}

function allCheck(){
	var check = document.HoliDay.check;
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
</script>

<%
%>
<div id="HoliInfo">
	<div class="basic">

	<section class = "sectionji">
			<ul class = "ulji">
			</ul>

		<div class="basicInfo">
			<form name="HoliDay" id="HoliDay" method="post" action="page/HoliDayDel.jsp">
				<div class="left">
					<div class="block">
						<table border=1 cellspacing="0" class="titleEx1">
							<colgroup>
								<col width="25%">
								<col width="25%">
								<col width="25%">
								<col width="25%">
							</colgroup>
							<tr>
								<th><%=Lanfunc.language(lan, 83) %></th>
								<th><%=Lanfunc.language(lan, 71) %></th>
								<th><%=Lanfunc.language(lan, 84) %></th>
								<th><%=Lanfunc.language(lan, 167) %><input type="checkbox" name="allcheck" id="allcheck" onclick="allCheck();" ></th>
							</tr>
						</table>
						<table cellspacing="0"  class="ex1">
						<colgroup>
							<col width="25%">
							<col width="25%">
							<col width="25%">
							<col width="25%">
						</colgroup>
						<tbody>
<%
	for(int i=0;i<holi.length;i++){
		if(i%2==0){
			out.println("<tr  class='odd'>");
		}else{
			out.println("<tr>");	
		}
%>
								<td class='date1'><%=holi[i].getHolidayName() %></td>
								<td class='date1'><%=holi[i].getHolidayDate() %></td>
								<td class='date1'><%=holi[i].getUsed().equals("1")?Lanfunc.language(lan, 168):Lanfunc.language(lan, 169) %></td>
								<td class='date1'><input type="checkbox" name="check" id="check" value="<%=holi[i].getHolidayDate()%>" ></td>
							</tr>
<%
	}
%>
						</tbody>
					</table>

					</div>
				</div>
			</form>

			<div class="right">
				<div class="buttom"><a href="#content" onclick="HoliDayDel();"><img src="/TrustWinPro/action/image/interface/statusbar.png" style="width:100px;"><span style="position:absolute;left:35px;top:15px;"><%=Lanfunc.language(lan, 88) %></span></a></div>
				<div class="buttom"><a href="#content" onclick="HoliDayModify();"><img src="/TrustWinPro/action/image/interface/statusbar.png" style="width:100px;position:absolute;"><span class="text"><%=Lanfunc.language(lan, 89) %></span></a></div>
			</div>
		</div>
</section>



		<div class="dataAdd">
			<div class="text"><%=Lanfunc.language(lan, 83) %></div>
			<div class="input"><input type="text" name="AddName" id="AddName" value="" size="40um" ></div>
			<div class="text"><%=Lanfunc.language(lan, 71) %></div>
			<div class="input"><input type="text" name="AddDate" id="AddDate" readonly="readOnly" value="" size="40um" onclick="fnPopUpCalendar(AddDate,AddDate,'yyyy-mm-dd')"></div>
			<div class="buttom" ><a href="#content" onclick="HoliDayAdd();"><img src="/TrustWinPro/action/image/interface/statusbar.png" style="width:80px;position:absolute;"><span class="text"><%=Lanfunc.language(lan, 90) %></span></a></div>
		</div>
	</div>
</div>
<form name="AllDelHoliday" id="AllDelHoliday" method="post" action="page/HoliDayAllDel.jsp" >
</form>
<form action="/TrustWinPro/action/index.jsp" name="Holiday" id="Holiday" method="post">
	<input type="hidden" value="Time" name="left" />
	<input type="hidden" value="Holiday" name="content" />
</form>