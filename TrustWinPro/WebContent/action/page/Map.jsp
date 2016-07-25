<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Map.*" %>
<%
	String ID = (String)request.getParameter("mapID");
	
	if(ID == null){
		MapFunc mapFunc = new MapFunc();
		Map[] map_list = mapFunc.mapList(); 
		if(map_list.length != 0)
			ID = Integer.toString(map_list[0].getIdx());
	}

	if(ID == null){
		System.out.println("MAP is not Exist");
	}else{
		DeviceFunc devFunc = new DeviceFunc();
		Device[] dev = devFunc.deviceList();
		MapFunc mapFunc = new MapFunc();
		Map map = mapFunc.selMap(ID);
		MapDevice[] mapDev = mapFunc.selMapDev(ID);
		String imageFile = "";
		ServletContext scontext = getServletContext();
		imageFile = request.getContextPath() + "/upload/image/Map/";
		if(map == null){
			
		}else{
			imageFile = imageFile + map.getImage();
		}
%>
<script type="text/javascript">
jQuery(function($){
	$('.drag')
		.drag(function( ev, dd ){
			$( this ).css({
				top: dd.offsetY,
				left: dd.offsetX
			});
			$("#status"+$(this).attr('id')).css({
				top: dd.offsetY+40,
				left: dd.offsetX-80
			});
		},{ relative:true })
		.drag("end",function( ev, dd ){
			$.ajax({      
			    type:"post",  
			    url:"/TrustWinPro/action/ajax/UpdateMapXY.jsp",   
			    data: "X="+ parseInt(dd.offsetX)+"&Y="+  parseInt(dd.offsetY) +"&idx="+$( this ).attr('id'),
			    success:function(args){
			    	
			    },   
			    error:function(e){  
			        alert("drag error" + e.responseText);  
			    }  
			}); 
		});
	
});

function MapDeviceInfo(x,y){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/MapDeviceInfo.jsp",   
	    data: "deviceID="+x,
	    success:function(args){
	    	$("#status"+y).html(args);
	    	//alert(args);
	    	if(args == null){
		      //  alert("NULL");  
	    		$("#status"+y).css("display","none");
	    	}else{
		       // alert("NOT NULL");
	    		$("#status"+y).css("display","inline");	
	    	}
	    },   
	    error:function(e){  
	        alert("MapDeviceInfo error" + e.responseText);  
	    }  
	}); 
}

function mapDelete(){
	var mapID = $("#map_ID").val();
	//ajax 파일하나 만들어서 id값을 넘겨주면 해당하는 id값의 map 정보를 DB에서 지워준다.
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/DeleteMap.jsp",   
	    data: "mapID="+mapID,
	    success:function(args){
	    	location.href = "/TrustWinPro/action/index.jsp?left=Monitoring&content=Map";
	    },   
	    error:function(e){  
	        alert("Map delete error !! : " + e.responseText);  
	    }  
	}); 
}


<%
	for(int i=0;i<mapDev.length;i++){
%>
	setInterval(function(){MapDeviceInfo('<%=mapDev[i].getDeviceID()%>','<%=mapDev[i].getIdx()%>');},1000);
<%
	}
%>
</script>
<div id="MapInfo">
	<div class="basic">
<%
		for(int i=0;i<mapDev.length;i++){
%>
		<img src="/TrustWinPro/action/image/MapClosedDoor.bmp" class="drag" id="<%=mapDev[i].getIdx() %>" style="top:<%=mapDev[i].getY()%>px;left:<%=mapDev[i].getX()%>px;">
		<div class="status" id="status<%=mapDev[i].getIdx()%>" style="top:<%=mapDev[i].getY()+40%>px;left:<%=mapDev[i].getX()-80%>px;">
		
		</div>
<%
		}
%>
		<img src="<%=imageFile%>" class="mapImage">
	</div>
	<div class="bottom" id="web-buttons-idrmij3">
		<a href="#" title="Delete" onclick="mapDelete()">Delete</a>
		<a href="#a" title="Enroll" onclick="setupMove()">MapSetup</a>
	</div>
</div>
<form name="mapsetup" id="mapsetup" method="post" action="/TrustWinPro/action/index.jsp" >
	<input type="hidden" id="map_ID" value="<%=ID%>"  name="mapID" />
	<input type="hidden" value="Monitoring" name="left" />
	<input type="hidden" value="MapSetup" name="content" />
</form>
<%
	}
%>