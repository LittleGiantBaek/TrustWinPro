/* top menu script*/
function topMenuOn(i){
	document.getElementById("menu0"+i).style.backgroundColor = "white";
	document.getElementById("menuA0"+i).style.color = "black";
}

function topMenuOff(i){
	document.getElementById("menu0"+i).style.backgroundColor = "black";
	document.getElementById("menuA0"+i).style.color = "white";
}

/* left menu script*/
function leftMenuOn(i){
	var obj = document.getElementById("leftBar0"+i);
	if(obj.style.display == 'block'){
		obj.style.display = "none";
	}else{
		obj.style.display = "block";
	}
	
}

function submit(v){
	var form = document.getElementById(v);
	form.acceptCharset = 'utf-8';
	form.submit();
}

function submitUser(v,i){
	var form = document.getElementById(v);
	form.userID.value = i;
	form.submit();
}

function submitDevice(v,i){
	var form = document.getElementById(v);
	form.deviceID.value = i;
	form.submit();
}

function check(value){
	value = value.replace(/\r\n/g, "");
    return value;
	
}

function submitEvent(v,w){
	var form = document.getElementById("Event");
	form.year.value = v;
	form.month.value = w;
	form.submit();
}

function changeYear(v,x,y){
	
	for(var i=y;i<=x;i++){
		if(i==v){
			document.getElementById(i).style.display = "block";
			document.getElementById("open"+i).style.display = "none";
			document.getElementById("close"+i).style.display = "inline";
		}else{
			document.getElementById(i).style.display = "none";
			document.getElementById("open"+i).style.display = "inline";
			document.getElementById("close"+i).style.display = "none";
		}
	}
}


function changeSpanDev(num,length,depth,idx,usernum){
	for(var i=0;i<length;i++){
		if(i==num){
			document.getElementById("span" + i).style.display = "none";
			document.getElementById("text" + i).style.display = "inline";	
			document.getElementById("GroupN").value = idx;
			document.getElementById("GroupD").value = depth+1;
		}else{
			document.getElementById("span" + i).style.display = "inline";
			document.getElementById("text" + i).style.display = "none";	
		}
		
	}
	if(usernum != null){
		document.getElementById("dev"+usernum).className = "";
		document.getElementById("dev"+usernum+"a").style.color = "#000000";	
	}
	
			
}

function changeSpanUser(num,length,depth,idx,usernum){
	for(var i=0;i<length;i++){
		if(i==num){
			document.getElementById("span" + i).style.display = "none";
			document.getElementById("text" + i).style.display = "inline";	
			document.getElementById("GroupN").value = idx;
			document.getElementById("GroupD").value = depth+1;
		}else{
			document.getElementById("span" + i).style.display = "inline";
			document.getElementById("text" + i).style.display = "none";	
		}
		
	}
	if(usernum != null){
		document.getElementById("user"+usernum).className = "";
	}
	
			
}

function changeInputBox(num){
	document.getElementById("text" + num).style.display = "none";
	document.getElementById("input" + num).style.display = "inline";
	document.getElementById("GroupName" + num).focus();
}

function UpdateDevice(name,idx){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/UpdateDevice.jsp",   
	    data: "deviceName="+name+"&idx="+idx,
	    success:function(args){   
	    	location.reload();
	    },   
	    error:function(e){  
	        alert(e.responseText);  
	    }  
	}); 
}

function UpdateDepart(name,idx){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/UpdateDepart.jsp",   
	    data: "name="+name+"&idx="+idx,
	    success:function(args){   
	    	location.reload();
	    },   
	    error:function(e){  
	        alert(e.responseText);  
	    }  
	}); 
}



function UserPrint(){
	form1 = document.allUser;
	window.open("/TrustWinPro/action/print/ManagePrint.jsp?div=User&searchFirstName="+form1.searchFirstName.value+"&searchMiddleName="+form1.searchMiddleName.value+"&searchLastName="+form1.searchLastName.value+"&searchDepartment="+form1.searchDepartment.value+"","printpopup","width=800, height=800, menubar=no, status=no, toolbar=no");
}

function PrintID(id){
	var DocumentContainer = document.getElementById(id);
	var WindowObject = window.open('', "PrintWindow","width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes");
	WindowObject.document.writeln("<html><head><link rel='stylesheet' type='text/css' href='/TrustWinPro/action/css/common.css' />" +
			"<script type=\"text/javascript\" src=\"/TrustWinPro/action/js/common.js\"></script>" +
			"</head><body onload=\"ieExecWB()\" style='width:700px;min-width:0;'><div id=\"print\">"+DocumentContainer.innerHTML+"</div></body></html>");
	WindowObject.
	WindowObject.document.close();
	WindowObject.close();
}

function ieExecWB()
{
	if( navigator.userAgent.indexOf("Chrome") < 0 ){
		
		// 웹 브라우저 컨트롤 생성
		var WebBrowser = '<OBJECT id=IEPageSetupX classid="clsid:41C5BC45-1BE8-42C5-AD9F-495D6C8D7586" codebase="/TrustWinPro/action/js/IEPageSetupX.cab#version=1,0,14,0" width=0 height=0>';
		 
		// 웹 페이지에 객체 삽입
		document.body.insertAdjacentHTML('beforeEnd', WebBrowser);
		
		
		IEPageSetupX.header = ""; 
		IEPageSetupX.footer = ""; 
		IEPageSetupX.leftMargin=6; 
		IEPageSetupX.rightMargin=5; 
		IEPageSetupX.topMargin=10; 
		IEPageSetupX.bottomMargin=10; 
		IEPageSetupX.Preview(); 
		

	}else{
		window.print();
	}
	
}

function UserExcel(form,FN,MN,LN,DP){
	var arrayObj = "";
	var count = 0;
	for(var i=0;i<form.info.length;i++){
		if(form.info[i].checked){
			arrayObj = arrayObj + form.info[i].value + ",";
			count++;
		}
	}
	window.open("/TrustWinPro/action/print/ExcelUser.jsp?array="+arrayObj+"&FN="+FN+"&MN="+MN+"&LN="+LN+"&DP="+DP+"","printpopup","width=800, height=800, menubar=no, status=no, toolbar=no");
}


function DevicePrint(){
	form1 = document.allDevice;
	window.open("/TrustWinPro/action/print/ManagePrint.jsp?div=Device&searchControllerName="+form1.searchControllerName.value+"&searchAddress="+form1.searchAddress.value+"&searchID="+form1.searchID.value+"&searchUniqueID="+form1.searchUniqueID.value+"","printpopup","width=800, height=800, menubar=no, status=no, toolbar=no");
}

function DevicePrintID(id){
	var DocumentContainer = document.getElementById(id);
	var WindowObject = window.open('', "PrintWindow","width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes");
	WindowObject.document.writeln("<html><head><link rel='stylesheet' type='text/css' href='/TrustWinPro/action/css/common.css' />" +
			"<script type=\"text/javascript\" src=\"/TrustWinPro/action/js/common.js\"></script>" +
			"</head><body onload=\"ieExecWB()\" style='width:700px;min-width:0;'><div id=\"print\">"+DocumentContainer.innerHTML+"</div></body></html>");
	WindowObject.
	WindowObject.document.close();
	WindowObject.close();
}


function DeviceExcel(form,CN,Add,ID,UID){
	var arrayObj = "";
	var count = 0;
	for(var i=0;i<form.info.length;i++){
		if(form.info[i].checked){
			arrayObj = arrayObj + form.info[i].value + ",";
			count++;
		}
	}
	window.open("/TrustWinPro/action/print/ExcelDevice.jsp?array="+arrayObj+"&CN="+CN+"&Add="+Add+"&ID="+ID+"&UID="+UID+"","printpopup","width=800, height=800, menubar=no, status=no, toolbar=no");
}


function EventPrint(){
	form1 = document.allEvent;
	window.open("/TrustWinPro/action/print/ManagePrint.jsp?div=Event&SDate="+form1.SDate.value+"&EDate="+form1.EDate.value+"&STime="+form1.STime.value+"&ETime="+form1.ETime.value+"&Name="+form1.searchName.value+"&User="+form1.searchUser.value+"&Num="+form1.Num.value+"","printpopup","width=800, height=800, menubar=no, status=no, toolbar=no,scrollbars=yes");
}

function EventPrintID(id){
	var DocumentContainer = document.getElementById(id);
	var WindowObject = window.open('', "PrintWindow","width=750,height=650,top=50,left=50,toolbars=no,scrollbars=yes,status=no,resizable=yes");
	WindowObject.document.writeln("<html><head><link rel='stylesheet' type='text/css' href='/TrustWinPro/action/css/common.css' />" +
			"<script type=\"text/javascript\" src=\"/TrustWinPro/action/js/common.js\"></script>" +
			"</head><body onload=\"ieExecWB()\" style='width:700px;min-width:0;'><div id=\"print\">"+DocumentContainer.innerHTML+"</div></body></html>");
	WindowObject.
	WindowObject.document.close();
	WindowObject.close();
}


function EventExcel(form,SDate,EDate,STime,ETime,Name,User,Num){
	var arrayObj = "";
	var count = 0;
	for(var i=0;i<form.info.length;i++){
		if(form.info[i].checked){
			arrayObj = arrayObj + form.info[i].value + ",";
			count++;
		}
	}
	window.open("/TrustWinPro/action/print/ExcelEvent.jsp?array="+arrayObj+"&SDate="+SDate+"&EDate="+EDate+"&STime="+STime+"&ETime="+ETime+"&Name="+Name+"&User="+User+"&Num="+Num+"","printpopup","width=800, height=800, menubar=no, status=no, toolbar=no");
}


function Enroll(value){
	$.ajax({      
	    type:"post",
	    url:"/TrustWinPro/action/ajax/SendServer.jsp",   
	    data: "Data="+value,
	    success:function(args){
	    	alert(args);
	    	if(args.trim() == 'success'){
	    		alert("success");
	    	}else{
	    		alert("fail");
	    	}
	    },   
	    error:function(e){  
	        alert(e.responseText);
	    }  
	}); 
}

function Delete(value){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/SendServer.jsp",   
	    data: "Data="+value,
	    success:function(args){
	    	alert(args);
	    	if(args.trim() == 'success'){
	    		alert("success");
	    	}else{
	    		alert("fail");
	    	}
	    },   
	    error:function(e){  
	        alert(e.responseText);  
	    }  
	}); 
}

function Recive(value){
	$.ajax({      
	    type:"post",  
	    url:"/TrustWinPro/action/ajax/SendServer.jsp",   
	    data: "Data="+value,
	    success:function(args){
	    	alert(args);
	    	if(args.trim()  == 'success'){
	    		alert("success");
	    	}else{
	    		alert("fail");
	    	}
	    },   
	    error:function(e){  
	        alert(e.responseText);  
	    }  
	}); 
}


function setupMove(){
	document.getElementById("mapsetup").submit();
}

