<%@ page language="java" contentType="text/html; charset=euc-kr"
    pageEncoding="euc-kr"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Map.*" %>
<%
	LanguageFunc Lanfunc = new LanguageFunc();
	MapFunc mapFunc = new MapFunc();
	
	Map map = mapFunc.topMap();
	Map[] maps = mapFunc.mapList();

	String lan = (String)session.getAttribute("nation");
	String select_mapID = (String)request.getParameter("mapID");
	
%>
<script type="text/javascript">
	function addMap(){
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/AddMap.jsp",   
		    success:function(args){
		    	location.href = "/TrustWinPro/action/index.jsp?left=Monitoring&content=Map";
		    },   
		    error:function(e){  
		        alert(e.responseText);  
		    }  
		}); 	
	}
	
	function deleteMap(v){
		$.ajax({      
		    type:"post",  
		    url:"/TrustWinPro/action/ajax/DeleteMap.jsp",   
		    data: "mapID="+v,
		    success:function(args){
		    	location.href = "/TrustWinPro/action/index.jsp?left=Monitoring&content=Map";
		    },   
		    error:function(e){
		        alert(e.responseText);  
		    }  
		}); 
}

	function mapSubmit(v){
		document.getElementById("Monitoring").mapID.value = v;
		document.getElementById("Monitoring").submit();
		}
	
	$( document ).ready(function() {
		var select_id = $("#map_ID").val();
		$("#map"+select_id).addClass( "userspan");
	});


	
	</script>
<div class="Monitoring">
	<ul>
		<li>Map <a class = "buttom" href="#a" onclick="addMap();" onkeypress="addMap();">+</a>
			<ul>
<%	
	for(int i = 0;i<maps.length;i++){	
%>
	<li id="map<%=maps[i].getIdx()%>" ><img src="/TrustWinPro/action/image/interface/nieun Icon.png" style="width:7px;"><img src="/TrustWinPro/action/image/interface/leftmapicon.png" style="width:13px;"><a href="#a" onclick="mapSubmit(<%=maps[i].getIdx() %>)" onkeypress="mapSubmit(<%=maps[i].getIdx() %>)"><%=maps[i].getName() %></a></li>
<%	
	}	
%>
			</ul>
		</li>
	</ul>
</div>

<div class="UserButtom">
	<a href="#in" onclick="addMap();"><img src="/TrustWinPro/action/image/interface/add.jpg" /></a>
	<a href="#in" onclick="deleteMap(<%=select_mapID%>);"><img src="/TrustWinPro/action/image/interface/del.png" /></a>
</div>

<form action="/TrustWinPro/action/index.jsp" name="Monitoring" id="Monitoring" method="post">
	<input type="hidden" value="" name="mapID" />
	<input type="hidden" value="Monitoring" name="left" />
	<input type="hidden" value="Map" name="content" />
</form>