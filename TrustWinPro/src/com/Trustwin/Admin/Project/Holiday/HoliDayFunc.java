package com.Trustwin.Admin.Project.Holiday;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class HoliDayFunc {
	public HoliDay[] selHoliDay(){
		Connection conn = null;
		String sql = "select HolidayName, HolidayDate, Used from Holidays order by HolidayDate desc ;";
		HoliDay[] holis = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				int count = 0;
				
				rs.last();
				holis = new HoliDay[rs.getRow()];
				rs.beforeFirst();
				
				while(rs.next()){
					HoliDay holi = new HoliDay();
					holi.setHolidayName(rs.getString(1));
					holi.setHolidayDate(rs.getString(2));
					holi.setUsed(rs.getString(3));
					holis[count] = holi;
					count++;
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return holis;
	}
	
	
	public void HolidayDelete(String date){
		Connection conn = null;
		String sql = "Delete from Holidays where date = " + date; 
		try{
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE,ResultSet.HOLD_CURSORS_OVER_COMMIT);
			pstmt.executeUpdate(sql);
			pstmt.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}
