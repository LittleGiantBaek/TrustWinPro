<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
	String encType = "utf-8";
	String savefile = "img";
	ServletContext scontext = getServletContext();
	realFolder = scontext.getRealPath("upload/image/Map/");
	String realFileName = "";
	MultipartRequest multi=new MultipartRequest(request, realFolder, maxSize, encType, new DefaultFileRenamePolicy());
	
	try{
		Enumeration<?> files = multi.getFileNames();
		String file1 = (String)files.nextElement();
		filename1 = multi.getFilesystemName(file1);
		
		String now = new SimpleDateFormat("yyyyMMddHmsS").format(new Date());  
	    int i = -1;
		if(filename1 != null){
        	i = filename1.lastIndexOf("."); 
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
	
	String sql = "update Map set name = '" + multi.getParameter("mapName") + "'";

	if(filename1 != null){
		sql = sql + " , image = '"+realFileName + "'";
	}
	sql = sql +" where idx = '"+multi.getParameter("id")+"';";	
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
				document.getElementById("Map").submit();	
			}
		</script>
	</head>
	<body onload="replace();">
		<form action="/TrustWinPro/action/index.jsp" name="Map" id="Map" method="post">
			<input type="hidden" value="Monitoring" name="left" />
			<input type="hidden" value="<%=multi.getParameter("id")%>" name="mapID" />
			<input type="hidden" value="Map" name="content" />
		</form>
	</body>
</html>