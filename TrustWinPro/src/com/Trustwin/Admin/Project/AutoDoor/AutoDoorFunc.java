package com.Trustwin.Admin.Project.AutoDoor;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AutoDoorFunc {

	public AutoDoor SelAutoDoor(int deviceID){
		Connection conn = null;
		String sql = "select idx";
		for(int i=1;i<11;i++){
			sql = sql + ", week"+i+", SHour" + i + ", SMinute"+i+", EHour" + i + ", EMinute" + i;
		}
		sql = sql + ", DeviceID from AutoDoor where DeviceID = " + deviceID + ";";
		AutoDoor ad = new AutoDoor();
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				rs.next();
				ad.setIdx(rs.getInt(1));
				ad.setWeek1(rs.getInt(2));
				ad.setSHour1(rs.getInt(3));
				ad.setSMinute1(rs.getInt(4));
				ad.setEHour1(rs.getInt(5));
				ad.setEMinute1(rs.getInt(6));
				ad.setWeek2(rs.getInt(7));
				ad.setSHour2(rs.getInt(8));
				ad.setSMinute2(rs.getInt(9));
				ad.setEHour2(rs.getInt(10));
				ad.setEMinute2(rs.getInt(11));
				ad.setWeek3(rs.getInt(12));
				ad.setSHour3(rs.getInt(13));
				ad.setSMinute3(rs.getInt(14));
				ad.setEHour3(rs.getInt(15));
				ad.setEMinute3(rs.getInt(16));
				ad.setWeek4(rs.getInt(17));
				ad.setSHour4(rs.getInt(18));
				ad.setSMinute4(rs.getInt(19));
				ad.setEHour4(rs.getInt(20));
				ad.setEMinute4(rs.getInt(21));
				ad.setWeek5(rs.getInt(22));
				ad.setSHour5(rs.getInt(23));
				ad.setSMinute5(rs.getInt(24));
				ad.setEHour5(rs.getInt(25));
				ad.setEMinute5(rs.getInt(26));
				ad.setWeek6(rs.getInt(27));
				ad.setSHour6(rs.getInt(28));
				ad.setSMinute6(rs.getInt(29));
				ad.setEHour6(rs.getInt(30));
				ad.setEMinute6(rs.getInt(31));
				ad.setWeek7(rs.getInt(32));
				ad.setSHour7(rs.getInt(33));
				ad.setSMinute7(rs.getInt(34));
				ad.setEHour7(rs.getInt(35));
				ad.setEMinute7(rs.getInt(36));
				ad.setWeek8(rs.getInt(37));
				ad.setSHour8(rs.getInt(38));
				ad.setSMinute8(rs.getInt(39));
				ad.setEHour8(rs.getInt(40));
				ad.setEMinute8(rs.getInt(41));
				ad.setWeek9(rs.getInt(42));
				ad.setSHour9(rs.getInt(43));
				ad.setSMinute9(rs.getInt(44));
				ad.setEHour9(rs.getInt(45));
				ad.setEMinute9(rs.getInt(46));
				ad.setWeek10(rs.getInt(47));
				ad.setSHour10(rs.getInt(48));
				ad.setSMinute10(rs.getInt(49));
				ad.setEHour10(rs.getInt(50));
				ad.setEMinute10(rs.getInt(51));
				ad.setDeviceID(rs.getInt(52));
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return ad;
	}
}
