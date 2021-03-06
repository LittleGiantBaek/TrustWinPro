<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<link href="/TrustWinPro/action/css/contextmenu.css" rel="stylesheet" type="text/css" />

  <div class="contextmenu conDeviceMenu">
	  <ul>
	    <li class="menuitem">Print</li>
  	    <li class="menuitem">Excel</li>
  	    <li class="menuitem">Sort</li>
	  </ul>
  </div>


  <div class="contextmenu conDeviceGroup bt_device">
	  <ul>
	    <li class="menuitem">Add Device Group</li>
  	    <li class="menuitem">Delete Device Group</li>
	   <li class="divider"></li>
	   <li class="menuitem">Edit Name</li>
	  </ul>
  </div>
  
    <div class="contextmenu conDeviceMemberGroup bt_device">
	 <ul>
	   <li class="menuitem">Delete Device Group</li>
	   <li class="divider"></li>
	   <li class="menuitem">Add Device</li>
	   <li class="menuitem">Edit Name</li>
	 </ul>
     </div>  
     
       <div class="contextmenu conDevicesubGroup bt_device">
	 <ul>
	   <li class="menuitem">Add Device Group</li>
	   <li class="menuitem">Delete Device Group</li>
	   <li class="divider"></li>
	   <li class="menuitem">Add Device</li>
	   <li class="menuitem">Edit Name</li>
	 </ul>
     </div>  
     
       <div class="contextmenu conDevicetotal bt_device">
	  <ul>
	    <li class="menuitem">Add Device Group</li>
  	    <li class="menuitem">Delete Device Group</li>
	    <li class="divider"></li>
	    <li class="menuitem">Add Device</li>
	    <li class="menuitem">Delete Device</li>
	  </ul>
 	 </div>
  
     <div class="contextmenu conDeviceDelete bt_device">
	 <ul>
	   <li class="menuitem">Delete Device</li>
	   </ul>
     </div>
  
    
 <!-- User -->
  <div class="contextmenu conUserGroup bt_user">
	 <ul>
	   <li class="menuitem">Add User Group</li>
	   <li class="menuitem">Delete User Group</li>
	   <li class="divider"></li>
	   <li class="menuitem">Edit Name</li>
	 </ul>
	 </div>
         <div class="contextmenu conUserDelete bt_user">
	 <ul>
	   <li class="menuitem">Delete User</li>
	   </ul>
     </div>
     
  <div class="contextmenu conUserTotal bt_user">
	 <ul>
	   <li class="menuitem">Add User Group</li>
	   <li class="menuitem">Delete User Group</li>
	   <li class="divider"></li>
	   <li class="menuitem">Add User</li>
	   <li class="menuitem">Delete User</li>
	 </ul>
    </div>
  <div class="contextmenu conUsersubGroup bt_user">
	 <ul>
	   <li class="menuitem">Add User Group</li>
	   <li class="menuitem">Delete User Group</li>
	   <li class="divider"></li>
	   <li class="menuitem">Add User</li>
	   <li class="menuitem">Edit Name</li>
	 </ul>
     </div>     
  
 <div class="contextmenu conUserMemberGroup bt_user">
	 <ul>
	   <li class="menuitem">Delete User Group</li>
	   <li class="divider"></li>
	   <li class="menuitem">Add User</li>
	   <li class="menuitem">Edit Name</li>
	 </ul>
     </div> 
       
<!-- Access Group -->
  <div class="contextmenu conAccessGroupAdd bt_access">
	 <ul>
	   <li class="menuitem">Add Access Group</li>
	 </ul>
  </div>	
  <div class="contextmenu conAccessGroupDelete bt_access">
	 <ul>
	   <li class="menuitem">Delete Access Group</li>
	 </ul>
  </div>	
   
  
  <div class="contextmenu conTimeZoneAdd bt_access">
	 <ul>
	   <li class="menuitem">Add TimeZone</li>
	 </ul>
	</div>
  <div class="contextmenu conTimeZoneDelete bt_access">
	 <ul>
	   <li class="menuitem">Delete TimeZone</li>
	 </ul>
  </div>
  
  
<!-- Monitoring --> 
  <div class="contextmenu conMonitoringAdd bt_monitoring">
	 <ul>
	   <li class="menuitem">Add Map</li>
	 </ul>
    </div>
     
  <div class="contextmenu conMonitoringDelete bt_monitoring">
	 <ul>
	   <li class="menuitem">Delete Map</li>
	 </ul>
   </div>       


<script type="text/template" id="contextmenu-template"></script>
<script type = "text/javascript">
	  $(function(){
		$(".menuitem").mouseover(function(e){
	    var $el = $(this);
	    if ( !$el.hasClass('hover'))
	      $el.addClass('hover');
	  }).mouseout(function(e){
	  var $el = $(this);
	    if($el.hasClass('hover'))
	      $el.removeClass('hover');
	  });
	  
  
	//AccessGroup Contextmenu
	$("#AccessGroupTopID").on('contextmenu', function(event) {
		if($('#AccessGroupTopID').hasClass('userspan')){
		ShowContextMenu("conAccessGroupAdd");
	  	CheckLocation();	  
	  	return false;
		}	  	
	});	
	$(".accessgrouplist.userspan").on('contextmenu', function(event) {
	  ShowContextMenu("conAccessGroupDelete");
	  CheckLocation();	  
	  return false;
	});	

	$("#TimeZoneTopID").on('contextmenu', function(event) {
		if($('#TimeZoneTopID').hasClass('userspan')){
		ShowContextMenu("conTimeZoneAdd");
	  	CheckLocation();	  
	  	return false;
		}	  	
	});	
	$(".timezonelist.userspan").on('contextmenu', function(event) {
		  ShowContextMenu("conTimeZoneDelete");
		  CheckLocation();
		  return false;
	});

	//Mornitoring Contextmenu
	$("#MapTopID").on('contextmenu', function(event) {
		if($('#MapTopID').hasClass('userspan')){
		  ShowContextMenu("conMonitoringAdd");
		  CheckLocation();
		  return false;
		}
	});
	$(".maplist.userspan").on('contextmenu', function(event) {
		  ShowContextMenu("conMonitoringDelete");
		  CheckLocation();
		  return false;
	});
	
	//sort Device Contextmenu
	$("#sort1").on('contextmenu', function(event) {
		  ShowContextMenu("conDeviceMenu");
		  CheckLocation();
		  return false;
	});
	
	//Device Contextmenu
	$(".devicespanroot").on('contextmenu', function(event) {
		  ShowContextMenu("conDeviceGroup");
		  CheckLocation();
		  return false;
	});
	
	$(".deviceGroupspan").on('contextmenu', function(event) {
		//1.그룹 하위에 그룹이 존재  2.그룹 하위에 디바이스가 존재  3.그룹 하위에 아무것도 없음
		if(GroupCheck() == 1){
		ShowContextMenu("conDeviceGroup");
		}else if(GroupCheck() == 2){
		ShowContextMenu("conDeviceMemberGroup");
		}else if(GroupCheck() == 3){
			ShowContextMenu("conDevicesubGroup");
		}
		 CheckLocation();
		  return false;
	});
	
	$(".deviceIDspan").on('contextmenu', function(event) {
		ShowContextMenu("conDeviceDelete");
		 CheckLocation();
		  return false;
	});
	
	
	
	//User Contextmenu
 	$(".userspanroot").on('contextmenu', function(event) {
		  ShowContextMenu("conUserGroup");
		  CheckLocation();
		  return false;
	});
	
	$(".userGroupspan").on('contextmenu', function(event) {
		//1.부서 하위에 부서가 존재  2.부서 하위에 멤버가 존재  3.부서 하위에 아무것도 없음3 
		if(DepartCheck() == 1){
		ShowContextMenu("conUserGroup");
		}else if(DepartCheck() == 2){
		ShowContextMenu("conUserMemberGroup");
		}else if(DepartCheck() == 3){
			ShowContextMenu("conUsersubGroup");
		}
		 CheckLocation();
		  return false;
	});
	
	$(".userIDspan").on('contextmenu', function(event) {
		ShowContextMenu("conUserDelete");
		 CheckLocation();
		  return false;
	});
	
	
	
	//AccessGroup Function
	  $(".conAccessGroupAdd").click(function(e){
		InsertAccess();
	    $(".contextmenu").hide();
	    $(document).unbind('mousedown');
	  });

	  $(".conAccessGroupDelete").click(function(e){
		var deleteID = $("#valueOfselectID").val();
		TimeDelete(deleteID);
	    $(".contextmenu").hide();
	    $(document).unbind('mousedown');
	  });
	  $(".conTimeZoneAdd").click(function(e){
		 InsertTime();
	    $(".contextmenu").hide();
	    $(document).unbind('mousedown');
	  });
	  $(".conTimeZoneDelete").click(function(e){
		var deleteID = $("#valueOfselectID").val();
		TimeDelete(deleteID);
	    $(".contextmenu").hide();
	    $(document).unbind('mousedown');
	  });
	  

		//Morinitoring Function
	  $(".conMonitoringAdd").click(function(e){
			addMap();
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });
	  $(".conMonitoringDelete").click(function(e){
			var deleteID = $("#valueOfselectID").val();
			deleteMap(deleteID);
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });
	  
	  
	//Device Function
	  $(".conDeviceGroup").click(function(e){
			if($(this).find(".hover").text() == "Add Device Group"){
				GroupAdd();  
				}
			else if($(this).find(".hover").text() == "Delete Device Group"){
				GroupDelete();
				}
			else if($(this).find(".hover").text() == "Edit Name")
				changeInputBox(document.getElementById("valueOfDevicei").value);
			
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });	  
	  $(".conDeviceMemberGroup").click(function(e){
			if($(this).find(".hover").text() == "Delete Device Group")
				GroupDelete();
			else if($(this).find(".hover").text() == "Add Device")
				DeviceAdd(document.getElementById('GroupN').value);
			else if($(this).find(".hover").text() == "Edit Name")
				changeInputBox(document.getElementById("valueOfDevicei").value);
			
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });
	  $(".conDevicesubGroup").click(function(e){
			if($(this).find(".hover").text() == "Add Device Group"){
				GroupAdd();
			}
			else if($(this).find(".hover").text() == "Delete Device Group"){
				GroupDelete();
			}
			else if($(this).find(".hover").text() == "Add Device"){
				DeviceAdd(document.getElementById('GroupN').value);
			}
			else if($(this).find(".hover").text() == "Edit Name"){
				changeInputBox(document.getElementById("valueOfDevicei").value);
			}
			
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });
	  
	  
	  $(".conDeviceDelete").click(function(e){
 		  var deleteID = $("#valueOfDeviceID").val();
		  DeviceDelete(deleteID);
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });
	  
	  
	  //User Function
	  $(".conUserGroup").click(function(e){
			if($(this).find(".hover").text() == "Add User Group"){
				DepartAdd();
			} else  if($(this).find(".hover").text() == "Delete User Group"){
				DepartDelete();
			} else if($(this).find(".hover").text() == "Edit Name")
				changeInputBox(document.getElementById("valueOfUseri").value);
		
			
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });	  
	  $(".conUserMemberGroup").click(function(e){
			if($(this).find(".hover").text() == "Delete User Group")
				DepartDelete();
			else if($(this).find(".hover").text() == "Add User")
				UserAdd(document.getElementById('GroupN').value);
			else if($(this).find(".hover").text() == "Edit Name")
				changeInputBox(document.getElementById("valueOfUseri").value);
			
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });
	  $(".conUsersubGroup").click(function(e){
			if($(this).find(".hover").text() == "Add User Group")
				DepartAdd();
			else if($(this).find(".hover").text() == "Delete User Group")
				DepartDelete();
			else if($(this).find(".hover").text() == "Add User")
				UserAdd(document.getElementById('GroupN').value);
			else if($(this).find(".hover").text() == "Edit Name")
				changeInputBox(document.getElementById("valueOfUseri").value);
			
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });
	  $(".conUserDelete").click(function(e){
 		  var deleteID = $("#valueOfselectUserID").val();
		  UserDelete(deleteID);
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });
});
</script> 
