<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%@ page import="com.Trustwin.Admin.Project.Timezone.*" %>
<%
	Connection conn = null;
	String sql = "select TimeZoneNo from TimeZone ";
	String Num = "";
	int valueT = 0;
	String lan = (String)session.getAttribute("nation");
	
	TimeZoneFunc Timefunc = new TimeZoneFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	
	TimeZone[] times = Timefunc.TimeMenu();
	
	
	if(request.getParameter("num") != null){
		Num = (String)request.getParameter("num");
	}else if(times.length>0){
		Num = times[0].getTimeZoneNo();
	}else{
		valueT = 1;
	}
	
	if(valueT == 0){
		TimeZone time = Timefunc.selTimeZone(Num);
%>
<script type="text/javascript">
$(".Loading").css("display","block");

var count = 0;
var value = 0;

function removeClass(element, className) {
    var check = new RegExp("(\\s|^)" + className + "(\\s|$)");
    element.className = element.className.replace(check, " ").trim();
};

function addClass(element, className) {
    element.className += " " + className;
};

jQuery(function($){
	$(document)
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
			count++;
			var str = $( this ).attr("class").indexOf("dropped");
			if(count == 1){
				if(str != -1){ // dropped가 존재한다면
					value = 0;
				}else{		   // dropped가 존재하지 않는다면
					value = 1;
				}
			}
			
			$( this ).addClass("active");
		})
		.drop(function( ev, dd ){
			if(value == 0){	// dropped가 존재한다.
				removeClass(this,"dropped");
				var str = $(this).attr("id") + "/";
				$("#result").val($("#result").val().replace(str,""));
			}else{			// dropped가 존재하지 않는다.
				if($( this ).attr("class").indexOf("dropped")==-1){
					addClass(this,"dropped");
					$("#result").val($("#result").val() + $(this).attr("id")+ "/") ;
				}
			}
		})
		.drop("end",function(){
			$( this ).removeClass("active");
			count=0;
		});
	$.drop({ multi: true });	
});

function TimeZoneSubmit(){
	var array = document.getElementById("result").value.split("/");
	var min1 = 10000;
	var max1 = 0;
	var min2 = 10000;
	var max2 = 0;
	var min3 = 10000;
	var max3 = 0;
	var min4 = 10000;
	var max4 = 0;
	var min5 = 10000;
	var max5 = 0;
	var min6 = 10000;
	var max6 = 0;
	var min7 = 10000;
	var max7 = 0;
	var min8 = 10000;
	var max8 = 0;
	for(var i = 0;i<array.length-1;i++){	
		if(array[i]<2000){
			if(min1 > array[i]){
				min1 = array[i];
			}
			
			if(max1 < array[i]){
				max1 = array[i]
			}
			
		}else if(array[i]<3000){
			if(min2 > array[i]){
				min2 = array[i];
			}
			
			if(max2 < array[i]){
				max2 = array[i]
			}
			
		}else if(array[i]<4000){
			if(min3 > array[i]){
				min3 = array[i];
			}
			
			if(max3 < array[i]){
				max3 = array[i]
			}
			
		}else if(array[i]<5000){
			if(min4 > array[i]){
				min4 = array[i];
			}
			
			if(max4 < array[i]){
				max4 = array[i]
			}
			
		}else if(array[i]<6000){
			if(min5 > array[i]){
				min5 = array[i];
			}
			
			if(max5 < array[i]){
				max5 = array[i]
			}
			
		}else if(array[i]<7000){
			if(min6 > array[i]){
				min6 = array[i];
			}
			
			if(max6 < array[i]){
				max6 = array[i]
			}
			
		}else if(array[i]<8000){
			if(min7 > array[i]){
				min7 = array[i];
			}
			
			if(max7 < array[i]){
				max7 = array[i]
			}
			
		}else{
			if(min8 > array[i]){
				min8 = array[i];
			}
			
			if(max8 < array[i]){
				max8 = array[i]
			}
			
		}
	}
	
	for(var z = 1; z < 9; z++){
		var min = "";
		var max = "";
		if(z==1){
			min = min1;
			max = max1;
		}else if(z==2){
			min = min2;
			max = max2;
		}else if(z==3){
			min = min3;
			max = max3;
		}else if(z==4){
			min = min4;
			max = max4;
		}else if(z==5){
			min = min5;
			max = max5;
		}else if(z==6){
			min = min6;
			max = max6;
		}else if(z==7){
			min = min7;
			max = max7;
		}else if(z==8){
			min = min8;
			max = max8;
		}
		for(var i = 0;i < 24; i++){
			for(var j = 0; j < 6; j++){
				var value = z;
				var k = 0;
				if(i<10){
					k = "0"+i;
				}else{
					k = i;
				}
				value = value + k + j;
				
				if(value > min && max > value){
					if(document.getElementById(value).className.indexOf("dropped") < 0){
						alert("<%=Lanfunc.language(lan, 93)%>");
						
						location.href = "/TrustWinPro/action/index.jsp?left=Time&content=Time&num="+<%=times[0].getTimeZoneNo()%>;
						return false;
					}
				}
			}
		}
	}	
	
	
	if(min1 != 10000 && max1 != 0){
		min1 = min1.substring(1,3) + ":" + min1.substring(3,4) + "0:00";
		max1 = max1.substring(1,3) + ":" + max1.substring(3,4) + "0:00";
		document.getElementById("result1").value = min1 + "/" + max1;	
	}else{
		document.getElementById("result1").value = "00:00:00" + "/" + "00:00:00";	
	}
	
	if(min2 != 10000 && max2 != 0){
		min2 = min2.substring(1,3) + ":" + min2.substring(3,4) + "0:00";
		max2 = max2.substring(1,3) + ":" + max2.substring(3,4) + "0:00";
		document.getElementById("result2").value = min2 + "/" + max2;
	}else{
		document.getElementById("result2").value = "00:00:00" + "/" + "00:00:00";	
	}
	
	if(min3 != 10000 && max3 != 0){
		min3 = min3.substring(1,3) + ":" + min3.substring(3,4) + "0:00";
		max3 = max3.substring(1,3) + ":" + max3.substring(3,4) + "0:00";
		document.getElementById("result3").value = min3 + "/" + max3;	
	}else{
		document.getElementById("result3").value = "00:00:00" + "/" + "00:00:00";	
	}
	
	if(min4 != 10000 && max4 != 0){
		min4 = min4.substring(1,3) + ":" + min4.substring(3,4) + "0:00";
		max4 = max4.substring(1,3) + ":" + max4.substring(3,4) + "0:00";
		document.getElementById("result4").value = min4 + "/" + max4;
	}else{
		document.getElementById("result4").value = "00:00:00" + "/" + "00:00:00";	
	}
	
	if(min5 != 10000 && max5 != 0){
		min5 = min5.substring(1,3) + ":" + min5.substring(3,4) + "0:00";
		max5 = max5.substring(1,3) + ":" + max5.substring(3,4) + "0:00";
		document.getElementById("result5").value = min5 + "/" + max5;
	}else{
		document.getElementById("result5").value = "00:00:00" + "/" + "00:00:00";	
	}
	
	if(min6 != 10000 && max6 != 0){
		min6 = min6.substring(1,3) + ":" + min6.substring(3,4) + "0:00";
		max6 = max6.substring(1,3) + ":" + max6.substring(3,4) + "0:00";
		document.getElementById("result6").value = min6 + "/" + max6;	
	}else{
		document.getElementById("result6").value = "00:00:00" + "/" + "00:00:00";	
	}
	
	if(min7 != 10000 && max7 != 0){
		min7 = min7.substring(1,3) + ":" + min7.substring(3,4) + "0:00";
		max7 = max7.substring(1,3) + ":" + max7.substring(3,4) + "0:00";
		document.getElementById("result7").value = min7 + "/" + max7;	
	}else{
		document.getElementById("result7").value = "00:00:00" + "/" + "00:00:00";	
	}
	
	if(min8 != 10000 && max8 != 0){
		min8 = min8.substring(1,3) + ":" + min8.substring(3,4) + "0:00";
		max8 = max8.substring(1,3) + ":" + max8.substring(3,4) + "0:00";
		document.getElementById("result8").value = min8 + "/" + max8;	
	}else{
		document.getElementById("result8").value = "00:00:00" + "/" + "00:00:00";	
	}
	
	TimeZone.submit();
}

function TimeZoneDelete(v){
	TimeZoneDel.num.value = v;
	TimeZoneDel.submit();
}

</script>


<div id="TimeInfo">

	<form action="/TrustWinPro/action/page/TimeZoneUpdate.jsp" name="TimeZone" id="TimeZone" method="post">
		<input type="hidden" value="" name="result" id="result" />
		<input type="hidden" value="<%=Num%>" name="timezoneNo" id="timezoneNo" />
		<input type="hidden" value="<%=time.getHolSTime2() + "/" + time.getHolETime2() %>" name="result1" id="result1" />
		<input type="hidden" value="<%=time.getMonSTime() + "/" + time.getMonETime() %>" name="result2" id="result2" />
		<input type="hidden" value="<%=time.getTueSTime() + "/" + time.getTueETime() %>" name="result3" id="result3" />
		<input type="hidden" value="<%=time.getWedSTime() + "/" + time.getWedETime() %>" name="result4" id="result4" />
		<input type="hidden" value="<%=time.getThuSTime() + "/" + time.getThuETime() %>" name="result5" id="result5" />
		<input type="hidden" value="<%=time.getFriSTime() + "/" + time.getFriETime() %>" name="result6" id="result6" />
		<input type="hidden" value="<%=time.getSatSTime() + "/" + time.getSatETime() %>" name="result7" id="result7" />
		<input type="hidden" value="<%=time.getHolSTime1() + "/" + time.getHolETime1() %>" name="result8" id="result8" />

<section class = "sectionji">
			<ul class = "ulji">
			</ul>
		<div class="basic">
			<div class="block">
				<div class="header"><%=Lanfunc.language(lan, 95)%></div>
				<div class="main">
					<select name="timezoneNoM">
						
<%
		int CouNum = 0;
		int num_of_timezone = times.length;
		String id_of_timezone ="";
		if(times.length != 0){
			num_of_timezone--;
			id_of_timezone = times[num_of_timezone].getTimeZoneNo();
		}
		
		for(int i = 1; i< 251; i++){
			if(i==Integer.parseInt(Num)){
				num_of_timezone--;
				if(num_of_timezone >= 0 )
					id_of_timezone = times[num_of_timezone].getTimeZoneNo();

%>
						<option value="<%=Num%>" selected><%=Num %></option>
<%
			}else if(i==Integer.parseInt(id_of_timezone)){
				num_of_timezone--;
				if(num_of_timezone >= 0 )
					id_of_timezone = times[num_of_timezone].getTimeZoneNo();

%>							
						<option value="<%=i%>" disabled><%=i%></option>
<%			 
			} else{
%>							
				<option value="<%=i%>"><%=i%></option>
<%				
			}
			
		}
%>					
					</select>
				</div>
				<div class="header">
				<%=Lanfunc.language(lan, 81)%>
				</div>
				<div class="main">
					<input type="text" name="timename" value="<%=time.getTimeZoneName() %>" >
				</div>
			</div>
		</div>
	</section>
		
		<div class="week">
			<div class="Name"><%=Lanfunc.language(lan, 180)%></div>
			<div class="Group">
				<div class="holiName">
<%
	for(int i=0;i<25;i++){
		if(i == 0){
%>
					<div class="first"><%=i%></div>
<%
		}else if(i == 24){
%>
					<div class="last"><%=i%></div>
<%		
		}else{
%>
					<div class="name"><%=i%></div>
<%		
		}
	}
%>
				</div>
				<div class="holi">
<%
	int value = 0;
	int resultS = Integer.parseInt("8"+time.getHolSTime1().split(":")[0] + time.getHolSTime1().split(":")[1].substring(0,1));
	int resultE = Integer.parseInt("8"+time.getHolETime1().split(":")[0] + time.getHolETime1().split(":")[1].substring(0,1));
	for(int i=0;i<24;i++){
		for(int j=0;j<6;j++){
			String k = "";
			if(i<10){
				k = "0"+Integer.toString(i);
			}else{
				k = Integer.toString(i);
			}
			if(resultS <= Integer.parseInt("8"+k+j) && resultE >= Integer.parseInt("8"+k+j)&&(resultS+resultE)/2 != 8000){
				value = 1;
%>
		<script type="text/javascript">
			document.getElementById("result").value = document.getElementById("result").value + "8<%=k%><%=j%>/" ;
		</script>
<%
			}else{
				value = 0;
			}
			
%>
					<div class="drop <%=j==5?"end":"" %> <%=value==1?"dropped":"" %>" id="8<%=k%><%=j%>">&nbsp;</div>
<%
		}
%>
			
<%
	}
%>
				</div>
			</div>
			<div class="Name"><%=Lanfunc.language(lan, 96)%></div>
			<div class="Group">
				<div class="sunName">
<%
	for(int i=0;i<25;i++){
		if(i == 0){
%>
					<div class="first"><%=i%></div>
<%
		}else if(i == 24){
%>
					<div class="last"><%=i%></div>
<%		
		}else{
%>
					<div class="name"><%=i%></div>
<%		
		}
	}
%>
				</div>
				<div class="sun">
<%
	value = 0;
	resultS = Integer.parseInt("1"+time.getHolSTime2().split(":")[0] + time.getHolSTime2().split(":")[1].substring(0,1));
	resultE = Integer.parseInt("1"+time.getHolETime2().split(":")[0] + time.getHolETime2().split(":")[1].substring(0,1));
	for(int i=0;i<24;i++){
		for(int j=0;j<6;j++){
			String k = "";
			if(i<10){
				k = "0"+Integer.toString(i);
			}else{
				k = Integer.toString(i);
			}
			
			if(resultS <= Integer.parseInt("1"+k+j) && resultE >= Integer.parseInt("1"+k+j)&&(resultS+resultE)/2 != 1000){
				value = 1;
%>
		<script type="text/javascript">
			document.getElementById("result").value = document.getElementById("result").value + "1<%=k%><%=j%>/" ;
		</script>
<%
			}else{
				value = 0;
			}
			
%>
					<div class="drop <%=j==5?"end":"" %> <%=value==1?"dropped":"" %>" id="1<%=k%><%=j%>">&nbsp;</div>
<%
		}
%>
			
<%
	}
%>
				</div>
			</div>
			<div class="Name"><%=Lanfunc.language(lan, 97)%></div>
			<div class="Group">
				<div class="monName">
<%
	for(int i=0;i<25;i++){
		if(i == 0){
%>
					<div class="first"><%=i%></div>
<%
		}else if(i == 24){
%>
			<div class="last"><%=i%></div>
<%		
		}else{
%>
					<div class="name"><%=i%></div>
<%		
		}
	}
%>
				</div>
				<div class="mon">
<%
	value = 0;
	resultS = Integer.parseInt("2"+time.getMonSTime().split(":")[0] + time.getMonSTime().split(":")[1].substring(0,1));
	resultE = Integer.parseInt("2"+time.getMonETime().split(":")[0] + time.getMonETime().split(":")[1].substring(0,1));

	for(int i=0;i<24;i++){
		for(int j=0;j<6;j++){
			String k = "";
			if(i<10){
				k = "0"+Integer.toString(i);
			}else{
				k = Integer.toString(i);
			}
			
			if(resultS <= Integer.parseInt("2"+k+j) && resultE >= Integer.parseInt("2"+k+j)&&(resultS+resultE)/2 != 2000){
				value = 1;
%>
			<script type="text/javascript">
				document.getElementById("result").value = document.getElementById("result").value + "2<%=k%><%=j%>/" ;
			</script>
<%
			}else{
				value = 0;
			}
%>
					<div class="drop <%=j==5?"end":"" %> <%=value==1?"dropped":"" %>" id="2<%=k%><%=j%>">&nbsp;</div>
<%
		}
%>
			
<%
	}
%>
				</div>
			</div>
			<div class="Name"><%=Lanfunc.language(lan, 98)%></div>
			<div class="Group">
				<div class="tueName">
<%
	for(int i=0;i<25;i++){
		if(i == 0){
%>
					<div class="first"><%=i%></div>
<%
		}else if(i == 24){
%>
			<div class="last"><%=i%></div>
<%		
		}else{
%>
					<div class="name"><%=i%></div>
<%		
		}
	}
%>
				</div>
				<div class="tue">
<%

	value = 0;
	resultS = Integer.parseInt("3"+time.getTueSTime().split(":")[0] + time.getTueSTime().split(":")[1].substring(0,1));
	resultE = Integer.parseInt("3"+time.getTueETime().split(":")[0] + time.getTueETime().split(":")[1].substring(0,1));
	
	for(int i=0;i<24;i++){
		for(int j=0;j<6;j++){
			String k = "";
			if(i<10){
				k = "0"+Integer.toString(i);
			}else{
				k = Integer.toString(i);
			}
			
			if(resultS <= Integer.parseInt("3"+k+j) && resultE >= Integer.parseInt("3"+k+j)&&(resultS+resultE)/2 != 3000){
				value = 1;
%>
				<script type="text/javascript">
					document.getElementById("result").value = document.getElementById("result").value + "3<%=k%><%=j%>/" ;
				</script>
<%
			}else{
				value = 0;
			}
			
%>
					<div class="drop <%=j==5?"end":"" %> <%=value==1?"dropped":"" %>" id="3<%=k%><%=j%>">&nbsp;</div>
<%
		}
%>
			
<%
	}
%>
				</div>
			</div>
			<div class="Name"><%=Lanfunc.language(lan, 99)%></div>
			<div class="Group">
				<div class="wedName">
<%
	for(int i=0;i<25;i++){
		if(i == 0){
%>
					<div class="first"><%=i%></div>
<%
		}else if(i == 24){
%>
			<div class="last"><%=i%></div>
<%		
		}else{
%>
					<div class="name"><%=i%></div>
<%		
		}
	}
%>
				</div>
				<div class="wed">
<%
	value = 0;
	resultS = Integer.parseInt("4"+time.getWedSTime().split(":")[0] + time.getWedSTime().split(":")[1].substring(0,1));
	resultE = Integer.parseInt("4"+time.getWedETime().split(":")[0] + time.getWedETime().split(":")[1].substring(0,1));
	
	for(int i=0;i<24;i++){
		for(int j=0;j<6;j++){
			String k = "";
			if(i<10){
				k = "0"+Integer.toString(i);
			}else{
				k = Integer.toString(i);
			}
			
			if(resultS <= Integer.parseInt("4"+k+j) && resultE >= Integer.parseInt("4"+k+j)&&(resultS+resultE)/2 != 4000){
				value = 1;
%>
			<script type="text/javascript">
				document.getElementById("result").value = document.getElementById("result").value + "4<%=k%><%=j%>/" ;
			</script>
<%
			}else{
				value = 0;
			}
			
%>
					<div class="drop <%=j==5?"end":"" %> <%=value==1?"dropped":"" %>" id="4<%=k%><%=j%>">&nbsp;</div>
<%
		}
%>
			
<%
	}
%>
				</div>
			</div>
			<div class="Name"><%=Lanfunc.language(lan, 100)%></div>
			<div class="Group">
				<div class="thuName">
<%
	for(int i=0;i<25;i++){
		if(i == 0){
%>
					<div class="first"><%=i%></div>
<%
		}else if(i == 24){
%>
			<div class="last"><%=i%></div>
<%		
		}else{
%>
					<div class="name"><%=i%></div>
<%		
		}
	}
%>
				</div>
				<div class="thu">
<%
	value = 0;
	resultS = Integer.parseInt("5"+time.getThuSTime().split(":")[0] + time.getThuSTime().split(":")[1].substring(0,1));
	resultE = Integer.parseInt("5"+time.getThuETime().split(":")[0] + time.getThuETime().split(":")[1].substring(0,1));
	for(int i=0;i<24;i++){
		for(int j=0;j<6;j++){
			String k = "";
			if(i<10){
				k = "0"+Integer.toString(i);
			}else{
				k = Integer.toString(i);
			}
			
			if(resultS <= Integer.parseInt("5"+k+j) && resultE >= Integer.parseInt("5"+k+j)&&(resultS+resultE)/2 != 5000){
				value = 1;
%>
			<script type="text/javascript">
				document.getElementById("result").value = document.getElementById("result").value + "5<%=k%><%=j%>/" ;
			</script>
<%
			}else{
				value = 0;
			}
			
%>
					<div class="drop <%=j==5?"end":"" %> <%=value==1?"dropped":"" %>" id="5<%=k%><%=j%>">&nbsp;</div>
<%
		}
%>
			
<%
	}
%>
				</div>
			</div>
			<div class="Name"><%=Lanfunc.language(lan, 101)%></div>
			<div class="Group">
				<div class="friName">
<%
	for(int i=0;i<25;i++){
		if(i == 0){
%>
					<div class="first"><%=i%></div>
<%
		}else if(i == 24){
%>
			<div class="last"><%=i%></div>
<%		
		}else{
%>
					<div class="name"><%=i%></div>
<%		
		}
	}
%>
				</div>
				<div class="fri">
<%
	value = 0;
	resultS = Integer.parseInt("6"+time.getFriSTime().split(":")[0] + time.getFriSTime().split(":")[1].substring(0,1));
	resultE = Integer.parseInt("6"+time.getFriETime().split(":")[0] + time.getFriETime().split(":")[1].substring(0,1));
	for(int i=0;i<24;i++){
		for(int j=0;j<6;j++){
			String k = "";
			if(i<10){
				k = "0"+Integer.toString(i);
			}else{
				k = Integer.toString(i);
			}
			
			if(resultS <= Integer.parseInt("6"+k+j) && resultE >= Integer.parseInt("6"+k+j)&&(resultS+resultE)/2 != 6000){
				value = 1;
%>
			<script type="text/javascript">
				document.getElementById("result").value = document.getElementById("result").value + "6<%=k%><%=j%>/" ;
			</script>
<%
			}else{
				value = 0;
			}
			
%>
					<div class="drop <%=j==5?"end":"" %> <%=value==1?"dropped":"" %>" id="6<%=k%><%=j%>">&nbsp;</div>
<%
		}
%>
			
<%
	}
%>
				</div>
			</div>
			<div class="Name"><%=Lanfunc.language(lan, 102)%></div>
			<div class="Group">
				<div class="satName">
<%
	for(int i=0;i<25;i++){
		if(i == 0){
%>
					<div class="first"><%=i%></div>
<%
		}else if(i == 24){
%>
					<div class="last"><%=i%></div>
<%		
		}else{
%>
					<div class="name"><%=i%></div>
<%		
		}
	}
%>
				</div>
				<div class="sat">
<%
	value = 0;
	resultS = Integer.parseInt("7"+time.getSatSTime().split(":")[0] + time.getSatSTime().split(":")[1].substring(0,1));
	resultE = Integer.parseInt("7"+time.getSatETime().split(":")[0] + time.getSatETime().split(":")[1].substring(0,1));
	
	for(int i=0;i<24;i++){
		for(int j=0;j<6;j++){
			String k = "";
			if(i<10){
				k = "0"+Integer.toString(i);
			}else{
				k = Integer.toString(i);
			}
			
			if(resultS <= Integer.parseInt("7"+k+j) && resultE >= Integer.parseInt("7"+k+j)&&(resultS+resultE)/2 != 7000){
				value = 1;
%>
				<script type="text/javascript">
					document.getElementById("result").value = document.getElementById("result").value + "7<%=k%><%=j%>/";
				</script>
<%
			}else{
				value = 0;
			}
%>
					<div class="drop <%=j==5?"end":"" %> <%=value==1?"dropped":"" %>" id="7<%=k%><%=j%>">&nbsp;</div>
<%
		}
%>
			
<%
	}
%>
				</div>
			</div>
		</div>






		<div class="buttom">
			<div class="image">
				<a href="#DeviceInfo" onclick="TimeZoneSubmit();"><img src="/TrustWinPro/action/image/interface/submit.png"></a>
				<a href="#DeviceInfo" onclick="TimeZoneDelete('<%=time.getTimeZoneNo()%>');"><img src="/TrustWinPro/action/image/interface/delete.png"></a>
			</div>
		</div>
	</form>
</div>
<form action="/TrustWinPro/action/page/TimeZoneDel.jsp" name="TimeZoneDel" id="TimeZoneDel" method="post">
	<input type="hidden" value="" name="num" id="num" />
</form>
<%
	}else{
		
	}
%>
<script>
$(".Loading").css("display","none");
</script>