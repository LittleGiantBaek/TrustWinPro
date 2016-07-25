<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=8" />
<script src="/TrustWinPro/action/js/jquery-1.11.1.min.js"></script>
<script src="/TrustWinPro/action/js/jquery.event.drag-2.2.js"></script>
<script src="/TrustWinPro/action/js/jquery.event.drag.live-2.2.js"></script>
<script src="/TrustWinPro/action/js/jquery.event.drop-2.2.js"></script>
<script src="/TrustWinPro/action/js/jquery.event.drop.live-2.2.js"></script>
<title>ThreeDubMedia &middot; jquery.event.drop</title>
</head>
<body>
<script type="text/javascript">
jQuery(function($){
	$( document )
		.drag("start",function( ev, dd ){
			return $('<div class="selection" />')
				.css('opacity', .65 )
				.appendTo( document.body );
		})
		.drag(function( ev, dd ){
			$( dd.proxy ).css({
				top: Math.min( ev.pageY, dd.startY ),
				left: Math.min( ev.pageX, dd.startX ),
				height: Math.abs( ev.pageY - dd.startY ),
				width: Math.abs( ev.pageX - dd.startX )
			});
		})
		.drag("end",function( ev, dd ){
			$( dd.proxy ).remove();
		});
	$('.drop')
		.drop("start",function(){
			$( this ).addClass("active");
		})
		.drop(function( ev, dd ){
			$( this ).toggleClass("dropped");
			$("#result").val($("#result").val() + $(this).attr('id'));
		})
		.drop("end",function(){
			$( this ).removeClass("active");
		});
	$.drop({ multi: true });	
});
</script>


<div class="drop" id="1">&nbsp;</div>
<div class="drop" id="2">&nbsp;</div>
<div class="drop" id="3">&nbsp;</div>
<div class="drop" id="4">&nbsp;</div>
<div class="drop" id="5">&nbsp;</div>
<div class="drop" id="6">&nbsp;</div>
<div class="drop" id="7">&nbsp;</div>
<div class="drop" id="8">&nbsp;</div>
<div class="drop" id="9">&nbsp;</div>
<div class="drop" id="10">&nbsp;</div>
<div class="drop" id="11">&nbsp;</div>
<div class="drop" id="12">&nbsp;</div>
<div class="drop" id="13">&nbsp;</div>
<div class="drop" id="14">&nbsp;</div>
<div class="drop" id="15">&nbsp;</div>
<div class="drop" id="16">&nbsp;</div>
<div class="drop" id="17">&nbsp;</div>
<div class="drop" id="18">&nbsp;</div>
<div class="drop" id="19">&nbsp;</div>
<div class="drop" id="20">&nbsp;</div>
<div class="drop" id="21">&nbsp;</div>
<div class="drop" id="22">&nbsp;</div>
<div class="drop" id="23">&nbsp;</div>
<div class="drop" id="24">&nbsp;</div>
<div class="drop" id="25">&nbsp;</div>
<div><input type="text" value="" name="result" id="result" /></div>
<style type="text/css">
.selection {
	position: absolute;
	border: 1px solid #89B;
	background: #BCE;
	background-color: #BEC;
	border-color: #8B9;
	}
.size2 {
	height: 118px;
	line-height: 118px;
	}
.size3 {
	height: 178px;
	line-height: 178px;
	}
.drop {
	float: left;
	border: 1px solid #888;
	background: #EEE;
	text-align: center;
	padding: 0;
	margin: 0;
	font-size: 8px;
	width:7px;
	height:15px;
	}
.dropped {
	background-color: #EBC;
	border-color: #B89;
	}	
.active {  
	background-color: #CEB;
	border-color: #9B8;
	}
</style></body>
</html>