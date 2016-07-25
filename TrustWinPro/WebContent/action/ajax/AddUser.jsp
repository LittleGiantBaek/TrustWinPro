<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	String depart = (String)request.getParameter("depart");




	int value = 0;
	String lan = (String)session.getAttribute("nation");
	LanguageFunc Lanfunc = new LanguageFunc();
	
	if(!depart.equals("")){
		Connection conn = null;
		String sql = "select UserID from member";
		int maxID = 0;
		try {
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
	conn = ds.getConnection();
	Statement pstmt = conn.createStatement();
	ResultSet rs = pstmt.executeQuery(sql);
	
	while(rs.next()){
		if(maxID < Integer.parseInt(rs.getString(1))){
	maxID = Integer.parseInt(rs.getString(1));
		}
	}
		
	rs.close();
	conn.close();
		}catch(Exception e){
	out.println("DB error!!.");
	e.printStackTrace();
		}
		
		maxID++;
		
		String SMaxId = Integer.toString(maxID);
		int idlen = SMaxId.length();
		
		for(int i = idlen; i<8;i++){
	SMaxId = "0" + SMaxId;
		}
	
		
		sql = "select * from depart where UpNumber = " + depart;
		
		try {
	Context init = new InitialContext();
	DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
	conn = ds.getConnection();
	Statement pstmt = conn.createStatement();
	
	ResultSet rs = pstmt.executeQuery(sql);
	
	while(rs.next()){
		value++;
	}
		
	rs.close();
	
	conn.close();
		}catch(Exception e){
	out.println("DB error!!.");
	e.printStackTrace();
		}
		
		
		if(value == 0){
	sql = "insert into member(UserID, FirstName, MiddleName, LastName, ID, Password, CardID,FacilityCode, department,CardID2,CompanyID,Position,TelOffice,EngagedDay,LatestPromoted,RetiredDay,License1,License2,License3,EMail,TelHome,MobilePhone,CarName,Photo,ZipCode,Address)"; 
	sql += " values('"+SMaxId+"','username','','',"+SMaxId+","+SMaxId+",'00"+SMaxId+"','00000','"+depart+"','1','"+SMaxId+"','None','None','2015-01-01','2015-01-01','2015-01-01','None','None','None','None','None','None','None','None','None','None')";
	
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		pstmt.executeUpdate(sql);
		
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
		}else{
			out.println(Lanfunc.language(lan, 128));
		}
	}
%>