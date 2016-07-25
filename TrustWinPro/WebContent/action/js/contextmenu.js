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
    alert($(this).html() + ' clicked' );
    $(".contextmenu").hide();
    $(document).unbind('mousedown');
  });
  
  
  $(".Device").on('contextmenu', function(event) {
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
  
  $(".User").on('contextmenu', function(event) {
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
  
  $(".Time").on('contextmenu', function(event) {
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
  
  $(".Monitoring").on('contextmenu', function(event) {
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

});
