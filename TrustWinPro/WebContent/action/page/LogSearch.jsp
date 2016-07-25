<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.sql.*" %>
<%@ page import="javax.sql.*" %>
<%@ page import="javax.naming.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.Trustwin.Admin.Project.Category.*" %>
<%@ page import="com.Trustwin.Admin.Project.Language.*" %>
<%
	Connection conn = null;
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
	String Month = (String)request.getParameter("month");
	
	CategoryFunc func = new CategoryFunc();
	LanguageFunc Lanfunc = new LanguageFunc();
	
	String lan = (String)session.getAttribute("nation");
	if(Month != null){
		if(Integer.parseInt(Month) > 9){
	
		}else{
	Month = "0" + Month;
		}
	}
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
		SHour = "0";
		SMin = "0";
		SSec = "0";
		EHour = "0";
		EMin = "0";
		ESec = "0";
	}else{
		if((!SHour.equals("")&&!SHour.equals("null"))||(!SMin.equals("")&&!SMin.equals("null"))||(!SSec.equals("")&&!SSec.equals("null"))||(!EHour.equals("")&&!EHour.equals("null"))||(!EMin.equals("")&&!EMin.equals("null"))||(!ESec.equals("")&&!ESec.equals("null"))){
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
	
	if(Name == null){
		Name = "";
	}else{
		if(!Name.equals("")){
	where = where + " and EventName = '" + Name + "'";
		}
	}
	
	if(User == null){
		User = "";		
	}else{
		if(!User.equals("")){
	where = where + " and EventUserName = '" + User + "'";
		}
	}
	
	if(Month==null||Year==null){
		
	}else{
		if(!Month.equals("")&&!Year.equals("")){
	where = where + " and EventDate like '" + Year + "-" + Month + "-%' ";
		}
	}
	
	 
	int maxPageNum=-1;                 // 전체 페이지의 수.
	int limitPage,pagerSize = 10;              // limitPage : 마지막 페이지 넘버. pageSize : 페이지 넘버가 보여지는 간격.
	int currentPage = 0;
	if(request.getAttribute("currentPage")!=null){
		currentPage = Integer.parseInt((String)request.getAttribute("currentPage")); // 현재 페이지 
	}
	
	int top = 0;
	
	if(request.getParameter("Num")==null){
		top = 40;
	}else{
	 	top = Integer.parseInt(request.getParameter("Num"));
	}
	
	 
	String sql = "select top "+top+" EventType,EventDate,EventTime,EventPlace,EventName,EventUserID,EventUserName,EventDoorState,EventCompanyID from dbo.History  ";
	sql = sql + where;
	sql = sql +	" order by EventDate desc; ";
		try {
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement();
		
		ResultSet rs = pstmt.executeQuery(sql);
%>
<div id="userdata">
		<section class="sectionji">
		<ul class="ulji"></ul>
		<div>
			<form action="/TrustWinPro/action/index.jsp" name="searchLog" method="post">
				<input type="hidden" value="searchLog" name="logtype" />
				<input type="hidden" value="Log" name="content" />
				
				<p><div class = "headerji">
				<%=Lanfunc.language(lan, 71)%> : 
				</div>
				<input type="text" class="inputt" name="searchStartDate" id="searchStartDate" readonly="readOnly" value="<%=LangUtil.Empty(SDate)%>" readonly="readOnly" onclick="fnPopUpCalendar(searchStartDate,searchStartDate,'yyyy-mm-dd')" /> 
				~ <input type="text" class="inputt"  name="searchEndDate" id="searchEndDate" readonly="readOnly" value="<%=LangUtil.Empty(EDate)%>" readonly="readOnly" onclick="fnPopUpCalendar(searchEndDate,searchEndDate,'yyyy-mm-dd')" />
				</p>
				
				<p><div class = "headerji">
				<%=Lanfunc.language(lan, 106)%> : 
				</div>
				<select name="searchStartHour" class="hourselect" id="searchStartHour">
					<option value="0" >0</option>
<%
	for(int i=1;i<25;i++){
%>
					<option value="<%=i%>" <%=Integer.parseInt(SHour) == i ?"selected":""%> ><%=i%></option>
<%
	}
%>				
				</select>
			
				<select name="searchStartMinute" class="hourselect"  id="searchStartMinute">
					<option value="0" >00</option>
<%
	for(int i=1;i<61;i++){
%>
					<option value="<%=i%>" <%=Integer.parseInt(SMin) == i ?"selected":""%> ><%=i%></option>
<%
	}
%>				
				</select>
			
				<select name="searchStartSec" class="hourselect"  id="searchStartSec">
					<option value="0" >00</option>
<%
	for(int i=1;i<61;i++){
%>
					<option value="<%=i%>" <%=Integer.parseInt(SSec) == i ?"selected":""%> ><%=i%></option>
<%
	}
%>				
				</select>
				~
				<select name="searchEndHour" class="hourselect"  id="searchEndHour">
					<option value="0" >0</option>
<%
	for(int i=1;i<25;i++){
%>
					<option value="<%=i%>" <%=Integer.parseInt(EHour) == i ?"selected":""%> ><%=i%></option>
<%
	}
%>				
				</select>
				
				<select name="searchEndMinute" class="hourselect"  id="searchEndMinute">
					<option value="0" >00</option>
<%
	for(int i=1;i<61;i++){
%>
					<option value="<%=i%>" <%=Integer.parseInt(EMin) == i ?"selected":""%> ><%=i%></option>
<%
	}
%>				
				</select>
				
				<select name="searchEndSec" class="hourselect"  id="searchEndSec">
					<option value="0" >00</option>
<%
	for(int i=1;i<61;i++){
%>
					<option value="<%=i%>" <%=Integer.parseInt(ESec) == i ?"selected":""%> ><%=i%></option>
<%
	}
%>				
				</select>					
				</p>				
				
				
				<p><div class = "headerji">
				<%=Lanfunc.language(lan, 81)%> :
				</div>
				 <input type="text" class="inputt"  name="searchName" value="<%=Name%>" /> 
				 </p>
				 
				<p><div class = "headerji">
				 <%=Lanfunc.language(lan, 108)%> : 
				 </div>
				 <input type="text" class="inputt" name="searchUser" value="<%=User%>" />
				 </p>
				 
				<p><div class="headerji">
				<%=Lanfunc.language(lan, 91)%>
				</div> 
				<input name="content" type="hidden" value="Log" />
				<input name="Num" class="inputt" type="text" value="<%=top %>" size="20" />
				<input type="submit" name="submit" value="<%=Lanfunc.language(lan, 182)%>" class="ct-btn white" />
				</p>
			</form>
			</div>
		</section>
		
	<div  class="tablebor" id="logdata">
	<table border=1 cellspacing="0" class="titleEx1">
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
			<th><%=Lanfunc.language(lan, 72)%></th>
			<th><%=Lanfunc.language(lan, 73)%></th>
			<th><%=Lanfunc.language(lan, 74)%></th>
			<th><%=Lanfunc.language(lan, 75)%></th>
			<th><%=Lanfunc.language(lan, 76)%></th>
			<th><%=Lanfunc.language(lan, 77)%></th>
			<th><%=Lanfunc.language(lan, 78)%></th>
			<th><%=Lanfunc.language(lan, 79)%></th>
			<th><%=Lanfunc.language(lan, 80)%></th>
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
				int i = 0;
				while(rs.next()){
					if(i%2==0){
						out.println("<tr  class='odd'>");
					}else{
						out.println("<tr>");	
					}
%>
				<td class='date1'><%=rs.getString(1) %></td>
				<td class='date1'><%=rs.getString(2) %></td>
				<td class='date1'><%=rs.getString(3) %></td>
				<td class='date1'><%=rs.getString(4) %></td>
				<td class='date1'><%=rs.getString(5) %></td>
				<td class='date1'><%=rs.getString(6) %></td>
				<td class='date1'><%=rs.getString(7) %></td>
				<td class='date1'><%=rs.getString(8) %></td>
				<td class='date1'><%=rs.getString(9) %></td>
			</tr>
<%
					i++;
				}
				rs.close();
				conn.close();
				
%>	
		</tbody>
	</table>
	</div>
	
</div>
<%
		}catch(Exception e){
			out.println("DB error!!.");
			e.printStackTrace();
		}
%>