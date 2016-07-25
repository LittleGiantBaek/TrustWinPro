package com.Trustwin.Admin.Project.Event;

import java.sql.Connection;
import java.util.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.Trustwin.Admin.Project.Language.Language;

public class EventFunc {

	public int[] EventYear(){
		int num[] = {0,0};
		Connection conn = null;
		String sql = "select top 1 eventdate from dbo.History order by eventdate desc;";
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
					
				while(rs.next()){
					num[0] = Integer.parseInt(rs.getString(1).substring(0,4));
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		sql = "select top 1 eventdate from dbo.History order by eventdate asc;";
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
					
				while(rs.next()){
					num[1] = Integer.parseInt(rs.getString(1).substring(0,4));
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return num;
		
	}

	// UserInfo
	public Event[] EventDefind(String start, String end, String id) {

		
		Connection conn = null;
		Event[] eventG = null;
		Event event = new Event();
		
		String where = " where 1=1 and EventUserID = '" + id + "'";
		
		if((start == null || start == "" ) || (end == null || end == "")){
			start = "";
			end = "";
		}else{
			if(!start.equals("")){
				int startInt = Integer.parseInt(start.replace("-", ""));
				int endInt = Integer.parseInt(end.replace("-", ""));
				where = where + " and convert(int, replace(eventDate, '-','')) between " + startInt + " and " + endInt;
			}
		} 
		
		
		String sql = "select top 20 EventType,EventDate,EventTime,EventPlace,EventName,EventUserID,EventUserName,EventDoorState,EventCompanyID from dbo.History ";
		sql = sql + where;
		sql = sql +	" order by EventDate desc; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					rs.last(); 
					eventG = new Event[rs.getRow()];
					rs.beforeFirst();
					
					while(rs.next()){
						event = new Event();
						event.setEventType(rs.getString(1));
						event.setEventDate(rs.getString(2));
						event.setEventTime(rs.getString(3));
						event.setEventPlace(rs.getString(4));
						event.setEventName(rs.getString(5));
						event.setEventUserid(rs.getString(6));
						event.setEventUserName(rs.getString(7));
						event.setEventDoorState(rs.getString(8));
						event.setEventCompanyId(rs.getString(9));
						eventG[cout] = event;
						cout++;
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		return eventG;
	}

	// UserInfo
	public Event[] EventDefindByDevice(String start, String end, String Device_id) {

		
		Connection conn = null;
		Event[] eventG = null;
		Event event = new Event();
		
		String where = " where 1=1 and EventPlace in (select ControllerName as DeviceName from dbo.SetupTcpip where ID ='" + Device_id + "')";
		
		if((start == null || start == "" ) || (end == null || end == "")){
			start = "";
			end = "";
		}else{
			if(!start.equals("")){
				int startInt = Integer.parseInt(start.replace("-", ""));
				int endInt = Integer.parseInt(end.replace("-", ""));
				where = where + " and convert(int, replace(eventDate, '-','')) between " + startInt + " and " + endInt;
			}
		} 
		
		
		String sql = "select top 20 EventType,EventDate,EventTime,EventPlace,EventName,EventUserID,EventUserName,EventDoorState,EventCompanyID from dbo.History ";
		sql = sql + where;
		sql = sql +	" order by EventDate desc; ";
		
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					rs.last(); 
					eventG = new Event[rs.getRow()];
					rs.beforeFirst();
					
					while(rs.next()){
						event = new Event();
						event.setEventType(rs.getString(1));
						event.setEventDate(rs.getString(2));
						event.setEventTime(rs.getString(3));
						event.setEventPlace(rs.getString(4));
						event.setEventName(rs.getString(5));
						event.setEventUserid(rs.getString(6));
						event.setEventUserName(rs.getString(7));
						event.setEventDoorState(rs.getString(8));
						event.setEventCompanyId(rs.getString(9));
						eventG[cout] = event;
						cout++;
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		return eventG;
	}
	
	
	
	
	public Event[] searchEvent(String SDate, String EDate, String STime, String ETime, String Name, String User,String Top){
		Connection conn = null;
		Language language = new Language();
		Event[] events = null;
		String sql = "select Top("+Top+") EventType,EventDate,EventTime,EventPlace,EventName,EventUserID,EventUserName,EventDoorState,EventCompanyID from dbo.History where 1=1 ";
		
		if(SDate !=null && EDate != null){
			if(!SDate.equals("") && EDate.equals("")){
				sql = sql + "and EventDate between '" + SDate + "' and '" + EDate + "'"; 
			}
		}
		
		if(STime !=null && ETime != null){
			if(!STime.equals("") && ETime != null){
				sql = sql + "and EventTime between '" + STime + "' and '" + ETime + "'"; 
			}
		}
		
		if(Name !=null){
			if(!Name.equals("")){
				sql = sql + "and EventName like '%" + Name + "%'"; 
			}
		}
		
		if(User !=null){
			if(!User.equals("")){
				sql = sql + "and EventUserName = '" + User + "'"; 
			}
		}
		
		sql = sql + ";";
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				int count = 0;
				rs.last();
				events = new Event[rs.getRow()];
				rs.beforeFirst();
				
				while(rs.next()){
					events[count] = new Event();
					events[count].setEventType(rs.getString(1));
					events[count].setEventDate(rs.getString(2));
					events[count].setEventTime(rs.getString(3));
					events[count].setEventPlace(rs.getString(4));
					events[count].setEventName(rs.getString(5));
					events[count].setEventUserid(rs.getString(6));
					events[count].setEventUserName(rs.getString(7));
					events[count].setEventDoorState(rs.getString(8));
					events[count].setEventCompanyId(rs.getString(8));
					count++;
				}
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return events;
	}
	
	
	public EventOption[] selOption(){
		EventOption[] options = null;
		Connection conn = null;
		String val = "";
		String sql = "select idx,Type,Display,Color from dbo.EventOption ; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					rs.last();
					options = new EventOption[rs.getRow()];
					rs.beforeFirst();
					while(rs.next()){
						EventOption op = new EventOption();
						op.setIdx(rs.getInt(1));
						op.setType(rs.getString(2));
						op.setDisplay(rs.getString(3));
						op.setColor(rs.getString(4));
						options[cout] = op;
						cout++;
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
		
		return options; 
	}
	
	public EventOption selOptionType(String type){
		EventOption option = new EventOption();
		Connection conn = null;
		String val = "";
		String sql = "select idx,Type,Display,Color from dbo.EventOption where Type = '"+type+"'; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					if(rs.next()){
						option.setIdx(rs.getInt(1));
						option.setType(rs.getString(2));
						option.setDisplay(rs.getString(3));
						option.setColor(rs.getString(4));
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
		
		return option; 
	}
	
	public String EventPlaceList(){
		Connection conn = null;
		String val = "";
		String sql = "select top(5) EventPlace from dbo.History group by EventPlace";

			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					while(rs.next()){
						val = val + rs.getString(1) + ",";
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
		
		return val; 
	}
	
	public String SelEventPlaceList(){
		Connection conn = null;
		String val = "";
		String sql = "select EventPlace from dbo.History group by EventPlace";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					if(rs.next()){
						val = val + rs.getString(1) + ",";
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
		
		return val; 
	}
	
	public String pieChartVal(){
		Connection conn = null;
		String val = "";
		String sql = "select DeStatus from dbo.MainChart where idx = 1; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					if(rs.next()){
						val = rs.getString(1);
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
		
		return val; 
	}
	
	public int[] TopEventAc(String[] dev){
		Connection conn = null;
		int[] cnt = new int[dev.length];
		
		String sql = "select ";
		for(int i=0;i<dev.length;i++){
			if(i == dev.length - 1){
				sql = sql + "count (case when EventPlace ='"+dev[i]+"' then 1 end) as '"+dev[i]+"' ";
			}else{
				sql = sql + "count (case when EventPlace ='"+dev[i]+"' then 1 end) as '"+dev[i]+"', ";
			}
		}
		sql = sql + " from dbo.History where EventName = 'granted'";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					int count = 0;
					if(rs.next()){
						for(int i=0;i<dev.length;i++){
							cnt[i] = rs.getInt(i+1);
						}
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
		return cnt; 
	}
	
	
	public int[] selEventAC(String[] dev){
		Connection conn = null;
		int[] cnt = new int[dev.length];
		
		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String today_date = dateFormat.format(date);
		String temp_sql;
		
		
		for(int i=0;i<dev.length;i++)
		{
			temp_sql = "select count(*) from dbo.History where EventDate='" + today_date +"' and EventName ='Granted' and EventPlace = ";
			temp_sql += "(select ControllerName As DeviceID from dbo.SetupTcpip where ID='" + dev[i] +"')";
			try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(temp_sql);
				
				rs.next();				
			    cnt[i] = rs.getInt(1);
				
				rs.close();
				conn.close();
				}catch(Exception e){
					e.printStackTrace();
				}	
		}
		
			
		return cnt; 
	}
	
	
	public String barChartVal(){
		Connection conn = null;
		String val = "";
		String sql = "select DeAC from dbo.MainChart where idx = 1; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					if(rs.next()){
						val = rs.getString(1);
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
		
		return val; 
	}
	
	
	public int[] AllEventStatus(){
		Connection conn = null;
		int[] cnt = new int[6];
		
		String sql = "select count(case when EventName ='granted' then 1 end) as 'granted', count(case when EventName ='denied' then 1 end) as 'denied', count(case when EventName ='userenroll' then 1 end) as 'userenroll', count(case when EventName ='settingchange' then 1 end) as 'settingchange', count(case when EventName ='alarm' then 1 end) as 'alarm', count(case when EventName ='start' then 1 end) as 'start' from dbo.History";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					if(rs.next()){
						cnt[0] = rs.getInt(1); // granted
						cnt[1] = rs.getInt(2); // Denied
						cnt[2] = rs.getInt(3); // UserEnroll
						cnt[3] = rs.getInt(4); // SettingChange
						cnt[4] = rs.getInt(5); // Alarm
						cnt[5] = rs.getInt(6); // start
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
		
		return cnt; 
	}
	
	
	
	public int[] selEventStatus(String ID){
		Connection conn = null;
		int[] cnt = new int[6];
		String[] ids = ID.split(",");

		DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		Date date = new Date();
		String today_date = dateFormat.format(date);
		
		String sql = "select count(case when EventName ='granted' then 1 end) as 'granted', count(case when EventName ='denied' then 1 end) as 'denied', count(case when EventName ='userenroll' then 1 end) as 'userenroll', count(case when EventName ='settingchange' then 1 end) as 'settingchange', count(case when EventName ='alarm' then 1 end) as 'alarm', count(case when EventName ='start' then 1 end) as 'start' from dbo.History "
				+ "where 1=1 and EventDate='" + today_date + "' and (";

		for(int i=0;i<ids.length;i++){
			sql += " EventPlace = (select ControllerName As DeviceID from dbo.SetupTcpip where ID='" + ids[i] + "')";
			if(i != ids.length-1) sql += " OR ";
			else sql += ")";
		}		
		
			
		
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					if(rs.next()){
						cnt[0] = rs.getInt(1); // granted
						cnt[1] = rs.getInt(2); // Denied
						cnt[2] = rs.getInt(3); // UserEnroll
						cnt[3] = rs.getInt(4); // SettingChange
						cnt[4] = rs.getInt(5); // Alarm
						cnt[5] = rs.getInt(6); // start
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
		
		return cnt; 
	}
	
}
