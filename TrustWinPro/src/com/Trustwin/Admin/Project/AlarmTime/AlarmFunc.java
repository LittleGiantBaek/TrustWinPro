package com.Trustwin.Admin.Project.AlarmTime;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AlarmFunc {
	
	public AlarmTime SelAlarmTime(int deviceID){
		Connection conn = null;
		String sql = "select idx, ";
		for(int i=1;i<21;i++){
			sql = sql + "week"+i+", SHour" + i + ", SMinute"+i+", Sec" + i + ", ";
		}
		sql = sql + " DeviceID from AlarmTime where DeviceID = " + deviceID + ";";
		AlarmTime at = new AlarmTime();
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				rs.next();
				at.setIdx(rs.getInt(1));
				at.setWeek1(rs.getInt(2));
				at.setSHour1(rs.getInt(3));
				at.setSMinute1(rs.getInt(4));
				at.setSec1(rs.getInt(5));
				at.setWeek2(rs.getInt(6));
				at.setSHour2(rs.getInt(7));
				at.setSMinute2(rs.getInt(8));
				at.setSec2(rs.getInt(9));
				at.setWeek3(rs.getInt(10));
				at.setSHour3(rs.getInt(11));
				at.setSMinute3(rs.getInt(12));
				at.setSec3(rs.getInt(13));
				at.setWeek4(rs.getInt(14));
				at.setSHour4(rs.getInt(15));
				at.setSMinute4(rs.getInt(16));
				at.setSec4(rs.getInt(17));
				at.setWeek5(rs.getInt(18));
				at.setSHour5(rs.getInt(19));
				at.setSMinute5(rs.getInt(20));
				at.setSec5(rs.getInt(21));
				at.setWeek6(rs.getInt(22));
				at.setSHour6(rs.getInt(23));
				at.setSMinute6(rs.getInt(24));
				at.setSec6(rs.getInt(25));
				at.setWeek7(rs.getInt(26));
				at.setSHour7(rs.getInt(27));
				at.setSMinute7(rs.getInt(28));
				at.setSec7(rs.getInt(29));
				at.setWeek8(rs.getInt(30));
				at.setSHour8(rs.getInt(31));
				at.setSMinute8(rs.getInt(32));
				at.setSec8(rs.getInt(33));
				at.setWeek9(rs.getInt(34));
				at.setSHour9(rs.getInt(35));
				at.setSMinute9(rs.getInt(36));
				at.setSec9(rs.getInt(37));
				at.setWeek10(rs.getInt(38));
				at.setSHour10(rs.getInt(39));
				at.setSMinute10(rs.getInt(40));
				at.setSec10(rs.getInt(41));
				at.setWeek11(rs.getInt(42));
				at.setSHour11(rs.getInt(43));
				at.setSMinute11(rs.getInt(44));
				at.setSec11(rs.getInt(45));
				at.setWeek12(rs.getInt(46));
				at.setSHour12(rs.getInt(47));
				at.setSMinute12(rs.getInt(48));
				at.setSec12(rs.getInt(49));
				at.setWeek13(rs.getInt(50));
				at.setSHour13(rs.getInt(51));
				at.setSMinute13(rs.getInt(52));
				at.setSec13(rs.getInt(53));
				at.setWeek14(rs.getInt(54));
				at.setSHour14(rs.getInt(55));
				at.setSMinute14(rs.getInt(56));
				at.setSec14(rs.getInt(57));
				at.setWeek15(rs.getInt(58));
				at.setSHour15(rs.getInt(59));
				at.setSMinute15(rs.getInt(60));
				at.setSec15(rs.getInt(61));
				at.setWeek16(rs.getInt(62));
				at.setSHour16(rs.getInt(63));
				at.setSMinute16(rs.getInt(64));
				at.setSec16(rs.getInt(65));
				at.setWeek17(rs.getInt(66));
				at.setSHour17(rs.getInt(67));
				at.setSMinute17(rs.getInt(68));
				at.setSec17(rs.getInt(69));
				at.setWeek18(rs.getInt(70));
				at.setSHour18(rs.getInt(71));
				at.setSMinute18(rs.getInt(72));
				at.setSec18(rs.getInt(73));
				at.setWeek19(rs.getInt(74));
				at.setSHour19(rs.getInt(75));
				at.setSMinute19(rs.getInt(76));
				at.setSec19(rs.getInt(77));
				at.setWeek20(rs.getInt(78));
				at.setSHour20(rs.getInt(79));
				at.setSMinute20(rs.getInt(80));
				at.setSec20(rs.getInt(81));
				at.setDeviceID(rs.getInt(82));
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return at;
	}
	
}
