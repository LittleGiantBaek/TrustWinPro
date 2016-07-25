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
  
  $(".contextmenu li").click(function(e){
	  if($(this).html() == "Add Map")
	  alert($(this).html() + ' clicked' );
    $(".contextmenu").hide();
    $(document).unbind('mousedown');
  });
  
  
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
  
  $(".LeftUsertop").on('contextmenu', function(event) {
	    $(".conUser").css({
	      left:event.pageX+"px",
	      top:event.pageY+"px"
	    }).show();

	    $(document).mousedown(function(e){
	      // context menu 가 아닌 다른 영역을 클릭한경우 판단 
	      if ($(e.target).parents(".conUser").length !== 0) 
	        return;
	      $(".conUser").hide();
	      $(document).unbind('mousedown');
	    });
	    return false;
	  });
  
  $(".LeftTimetop").on('contextmenu', function(event) {
	    $(".conTime").css({
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
  
  $(".LeftMonitoringtop").on('contextmenu', function(event) {
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
  $("#span3").on('contextmenu', function(event) {
	    $(".conDeviceGroup").css({
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
