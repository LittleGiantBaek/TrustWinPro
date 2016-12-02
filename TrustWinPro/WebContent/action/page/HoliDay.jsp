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
		alertify.alert("<%=Lanfunc.language(lan, 118) %>");
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
		    	alertify.alert(e.responseText);  
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
			<ul class = "ulji"></ul>
			<div class="basicInfo">
				<div class="holi_top" style="padding-left:4%;margin-top:20px;">
					<div class="headerji">
						<%=Lanfunc.language(lan, 83) %>
						:
					</div>
					<input type="text" class="inputt" name="AddName" id="AddName" value="" />
					</p>

					<p>
					<div class="headerji">
						<%=Lanfunc.language(lan, 71) %>
						:
					</div>
					<div class="input"><input type="text" class="inputt" name="AddDate" id="AddDate" readonly="readOnly" value="" onclick="fnPopUpCalendar(AddDate,AddDate,'yyyy-mm-dd')"></div>
					</p>
				<%-- <div class="text"><%=Lanfunc.language(lan, 83) %></div>
					<div class="input"><input type="text" name="AddName" id="AddName" value="" size="40um" ></div>
					<div class="text"><%=Lanfunc.language(lan, 71) %></div>
				 	<div class="input"><input type="text" name="AddDate" id="AddDate" readonly="readOnly" value="" size="40um" onclick="fnPopUpCalendar(AddDate,AddDate,'yyyy-mm-dd')"></div>
					<div class="buttom bt_access" >	<a href="#DeviceInfo" onclick="HoliDayAdd();" class="button gray"  style=""><span class="icon-check" ></span><%=Lanfunc.language(lan, 90) %></a></div> 
				--%>
				</div>
			</div>
			</div>
		</section>

		<div class="tablebor" id="TrustPrint">
			<form name="HoliDay" id="HoliDay" method="post" action="page/HoliDayDel.jsp">
				<table border=1 cellspacing="0" class="titleEx1">
						<colgroup>
							<col width="10%">
							<col width="30%">
							<col width="30%">
							<col width="30%">
						</colgroup>
						<tr>
							<th><%=Lanfunc.language(lan, 85) %><input type="checkbox" name="allcheck" id="allcheck" onclick="allCheck();" ></th>
							<th><%=Lanfunc.language(lan, 83) %></th>
							<th><%=Lanfunc.language(lan, 71) %></th>
							<th><%=Lanfunc.language(lan, 84) %></th>
						</tr>
				</table>
				<table cellspacing="0"  class="ex1">
							<colgroup>
								<col width="10%">
								<col width="30%">
								<col width="30%">
								<col width="30%">
							</colgroup>
							<tbody>
	<%
		for(int i=0;i<holi.length;i++){
			if(i%2==0){
				out.println("<tr class='odd'>");
			}else{
				out.println("<tr>");	
			}
	%>	
									<td class='date1'><input type="checkbox" name="check" id="check" value="<%=holi[i].getHolidayDate()%>" ></td>
									<td class='date1'><%=holi[i].getHolidayName() %></td>
									<td class='date1'><%=holi[i].getHolidayDate() %></td>
									<td class='date1'><%=holi[i].getUsed().equals("1")?Lanfunc.language(lan, 168):Lanfunc.language(lan, 169) %></td>
								</tr>
								
	<%
		}
	%>
							</tbody>
						</table>
				</form>
			</div>
	</div>
	
	<div class="buttonBox">
			<div class="bottom bt_access" style="padding-right: 50px;padding-left:10px;margin-top:10px;">
					<a href="#" title="Send" onclick="HoliSocket('S,D,H,H,H,H,E');" class="button yellow"><span style="margin-left: 2px;"><img src="/TrustWinPro/action/image/interface/communication2.png" style="height:20px; width:20px"></span>Send</a>
					<a href="#" title="Send" onclick="HoliDayDel();" class="button gray" style="float: right;"><span class="icon-delete"></span><%=Lanfunc.language(lan, 88) %></a>
					<a href="#" title="Send" onclick="HoliDayModify();" class="button gray" style="float: right;"><span class="icon-check"></span><%=Lanfunc.language(lan, 89) %></a>
					<a href="#" title="Send" onclick="HoliDayAdd();" class="button gray" style="float: right;"><span class="icon-check"></span><%=Lanfunc.language(lan, 90) %></a>
			</div>				
	</div>
	
</div>

<form name="AllDelHoliday" id="AllDelHoliday" method="post" action="page/HoliDayAllDel.jsp" ></form>
<form action="/TrustWinPro/action/index.jsp" name="Holiday" id="Holiday" method="post">
	<input type="hidden" value="Time" name="left" />
	<input type="hidden" value="Holiday" name="content" />
</form>