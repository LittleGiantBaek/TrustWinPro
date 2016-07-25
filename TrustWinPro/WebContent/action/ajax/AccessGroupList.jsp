<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Access.*" %>
<%@ page import="com.Trustwin.Admin.Project.Device.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	int access= Integer.parseInt(request.getParameter("access"));
	int[] num = new int[1000];
	AccessFunc AcceFunc = new AccessFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	DeviceFunc Devfunc = new DeviceFunc();
	AccessDevice[] AcceDev = AcceFunc.SelAccessDevice(access);
	String lan = (String)session.getAttribute("nation");
	

	

	Connection conn = null;
	String sql = "select * from AccessGroup where idx = " + access;
	String group_name ="";
	try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		ResultSet rs = pstmt.executeQuery(sql);
		
		while(rs.next()){
			group_name = rs.getString(2);
		}
		conn.close();
	}catch(Exception e){
		out.println("DB error!!.");
		e.printStackTrace();
	}
	out.println("<tr id='tr" + access+ "'>");
	out.println("<td><input class='access_class' type='checkbox' name='AG_check' value='"+access+"'></td>");
	out.println("<td>" + group_name + "</td><td>");
	
	for(int i=0;i<AcceDev.length;i++){
		Device device = Devfunc.selDevice2(AcceDev[i].getDevice());
		out.println("<p style='margin:0;padding:0;'>" + device.getControllerName() + "</p>");
	}
	out.println("</td></tr>");
%>

