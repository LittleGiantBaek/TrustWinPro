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
     
  <div class="contextmenu conUsertotal">
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

 <script type = "text/javascript">
/*   var mapID = document.getElementById('mapInfo')[0].value;
 alert(mapID);
 */
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
	  
  
	//Show Menu
	$(".accessgrouplist.userspan").on('contextmenu', function(event) {
	  ShowContextMenu("conAccessGroupDelete");
	  CheckLocation();	  
	  return false;
	});

	$(".timezonelist.userspan").on('contextmenu', function(event) {
		  ShowContextMenu("conTimeZoneDelete");
		  CheckLocation();
		  return false;
	});
	
	$(".maplist.userspan").on('contextmenu', function(event) {
		  ShowContextMenu("conMonitoringDelete");
		  CheckLocation();
		  return false;
	});

	//Menu Event
	  $(".conAccessGroupDelete").click(function(e){
		var deleteID = $("#valueOfselectID").val();
		TimeDelete(deleteID);
	    $(".contextmenu").hide();
	    $(document).unbind('mousedown');
	  });

/*  	   $("#map"+mapID).on('contextmenu', function(event) {
		    $(".conMonitoring").css({
		      left:event.pageX+"px",
		      top:event.pageY+"px"
		    }).show();

		    $(document).mousedown(function(e){
		      // context menu 가 아닌 다른 영역을 클릭한경우 판단 
		      if ($(e.target).parents(".contextmenu").length !== 0) 
		        return;
		      $(".contextmenu").hide();
		      $(document).unbind('mousedown');
		    });
		    return false;
		  });
  */
	   $(".LeftDevicetop").on('contextmenu', function(event) {
		    $(".conDevice").css({
		      left:event.pageX+"px",
		      top:event.pageY+"px"
		    }).show();

		    $(document).mousedown(function(e){
		      // context menu 가 아닌 다른 영역을 클릭한경우 판단 
		      if ($(e.target).parents(".contextmenu").length !== 0) 
		        return;
		      $(".contextmenu").hide();
		      $(document).unbind('mousedown');
		    });
		    return false;
		  });
	  $(".conTimeZoneDelete").click(function(e){
		var deleteID = $("#valueOfselectID").val();
		TimeDelete(deleteID);
	    $(".contextmenu").hide();
	    $(document).unbind('mousedown');
	  });
	  
	  $(".conMonitoringDelete").click(function(e){
			var deleteID = $("#valueOfselectID").val();
			deleteMap(deleteID);
		    $(".contextmenu").hide();
		    $(document).unbind('mousedown');
	  });
  
  
	   $("#span0").on('contextmenu', function(event) {
		    $(".conUserGroup").css({
		      left:event.pageX+"px",
		      top:event.pageY+"px"
		    }).show();

		    $(document).mousedown(function(e){
		      // context menu 가 아닌 다른 영역을 클릭한경우 판단 
		      if ($(e.target).parents(".contextmenu").length !== 0) 
		        return;
		      $(".contextmenu").hide();
		      $(document).unbind('mousedown');
		    });
		    return false;
		  });
});
</script> 
