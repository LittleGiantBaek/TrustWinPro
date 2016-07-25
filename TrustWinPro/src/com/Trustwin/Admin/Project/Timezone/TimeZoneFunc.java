package com.Trustwin.Admin.Project.Timezone;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class TimeZoneFunc {
	public void delTime(int num){
		Connection conn = null;
		String sql = "Delete from TimeZone where TimeZoneNo = " + num; 
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				pstmt.executeUpdate(sql);
				pstmt.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
	}
	
	
	public TimeZone[] TimeMenu(){
		Connection conn = null;
		//String sql = "select TimeZoneNo,TimeZoneName from TimeZone order by TimeZoneNo desc;";
		String sql = "select TimeZoneNo,TimeZoneName from  Timezone  order by CAST(TimeZoneNo AS INT) DESC;";
		TimeZone[] times = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				int count = 0;
				
				rs.last();
				times = new TimeZone[rs.getRow()];
				rs.beforeFirst();
				while(rs.next()){
					TimeZone time = new TimeZone();
					time.setTimeZoneNo(rs.getString(1)); 
					time.setTimeZoneName(rs.getString(2)); 
					times[count] = time;
					count++;
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return times;
		
	}
	
	
	public TimeZone selTimeZone(String num){
		Connection conn = null;
		String sql = "select TimeZoneNo, TimeZoneName, HolSTime1, HolETime1, HolSTime2, HolETime2, MonSTime, MonETime, TueSTime, TueETime, WedSTime, WedETime, ThuSTime, ThuETime, FriSTime, FriETime, SatSTime, SatETime from TimeZone where TimeZoneNo = '"+num+"';";
		TimeZone time = new TimeZone();
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				int count = 0;
				
				while(rs.next()){
					time.setTimeZoneNo(rs.getString(1));
					time.setTimeZoneName(rs.getString(2));
					time.setHolSTime1(rs.getString(3));
					time.setHolETime1(rs.getString(4));
					time.setHolSTime2(rs.getString(5));
					time.setHolETime2(rs.getString(6));
					time.setMonSTime(rs.getString(7));
					time.setMonETime(rs.getString(8));
					time.setTueSTime(rs.getString(9));
					time.setTueETime(rs.getString(10));
					time.setWedSTime(rs.getString(11));
					time.setWedETime(rs.getString(12));
					time.setThuSTime(rs.getString(13));
					time.setThuETime(rs.getString(14));
					time.setFriSTime(rs.getString(15));
					time.setFriETime(rs.getString(16));
					time.setSatSTime(rs.getString(17));
					time.setSatETime(rs.getString(18));
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return time;
		
	}
	
}
