<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%
	
	String Num = "20";
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
	
%>
<script type="text/javascript">

function refresh(){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/LogA.jsp",   
	    data: "num=<%=Num%>",
	    success:function(args){   
	        $("#logdata").html(args);      
	    },   
	    error:function(e){  
	        //alert(e.responseText);  
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
	        //alert(e.responseText);  
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

	<div class = "tablebor" style = "width: 96%; margin:3px">
		<div id="logdata">
		</div>
	</div>
</div>