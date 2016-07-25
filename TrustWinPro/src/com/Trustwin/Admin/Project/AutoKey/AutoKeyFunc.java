package com.Trustwin.Admin.Project.AutoKey;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AutoKeyFunc {
	public AutoKey SelAutoKey(int deviceID){
		Connection conn = null;
		String sql = "select idx, ";
		for(int i=1;i<11;i++){
			sql = sql + "week"+i+", SHour" + i + ", SMinute"+i+", EHour" + i + ", EMinute" + i + ", Key" + i + ", ";
		}
		sql = sql + " DeviceID from AutoKey where DeviceID = " + deviceID + ";";
		AutoKey ak = new AutoKey();
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				rs.next();
				ak.setIdx(rs.getInt(1));
				ak.setWeek1(rs.getInt(2));
				ak.setSHour1(rs.getInt(3));
				ak.setSMinute1(rs.getInt(4));
				ak.setEHour1(rs.getInt(5));
				ak.setEMinute1(rs.getInt(6));
				ak.setKey1(rs.getInt(7));
				ak.setWeek2(rs.getInt(8));
				ak.setSHour2(rs.getInt(9));
				ak.setSMinute2(rs.getInt(10));
				ak.setEHour2(rs.getInt(11));
				ak.setEMinute2(rs.getInt(12));
				ak.setKey2(rs.getInt(13));
				ak.setWeek3(rs.getInt(14));
				ak.setSHour3(rs.getInt(15));
				ak.setSMinute3(rs.getInt(16));
				ak.setEHour3(rs.getInt(17));
				ak.setEMinute3(rs.getInt(18));
				ak.setKey3(rs.getInt(19));
				ak.setWeek4(rs.getInt(20));
				ak.setSHour4(rs.getInt(21));
				ak.setSMinute4(rs.getInt(22));
				ak.setEHour4(rs.getInt(23));
				ak.setEMinute4(rs.getInt(24));
				ak.setKey4(rs.getInt(25));
				ak.setWeek5(rs.getInt(26));
				ak.setSHour5(rs.getInt(27));
				ak.setSMinute5(rs.getInt(28));
				ak.setEHour5(rs.getInt(29));
				ak.setEMinute5(rs.getInt(30));
				ak.setKey5(rs.getInt(31));
				ak.setWeek6(rs.getInt(32));
				ak.setSHour6(rs.getInt(33));
				ak.setSMinute6(rs.getInt(34));
				ak.setEHour6(rs.getInt(35));
				ak.setEMinute6(rs.getInt(36));
				ak.setKey6(rs.getInt(37));
				ak.setWeek7(rs.getInt(38));
				ak.setSHour7(rs.getInt(39));
				ak.setSMinute7(rs.getInt(40));
				ak.setEHour7(rs.getInt(41));
				ak.setEMinute7(rs.getInt(42));
				ak.setKey7(rs.getInt(43));
				ak.setWeek8(rs.getInt(44));
				ak.setSHour8(rs.getInt(45));
				ak.setSMinute8(rs.getInt(46));
				ak.setEHour8(rs.getInt(47));
				ak.setEMinute8(rs.getInt(48));
				ak.setKey8(rs.getInt(49));
				ak.setWeek9(rs.getInt(50));
				ak.setSHour9(rs.getInt(51));
				ak.setSMinute9(rs.getInt(52));
				ak.setEHour9(rs.getInt(53));
				ak.setEMinute9(rs.getInt(54));
				ak.setKey9(rs.getInt(55));
				ak.setWeek10(rs.getInt(56));
				ak.setSHour10(rs.getInt(57));
				ak.setSMinute10(rs.getInt(58));
				ak.setEHour10(rs.getInt(59));
				ak.setEMinute10(rs.getInt(60));
				ak.setKey10(rs.getInt(61));
				ak.setDeviceID(rs.getInt(62));
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return ak;
	}
	
}
