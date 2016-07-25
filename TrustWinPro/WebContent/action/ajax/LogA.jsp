<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="com.Trustwin.Admin.Project.Event.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	String SDate = (String)request.getParameter("searchStartDate");
	String EDate = (String)request.getParameter("searchEndDate");
	String SHour = (String)request.getParameter("searchStartHour");
	String SMin = (String)request.getParameter("searchStartMinute");
	String SSec = (String)request.getParameter("searchStartSec");
	String EHour = (String)request.getParameter("searchEndHour");
	String EMin = (String)request.getParameter("searchEndMinute");
	String ESec = (String)request.getParameter("searchEndSec");
	String Name = (String)request.getParameter("searchName");
	String User = (String)request.getParameter("searchUser");
	String Num = (String)request.getParameter("num");
	EventFunc Evtfunc = new EventFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	String lan = (String)session.getAttribute("nation");
	if(Num == null){
		Num = "40";
	}
	Connection conn = null;
	String sql = "select EventType,EventDate,EventTime,EventPlace,EventName,EventUserID,EventUserName,EventDoorState,EventCompanyID from dbo.History"; 
	
	String Year = (String)request.getParameter("year");
	String where = " where 1=1 ";
	
	if(SDate == null || EDate ==null){
		SDate = "";
		EDate = "";
	}else{
		if((!SDate.equals("")&&!SDate.equals("null"))||(!EDate.equals("")&&!EDate.equals("null"))){
	where = where + " and EventDate between '" + SDate + "' and '"+EDate+"'";
		}
	} 
	
	if(SHour == null || SMin == null || SSec == null || EHour == null || EMin == null || ESec == null){
		SHour = "";
		SMin = "";
		SSec = "";
		EHour = "";
		EMin = "";
		ESec = "";
	}else{
		if((!SHour.equals("")&&!SHour.equals("null"))||(!SMin.equals("")&&!SMin.equals("null"))||(!SSec.equals("")&&!SSec.equals("null"))||(!EHour.equals("")&&!EHour.equals("null"))||(!EMin.equals("")&&!EMin.equals("null"))||(!ESec.equals("")&&!ESec.equals("null"))){
	if((!SHour.equals("0")&&!EHour.equals("0"))){
		if(Integer.parseInt(SHour)<10){
	SHour = "0" + SHour;
		}
		if(Integer.parseInt(SMin)<10){
	SMin = "0" + SMin;
		}
		if(Integer.parseInt(SSec)<10){
	SSec = "0" + SSec;
		}
		if(Integer.parseInt(EHour)<10){
	EHour = "0" + EHour;
		}
		if(Integer.parseInt(EMin)<10){
	EMin = "0" + EMin;
		}
		if(Integer.parseInt(ESec)<10){
	ESec = "0" + ESec;
		}
		where = where + " and EventTime between '" + SHour + ":"+SMin+":"+SSec+"' and '" + EHour + ":"+EMin+":"+ESec+"'";
	}
		}
	}
	
	if(Name == null){
		Name = "";
	}else{
		if(!Name.equals("")&&!Name.equals("null")){
	where = where + " and EventName = '" + Name + "'";
		}
	}
	
	if(User == null){
		User = "";		
	}else{
		if(!User.equals("")&&!User.equals("null")){
	where = where + " and EventUserName = '" + User + "'";
		}
	}
	
	sql = sql + where;
	sql = sql + " order by EventDate desc,EventTime desc; ";
		try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		ResultSet rs = pstmt.executeQuery(sql);
%>
	<table cellspacing="0"  class="titleEx1">
		<colgroup>
			<col width="9%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="14%">
			<col width="10%">
			<col width="12%">
			<col width="12%">
			<col width="13%">
		</colgroup>
		<tr>
			<th><%=Lanfunc.language(lan, 72) %></th>
			<th><%=Lanfunc.language(lan, 73) %></th>
			<th><%=Lanfunc.language(lan, 74) %></th>
			<th><%=Lanfunc.language(lan, 75) %></th>
			<th><%=Lanfunc.language(lan, 76) %></th>
			<th><%=Lanfunc.language(lan, 77) %></th>
			<th><%=Lanfunc.language(lan, 78) %></th>
			<th><%=Lanfunc.language(lan, 79) %></th>
			<th><%=Lanfunc.language(lan, 80) %></th>
		</tr>
	</table>
	<table cellspacing="0"  class="ex1">
		<colgroup>
			<col width="9%">
			<col width="10%">
			<col width="10%">
			<col width="10%">
			<col width="14%">
			<col width="10%">
			<col width="12%">
			<col width="12%">
			<col width="13%">
		</colgroup>
		<tbody>
	
<%
				int count = 0;
				for(int i=0;;){
					if(!rs.next()){
						break;
					}
					if(Integer.parseInt(Num) == i){
						break;
					}
					
					EventOption eo = Evtfunc.selOptionType(rs.getString(5));
					String color = eo.getColor();
					if(eo.getDisplay()!=null){
						if(eo.getDisplay().equals("1")){
							if(color != null){
								if(i%2==0){
									out.println("<tr  class='odd' style='color:#"+eo.getColor()+";'>");
								}else{
									out.println("<tr style='color:#"+eo.getColor()+";'>");	
								}
							}else{
								if(i%2==0){
									out.println("<tr  class='odd'>");
								}else{
									out.println("<tr>");	
								}
							}
							out.println("<td class='date1'>" + rs.getString(1) + "</td>");
							out.println("<td class='date1'>" + rs.getString(2) + "</td>");
							out.println("<td class='date1'>" + rs.getString(3) + "</td>");
							out.println("<td class='date1'>" + rs.getString(4) + "</td>");
							out.println("<td class='date1'>" + rs.getString(5) + "</td>");
							out.println("<td class='date1'>" + rs.getString(6) + "</td>");
							out.println("<td class='date1'>" + rs.getString(7) + "</td>");
							out.println("<td class='date1'>" + rs.getString(8) + "</td>");
							out.println("<td class='date1'>" + rs.getString(9) + "</td>");
							out.println("</tr>");
							i++;
						}else{
							
						}
					}else{
						
					}
				}
%>
		</tbody>
	</table>
<%
				rs.close();
				conn.close();
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
%>