<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    
<link href="/TrustWinPro/action/css/contextmenu.css" rel="stylesheet" type="text/css" />

  <div class="contextmenu conDeviceGroup">
	  <ul>
	    <li class="menuitem">Add Device Group</li>
  	    <li class="menuitem">Delete Device Group</li>
	  </ul>
  </div>
  
  <div class="contextmenu conDevicetotal">
	  <ul>
	    <li class="menuitem">Add Device Group</li>
  	    <li class="menuitem">Delete Device Group</li>
	    <li class="divider"></li>
	    <li class="menuitem">Add Device</li>
	    <li class="menuitem">Delete Device</li>
	  </ul>
  </div>
  
  <div class="contextmenu conDevice">
	 <ul>
	   <li class="menuitem">Add Device</li>
	   <li class="menuitem">Delete Device</li>
	 </ul>
   </div>     
    
 <!-- User -->
  <div class="contextmenu conUserGroup">
	 <ul>
	   <li class="menuitem">Add User Group</li>
	   <li class="menuitem">Delete User Group</li>
	 </ul>
	 </div>
    <div class="contextmenu conUserAdd">
	 <ul>
	  <li class="menuitem">Delete Group</li>
	  <li class="divider"></li>
      <li class="menuitem">Add User</li>
	   </ul>
     </div>
         <div class="contextmenu conUserDelete">
	 <ul>
	   <li class="menuitem">Delete User</li>
	   </ul>
     </div>
     
  <div class="contextmenu conUserTotal">
	 <ul>
	   <li class="menuitem">Add User Group</li>
	   <li class="menuitem">Delete User Group</li>
	   <li class="divider"></li>
	   <li class="menuitem">Add User</li>
	   <li class="menuitem">Delete User</li>
	 </ul>
     </div>
  <div class="contextmenu conUsersubGroup">
	 <ul>
	   <li class="menuitem">Add User Group</li>
	   <li class="menuitem">Delete User Group</li>
	   <li class="divider"></li>
	   <li class="menuitem">Add User</li>
	 </ul>
     </div>     
  
 <div class="contextmenu conUserMemberGroup">
	 <ul>
	   <li class="menuitem">Delete User Group</li>
	   <li class="divider"></li>
	   <li class="menuitem">Add User</li>
	 </ul>
     </div> 
       
<!-- Access Group -->
  <div class="contextmenu conAccessGroupAdd">
	 <ul>
	   <li class="menuitem">Add Access Group</li>
	 </ul>
  </div>	
  <div class="contextmenu conAccessGroupDelete">
	 <ul>
	   <li class="menuitem">Delete Access Group</li>
	 </ul>
  </div>	
   
  
  <div class="contextmenu conTimeZoneAdd">
	 <ul>
	   <li class="menuitem">Add TimeZone</li>
	 </ul>
	</div>
  <div class="contextmenu conTimeZoneDelete">
	 <ul>
	   <li class="menuitem">Delete TimeZone</li>
	 </ul>
  </div>
  
  
<!-- Monitoring --> 
  <div class="contextmenu conMonitoringAdd">
	 <ul>
	   <li class="menuitem">Add Map</li>
	 </ul>
    </div>
     
  <div class="contextmenu conMonitoringDelete">
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
	  
	  
	  //User Function
	  $(".conUserGroup").click(function(e){
			if($(this).find(".hover").text() == "Add User Group")
				DepartAdd();
			else
				DepartDelete();
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });	  
	  $(".conUserMemberGroup").click(function(e){
			if($(this).find(".hover").text() == "Delete User Group")
				DepartDelete();
			else
				UserAdd(document.getElementById('GroupN').value);
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });
	  $(".conUsersubGroup").click(function(e){
			if($(this).find(".hover").text() == "Add User Group")
				DepartAdd();
			else if($(this).find(".hover").text() == "Delete User Group"){
				DepartDelete();
			}
			else
				UserAdd(document.getElementById('GroupN').value);
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
