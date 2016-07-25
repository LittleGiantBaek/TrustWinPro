var now = new Date();
var show_date = new Date();

function getFullYear(date)
{
	fullyear = date.getFullYear();
	if (fullyear < 1000) fullyear = fullyear + 1900;
	return fullyear;
}


function viewCA(obj,type){
	var str="";
	str=str+"<table width=160 bgcolor='#CCCCCC' cellspacing=1 cellpading=0><tr><td align=center bgcolor='#FFFFFF'><form name=date_list><table width=150><tr><td align=right>";
	str=str+"<select class='input2' name=year onchange=change_year(this.options[this.options.selectedIndex],'"+obj+"','"+type+"')  style='width: 80;'>";
	for(i=(now.getFullYear()+1);i>1900;i--){
		var now_date = new Date();
		if (show_date.getFullYear() != i){str=str+"<option value="+i+">"+i;}
		else{str=str+"<option value="+i+" selected>"+i;}
	}
	str=str+"</select>";
	str=str+"</td><td style='padding-left: 10'>";

	str=str+"<select class='input2' name=month onchange=change_month(this.options.selectedIndex,'"+obj+"','"+type+"') style='width:60;'>";
	for(i=1;i<13;i++){
		if (  parseInt(show_date.getMonth())+1 ==i){str=str+"<option value='"+i+"' selected>"+i+"월";}
		else{str=str+"<option value='"+i+"'>"+i+"월";}
	}
	str=str+"</select></td></tr><tr><td colspan=2><center>";

	str=str+"<table bgcolor='#CCCCCC' cellspacing=1 cellpading=0 width=150 height=130 border=0 ><tr height=20 bgcolor=#F3F3F3 align=center valign=middle style='COLOR: #333333; font-family: 돋움, 굴림, Tahoma, Verdana; font-size: 12px;'>";
	str=str+"<td>월</td><td>화</td><td>수</td><td>목</td><td STYLE='COLOR: GREEN'>금</td><td STYLE='COLOR: #009ACE'>토</td><td STYLE='COLOR: RED'>일</td>";
	str=str+"</tr>";

	for(j=0;j<6;j++){
		str=str+"<tr>";
		for(i=0;i<7;i++) {
			str=str+"<td class=SubTitle_03 align=center id=d"+i+"r"+j+" bgcolor='#FFFFFF' align='center' ></td>";
		} 
		str=str+"</tr>";
	}
		str=str+"</table>";
		str=str+"</center></from></td></tr>"
		str=str+"<tr><td height='20' colspan='2' width='150' align='right'><a href='javascript:dateCL();'><img src='/admin/image/close.gif' border='0'></a></td></tr>"
		str=str+"</table></td></tr></table>";
	document.all.dateLY.innerHTML = str;
	document.all.dateLY.style.left = event.x;
	document.all.dateLY.style.top = event.y+document.body.scrollTop-180;
	document.all.dateLY.style.display = "block";
	set_cal(show_date,obj,type);
}

function dateCL(){
	document.all.dateLY.style.display = "none";
}

function set_cal(show_date,obj,type){
	begin_day = new Date (show_date.getFullYear(),show_date.getMonth(),1);
	begin_day_date = begin_day.getDay();
	end_day = new Date (show_date.getFullYear(),show_date.getMonth()+1,1);
	count_day = (end_day - begin_day)/"1000"/"60"/"60"/"24";
	input_table(begin_day_date,count_day,obj,type);
}

function input_table(begin,count,obj,type){
	init();
	j=0;
	if (begin!=0){i=begin-1;}else{i=6}
	for (c=1;c<count+1;c++){
		colum_name = eval("d"+i+"r"+j);
		if ((now.getDate() == c)&&(show_date.getMonth() == now.getMonth())&&(show_date.getFullYear() == now.getFullYear())){
			colum_name.style.backgroundColor = "#5F9cA8";colum_name.style.color = "#FFFFFF";
		}
		ck_y = show_date.getFullYear();
		ck_m = ""+(show_date.getMonth()+1);
		ck_c = ""+c;
		if (ck_m.length<2){ ck_m ="0"+ck_m; }
		if (ck_c.length<2){ ck_c ="0"+ck_c; }
		ck_day = ck_y +type+ ck_m +type+ ck_c;
		colum_name.innerHTML = "<a onclick='"+obj+".value=\""+ck_day+"\";document.all.dateLY.style.display=\"none\"' style='cursor:hand'>"+c+"<a>";
		i++;
		if (i==7){i=0;j++;colum_name.style.color ="#FFFFFF";}
		if (i==6) colum_name.style.color ="#006699";
		if (i==0) colum_name.style.color ="#CC0000";
	}
}

function init(){
	for(j=0;j<6;j++){
	 for(i=0;i<7;i++){
		 colum_name = eval("d"+i+"r"+j);
		 colum_name.innerText = " ";
		 colum_name.style.backgroundColor = "";
		 colum_name.style.color = "#333333";
	 }
	}
}

function change_month(sel_month,obj,type){
	show_date = new Date(show_date.getFullYear(),sel_month,1);
	set_cal(show_date,obj,type);
}

function change_year(sel_year,obj,type){
	sel_year = sel_year.value;
	show_date = new Date(sel_year,show_date.getMonth(),1);
	set_cal(show_date,obj,type);
}