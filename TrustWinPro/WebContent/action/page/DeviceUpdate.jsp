<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.File" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.Date" %>
<%
	String realFolder = "";
	String filename1 = "";
	int maxSize = 1024*1024*5;
	String encType = "euc-kr";
	String savefile = "img";
	ServletContext scontext = getServletContext();
	realFolder = scontext.getRealPath("upload/image/device/");
	String realFileName = "";
	MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	try{
		Enumeration<?> files = multi.getFileNames();
		String file1 = (String)files.nextElement();
		filename1 = multi.getFilesystemName(file1);
		
		String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date()); 
	    int i = -1;
		if(filename1 != null){
        	i = filename1.lastIndexOf("."); // ���� Ȯ���� ��ġ
	        realFileName = now + filename1.substring(i, filename1.length());  
		}
        
        String f_ext = ""; 
        String filename = ""; 
        if(filename1 != null){ 
        	File file_copy = new File(realFolder+"/"+filename1); 
        	if(file_copy.exists()) { 
        	f_ext = filename1.substring(filename1.length()-3,filename1.length()); 
        	java.io.File file2 = new java.io.File(realFolder+"/"+now+"."+f_ext); 
        	file_copy.renameTo(file2); 
        	filename = file2.getName()+"/"+filename1; 
        	} 
        } 
        
        
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	Connection conn = null;
	
	String sql = "update SetupTcpip set ControllerName = '"+multi.getParameter("controllerName")+"', id = '"+multi.getParameter("idm")+"', address = '"+multi.getParameter("address")+"', port = "+multi.getParameter("port")
				+ ", Password = '"+multi.getParameter("Password")+"'"+ ", uniqueid = '"+multi.getParameter("uniqueid")+"'"+ ", serverport = '"+multi.getParameter("serverport")+"', "
				+ "DoorRelay = '"+multi.getParameter("DoorRelay")+"', DoorMode = '"+multi.getParameter("DoorMode")+"', DoorTime = '"+multi.getParameter("DoorTime")+"', DoorAlarm = '"+multi.getParameter("DoorAlarm")+"', CdType = '"+multi.getParameter("CdType")+"', ReAccess = '"+multi.getParameter("ReAccess")+"', Cd2Fun = '"+multi.getParameter("Cd2Fun")+"', AlmRelayFun = '"+multi.getParameter("AlmRelayFun")+"', AlmBuzzFun = '"+multi.getParameter("AlmBuzzFun")+"',"  
				+ "AntiPass = '"+multi.getParameter("AntiPass")+"', Fire = '"+multi.getParameter("Fire")+"', IdSecret = '"+multi.getParameter("IdSecret")+"', Limit = '"+multi.getParameter("Limit")+"', VoiceOut = '"+multi.getParameter("VoiceOut")+"', MachineID = '"+multi.getParameter("MachineID")+"', Baudrate = '"+multi.getParameter("Baudrate")+"', DeviceTime = '"+multi.getParameter("DeviceTime")+"', UserCount = '"+multi.getParameter("UserCount")+"', ManagerCount = '"+multi.getParameter("ManagerCount")+"'," 
				+ "FpCount = '"+multi.getParameter("FpCount")+"', CardCount = '"+multi.getParameter("CardCount")+"', SLogTotal = '"+multi.getParameter("SLogTotal")+"', SLogRead = '"+multi.getParameter("SLogRead")+"', GLogTotal = '"+multi.getParameter("GLogTotal")+"', GLogRead = '"+multi.getParameter("GLogRead")+"', CurDoorMode = '"+multi.getParameter("CurDoorMode")+"', DoorStatus = '"+multi.getParameter("DoorStatus")+"', MPCI = '"+multi.getParameter("MPCI")+"', BGI = '"+multi.getParameter("BGI")+"' ";
	if(filename1 != null){
		sql = sql + " , photo = '"+realFileName + "'";
	}
	sql = sql +" where id = '"+multi.getParameter("id")+"';";	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		pstmt.executeUpdate(sql);
		
		pstmt.close();
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	sql = "update Sunshine set DeviceID = "+multi.getParameter("idm")+", SYear = "+multi.getParameter("StartTime").split("-")[0]+", SMonth = "+multi.getParameter("StartTime").split("-")[1]+", SDay = "+multi.getParameter("StartTime").split("-")[2]+", SHour = "+multi.getParameter("SHour")
				+ ", SMinute = "+multi.getParameter("SMinute")+""+ ", SCYear = "+multi.getParameter("ChangeSTime").split("-")[0]+""+ ", SCMonth = "+multi.getParameter("ChangeSTime").split("-")[1]+", SCDay = "+multi.getParameter("ChangeSTime").split("-")[2]
				+ ", SCHour = "+multi.getParameter("SCHour") + ", SCMinute = "+multi.getParameter("SCMinute") + ", RYear = "+multi.getParameter("CombackTime").split("-")[0] + ", RMonth = "+multi.getParameter("CombackTime").split("-")[1] + ", RDay = "+multi.getParameter("CombackTime").split("-")[2]
				+ ", RHour= "+multi.getParameter("RHour") + ", RMinute= "+multi.getParameter("RMinute") + ", RCYear= "+multi.getParameter("ChangeETime").split("-")[0] + ", RCMonth= "+multi.getParameter("ChangeETime").split("-")[1] + ", RCDay= "+multi.getParameter("ChangeETime").split("-")[2] + ", RCHour= "+multi.getParameter("RCHour") + ", RCMinute = "+multi.getParameter("RCMinute") + "";
	sql = sql +" where DeviceID = "+multi.getParameter("id")+";";	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		pstmt.executeUpdate(sql);
		
		pstmt.close();
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	sql = "update ManageMode set DeviceID = "+multi.getParameter("idm")+",";  
	for(int i=1;i<11;i++){
		if(i!=1){
			sql = sql + ", ";
		}
	 sql = sql + " week" + i + " = "+multi.getParameter("WeekO" + i)+", SHour" + i + " = "+multi.getParameter("SHourO" + i)+", SMinute" + i + " = "+multi.getParameter("SMinuteO")+", EHour"+i+" = "+multi.getParameter("EHourO" + i)+", EMinute"+i+" = "+multi.getParameter("EMinuteO" + i)+", Manage"+i+" = "+multi.getParameter("OperateModeO" + i);
	}
	sql = sql +" where DeviceID = "+multi.getParameter("id")+";"; 

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		pstmt.executeUpdate(sql);
		
		pstmt.close();
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	sql = "update AlarmTime set DeviceID = "+multi.getParameter("idm")+",";  
	for(int i=1;i<11;i++){		
		if(i!=1){
			sql = sql + ", ";
		}
	 	sql = sql + " week" + i + " = "+multi.getParameter("WeekA1" + i)+", SHour" + i + " = "+multi.getParameter("SHourA1" + i)+", SMinute" + i + " = "+multi.getParameter("SMinuteA1" + i)+", Sec"+i+" = "+multi.getParameter("TimeA1" + i);
	}
	for(int i=1;i<11;i++){		
	 	sql = sql + ", week" + (i+10) + " = "+multi.getParameter("WeekA2" + i)+", SHour" + (i+10) + " = "+multi.getParameter("SHourA2" + i)+", SMinute" + (i+10) + " = "+multi.getParameter("SMinuteA2"+i)+", Sec"+(i+10)+" = "+multi.getParameter("TimeA2" + i);
	}
	sql = sql +" where DeviceID = "+multi.getParameter("id")+";"; 
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		pstmt.executeUpdate(sql);
		
		pstmt.close();
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	sql = "update AutoDoor set DeviceID = "+multi.getParameter("idm")+",";  
	for(int i=1;i<11;i++){
		if(i!=1){
			sql = sql + ", ";
		}
	 	sql = sql + " week" + i + " = "+multi.getParameter("WeekAD" + i)+", SHour" + i + " = "+multi.getParameter("SHourAD" + i)+", SMinute" + i + " = "+multi.getParameter("SMinuteAD" + i)+", EHour"+i+" = "+multi.getParameter("EHourAD" + i)+", EMinute"+i+" = "+multi.getParameter("EMinuteAD" + i);
	}
	sql = sql +" where DeviceID = "+multi.getParameter("id")+";"; 

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		pstmt.executeUpdate(sql);
		
		pstmt.close();
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	sql = "update AutoKey set DeviceID = "+multi.getParameter("idm")+",";  
	for(int i=1;i<11;i++){		
		if(i!=1){
			sql = sql + ", ";
		}
	 	sql = sql + " week" + i + " = "+multi.getParameter("WeekAK" + i)+", SHour" + i + " = "+multi.getParameter("SHourAK" + i)+", SMinute" + i + " = "+multi.getParameter("SMinuteAK" + i)+", EHour"+i+" = "+multi.getParameter("EHourAK" + i)+", EMinute"+i+" = "+multi.getParameter("EMinuteAK" + i)+", Key"+i+" = "+multi.getParameter("FunctionKeyAK" + i);
	}
	sql = sql +" where DeviceID = "+multi.getParameter("id")+";"; 

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		pstmt.executeUpdate(sql);
		
		pstmt.close();
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	
	sql = "update NoActKey set DeviceID = "+multi.getParameter("idm")+",";  
	sql = sql + " FirstKey = " + multi.getParameter("OneFK") + " ,SecondKey = " + multi.getParameter("TwoFK") + " ,ThirdKey = " + multi.getParameter("ThreeFK")+ " ,FourthKey = " + multi.getParameter("FourFK"); 
	sql = sql +" where DeviceID = "+multi.getParameter("id")+";"; 

	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		pstmt.executeUpdate(sql);
		
		pstmt.close();
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<script type="text/javascript">
			function replace(){
				document.getElementById("Device").submit();	
			}
		</script>
	</head>
	<body onload="replace();">
		<form action="/TrustWinPro/action/index.jsp" name="="Device" id="Device" method="post">
			<input type="hidden" value="Device" name="left" />
			<input type="hidden" value="<%=multi.getParameter("idm")%>" name="deviceID" />
			<input type="hidden" value="DeviceInfo" name="content" />
		</form>
	</body>
</html>