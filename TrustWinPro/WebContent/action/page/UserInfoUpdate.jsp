<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
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
	realFolder = scontext.getRealPath("upload/image/user/");
	String realFileName = "";
	MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, "utf-8", new DefaultFileRenamePolicy());
	try{
		
		Enumeration<?> files = multi.getFileNames();
		String file1 = (String)files.nextElement();
		filename1 = multi.getFilesystemName(file1);
		
		String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());  //현재시간
	    int i = -1;
        
        String f_ext = ""; 
        String filename = ""; 
        if(filename1 != null){ 
        	i = filename1.lastIndexOf("."); // 파일 확장자 위치
            realFileName = now + filename1.substring(i, filename1.length());  //현재시간과 확장자 합치기
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
	String fullpath = request.getContextPath() + "/upload/image/user/"  + filename1;

	String depart = (String)multi.getParameter("depart");
	String userid = multi.getParameter("userID");
	
	for(int i = userid.length();i<8;i++){
		userid = "0" + userid;
	}
	Connection conn = null;

	
	String sql = "update member set FirstName = '"+multi.getParameter("firstName")+"', MiddleName = '"+multi.getParameter("middleName")+"', LastName = '"+multi.getParameter("lastName")+"', UserClass = '"+multi.getParameter("userClass")+"', ID = '"+multi.getParameter("ID")+"', Password = '"+multi.getParameter("Password")+"', CompanyID = '"+multi.getParameter("CompanyID")+"', Department = '"+multi.getParameter("Department")+"', "+
			"Position = '"+multi.getParameter("Position")+"', TelOffice = '"+multi.getParameter("TelOffice")+"', EngagedDay = '"+multi.getParameter("EngagedDay")+"', LatestPromoted = '"+multi.getParameter("LatestPromoted")+"', RetiredDay = '"+multi.getParameter("RetiredDay")+"', License1 = '"+multi.getParameter("License1")+"', License2 = '"+multi.getParameter("License2")+"', License3 = '"+multi.getParameter("License3")+"', HourlyWage = '"+multi.getParameter("HourlyWage")+"', EMail = '"+multi.getParameter("Email")+"', Sex = '"+multi.getParameter("Sex")+"', "+
			"Married = '"+multi.getParameter("Married")+"', ResidentRegNo = '"+multi.getParameter("ResidentRegNo")+"', TelHome = '"+multi.getParameter("TelHome")+"', MobilePhone = '"+multi.getParameter("MobilePhone")+"', CarName = '"+multi.getParameter("CarName")+"', ZipCode = '"+multi.getParameter("Zipcode")+"', Address = '"+multi.getParameter("Address")+"', CardID = '"+multi.getParameter("CardID")+"', CardType = '"+multi.getParameter("CardType")+"', FacilityCode = '"+multi.getParameter("FacilityCode")+"', CardAttribute = '"+multi.getParameter("CardAttribute")+"', "+
			"TimeZoneNo1 = '"+multi.getParameter("TimeZoneNo1")+"', TimeZoneNo2 = '"+multi.getParameter("TimeZoneNo2")+"', UserMode = '"+multi.getParameter("UserMode")+"', UseSubSensor = "+ (multi.getParameter("UseSubSensor").equals("")?"0":multi.getParameter("UseSubSensor")) +", UseDuressFinger = "+(multi.getParameter("UseSubSensor").equals("")?"0":multi.getParameter("UseDuressFinger")) + ",ReAccessLimitTime ='"+multi.getParameter("ReAccessLimitTime")+"', DeviceGroup = '" + (multi.getParameter("Device").equals("")?"0":multi.getParameter("Device")) + "' ";
			

	if(filename1 != null){
		sql = sql + " , photo = '"+realFileName + "'";
	}
	sql = sql +" where UserID = '"+userid+"';";	

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
				document.getElementById("User").submit();	
			}
		</script>
	</head>
	<body onload="replace();">
		<div id="Loading" class="Loading" >
			<div class="backImg">&nbsp;</div>
		</div>
		<form action="/TrustWinPro/action/index.jsp" name="User" id="User" method="get">
			<input type="hidden" value="User" name="left" />
			<input type="hidden" value="<%=userid%>" name="userID" />
			<input type="hidden" value="UserInfo" name="content" />
		</form>
	</body>
</html>