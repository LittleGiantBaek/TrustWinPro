package com.Trustwin.Admin.Project.Device;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DeviceFunc {
	private int Devicenum = 0;
	private int count;
	
	public void setCount(){
		count = 0;
	}
	// DeviceInfo
		public DeviceGroup[] GroupDefind() {

			
			Connection conn = null;
			DeviceGroup[] device = null;
			DeviceGroup dev = new DeviceGroup();
			String sql = "select idx, GroupName, upnumber, depth from dbo.DeviceGroup order by idx asc; ";
				try {
						Context init = new InitialContext();
						DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
						conn = ds.getConnection();
						Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						ResultSet rs = pstmt.executeQuery(sql);
						int cout = 0;
						rs.last(); 
						device = new DeviceGroup[rs.getRow()];
						rs.beforeFirst();
						
						while(rs.next()){
							dev = new DeviceGroup();
							dev.setIdx(rs.getInt(1));
							dev.setGroupname(rs.getString(2));
							dev.setUpnumber(rs.getInt(3));
							dev.setDepth(rs.getInt(4));
							device[cout] = dev;
							cout++;
						}
						rs.close();
						conn.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			return device;
		}
		
		public int GroupUpNum(int idx) {
			Connection conn = null;
			int retValue = 0;
			String sql = "select upnumber from dbo.DeviceGroup where idx = "+idx+"; ";
				try {
						Context init = new InitialContext();
						DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
						conn = ds.getConnection();
						Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						ResultSet rs = pstmt.executeQuery(sql);
						
						while(rs.next()){
							retValue = rs.getInt(1);
						}
						rs.close();
						conn.close();
				}catch(Exception e){
					e.printStackTrace();
				}
				
			return retValue;
		}
		
		public DeviceGroup[] SortGroupOne(DeviceGroup[] group){
			DeviceGroup[] newGroup = new DeviceGroup[group.length];
			int total = group.length;
			
			newGroup[0] = group[0]; 
			
			SortGroupTwo(group,newGroup,group[0].getIdx(),total);
			
			return newGroup;
		}
		
		public void SortGroupTwo(DeviceGroup[] group,DeviceGroup[] newGroup,int n,int total){
			
			for(int i=1;i<total;i++){
				if(n == group[i].getUpnumber()){
					Devicenum++;
					newGroup[Devicenum] = group[i];
					for(int j=0;j<total;j++){
						if(newGroup[Devicenum].getIdx() == group[j].getUpnumber()){
							SortGroupTwo(group, newGroup,newGroup[Devicenum].getIdx(), total);
						}
					}
				}
				if(Devicenum == total){
					break;
				}
			}
		}
		
		
		public Device[] DeviceSelect(int dep) {
			Connection conn = null;
			Device[] devices = null;
			Device device = null;
			String sql = "select ControllerName, id, groupIdx from dbo.SetupTcpip where groupIdx = '" + dep + "' order by id asc; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					int count = 0;
					String Name = "";
					rs.last();
					devices = new Device[rs.getRow()];
					rs.beforeFirst();
					
					while(rs.next()){
						device = new Device();
						device.setControllerName(rs.getString(1));
						device.setID(rs.getString(2));
						device.setGroupIdx(Integer.parseInt(rs.getString(3)));
						devices[count] = device;
						count++;
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
				
			return devices;
		}
		

		public Device selDevice2(String idx){
			Connection conn = null;
			String sql = "select ControllerName from dbo.SetupTcpip where ID = " + idx + ";";
			Device device = new Device();
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
						
					if(rs.next()){
						device.setControllerName(rs.getString(1));
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
			return device;
		}

		public Device selDevice(int idx){
			Connection conn = null;
			String sql = "select ControllerName from dbo.SetupTcpip where ID = " + idx + ";";
			Device device = new Device();
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
						
					if(rs.next()){
						device.setControllerName(rs.getString(1));
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
			return device;
		}
		
		public String DeviceTop() {
			Connection conn = null;
			String result = "";
			String sql = "select Top 1 ID from dbo.SetupTcpip order by ID desc; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
						
					rs.next();
					if(rs.getRow() != 0){
						result = rs.getString(1);
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
				
			return result;
		}
		
		public void DeviceDelete(int idx){
			Connection conn = null;
			String sql = "Delete from SetupTcpip where ID = '" + idx + "'"; 
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

		
		public void DeviceDelete2(String idx){
			Connection conn = null;
			String sql = "Delete from SetupTcpip where ID = '" + idx + "'"; 
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
		
		public void DeviceGroupDelete(int idx){
			Connection conn = null;
			String sql = "Delete from DeviceGroup where idx = " + idx; 
			try{
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE,ResultSet.HOLD_CURSORS_OVER_COMMIT);
				pstmt.executeUpdate(sql);
				
				
				Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE,ResultSet.HOLD_CURSORS_OVER_COMMIT);
				
				sql = "Delete from SetupTcpip where groupidx = " + idx;
				pstmt2.executeUpdate(sql);
				pstmt2.close(); 
				
				sql = "select idx from deviceGroup where upNumber = " + idx;
				ResultSet rs = pstmt.executeQuery(sql);
				while(rs.next()){
					idx = rs.getInt(1);
					DeviceGroupDelete(idx);
				}
				
				pstmt.close();
				rs.close();
				conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		}
		
		public Device[] DeviceSelect2(int count){
			Device[] device = null;
			Connection conn = null;
			String sql = "select ControllerName, ID, Address, Port, Password, UniqueID, ServerPort, groupIdx from dbo.SetupTcpip where groupIdx = "+count+" order by UniqueID asc; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					rs.last();
					device = new Device[rs.getRow()];
					rs.beforeFirst();
					int num = 0;
					while(rs.next()){
						device[num] = new Device();
						device[num].setControllerName(rs.getString(1));
						device[num].setID(rs.getString(2));
						device[num].setAddress(rs.getString(3));
						device[num].setPort(rs.getString(4));
						device[num].setPassword(rs.getString(5));
						device[num].setUniqueID(rs.getString(6));
						device[num].setServerPort(rs.getString(7));
						device[num].setGroupIdx(rs.getInt(8));
						num++;
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			return device;
		}
		
		public int[] DeviceGroupIdx(int upn, int[] num){
			Connection conn = null;
			String sql = "select idx from dbo.DeviceGroup where UpNumber = "+upn+";";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
						
					while(rs.next()){
						num[count] = rs.getInt(1);
						count++;
						num = DeviceGroupIdx( rs.getInt(1), num);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
			return num;
		}
		
		
		public Device[] searchDevice(String CN, String Addr, String ID, String UID){
			Connection conn = null;
			Device[] devices = null;
			String sql = "select ControllerName, ID, Address, Port, Password, UniqueID, ServerPort, groupIdx from dbo.SetupTcpip where 1=1 ";
			
			if(CN !=null){
				if(!CN.equals("")){
					sql = sql + "and ControllerName like '%" + CN + "%'"; 
				}
			}
			
			if(Addr !=null){
				if(!Addr.equals("")){
					sql = sql + "and Address like '%" + Addr + "%'"; 
				}
			}
			
			if(ID !=null){
				if(!ID.equals("")){
					sql = sql + "and ID like '%" + ID + "%'"; 
				}
			}
			
			if(UID !=null){
				if(!UID.equals("")){
					sql = sql + "and UniqueID = '" + UID + "'"; 
				}
			}
			
			sql = sql + " order by ID;";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					int count = 0;
					rs.last();
					devices = new Device[rs.getRow()];
					rs.beforeFirst();
					
					while(rs.next()){
						devices[count] = new Device();
						devices[count].setControllerName(rs.getString(1));
						devices[count].setID(rs.getString(2));
						devices[count].setAddress(rs.getString(3));
						devices[count].setPort(rs.getString(4));
						devices[count].setPassword(rs.getString(5));
						devices[count].setUniqueID(rs.getString(6));
						devices[count].setServerPort(rs.getString(7));
						devices[count].setGroupIdx(rs.getInt(8));
						count++;
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			return devices;
		}
		
		
		public ManageMode SelManageMode(int deviceID){
			Connection conn = null;
			String sql = "select idx ";
			for(int i=1;i<11;i++){
				sql = sql + ",week"+i+", SHour" + i + ", SMinute"+i+", EHour" + i + ", EMinute" + i + ", Manage" + i;
			}
			sql = sql + ", DeviceID from ManageMode where DeviceID = " + deviceID + ";";
			ManageMode mm = new ManageMode();
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					rs.next();
					mm.setIdx(rs.getInt(1));
					mm.setWeek1(rs.getInt(2));
					mm.setSHour1(rs.getInt(3));
					mm.setSMinute1(rs.getInt(4));
					mm.setEHour1(rs.getInt(5));
					mm.setEMinute1(rs.getInt(6));
					mm.setManage1(rs.getInt(7));
					mm.setWeek2(rs.getInt(8));
					mm.setSHour2(rs.getInt(9));
					mm.setSMinute2(rs.getInt(10));
					mm.setEHour2(rs.getInt(11));
					mm.setEMinute2(rs.getInt(12));
					mm.setManage2(rs.getInt(13));
					mm.setWeek3(rs.getInt(14));
					mm.setSHour3(rs.getInt(15));
					mm.setSMinute3(rs.getInt(16));
					mm.setEHour3(rs.getInt(17));
					mm.setEMinute3(rs.getInt(18));
					mm.setManage3(rs.getInt(19));
					mm.setWeek4(rs.getInt(20));
					mm.setSHour4(rs.getInt(21));
					mm.setSMinute4(rs.getInt(22));
					mm.setEHour4(rs.getInt(23));
					mm.setEMinute4(rs.getInt(24));
					mm.setManage4(rs.getInt(25));
					mm.setWeek5(rs.getInt(26));
					mm.setSHour5(rs.getInt(27));
					mm.setSMinute5(rs.getInt(28));
					mm.setEHour5(rs.getInt(29));
					mm.setEMinute5(rs.getInt(30));
					mm.setManage5(rs.getInt(31));
					mm.setWeek6(rs.getInt(32));
					mm.setSHour6(rs.getInt(33));
					mm.setSMinute6(rs.getInt(34));
					mm.setEHour6(rs.getInt(35));
					mm.setEMinute6(rs.getInt(36));
					mm.setManage6(rs.getInt(37));
					mm.setWeek7(rs.getInt(38));
					mm.setSHour7(rs.getInt(39));
					mm.setSMinute7(rs.getInt(40));
					mm.setEHour7(rs.getInt(41));
					mm.setEMinute7(rs.getInt(42));
					mm.setManage7(rs.getInt(43));
					mm.setWeek8(rs.getInt(44));
					mm.setSHour8(rs.getInt(45));
					mm.setSMinute8(rs.getInt(46));
					mm.setEHour8(rs.getInt(47));
					mm.setEMinute8(rs.getInt(48));
					mm.setManage8(rs.getInt(49));
					mm.setWeek9(rs.getInt(50));
					mm.setSHour9(rs.getInt(51));
					mm.setSMinute9(rs.getInt(52));
					mm.setEHour9(rs.getInt(53));
					mm.setEMinute9(rs.getInt(54));
					mm.setManage9(rs.getInt(55));
					mm.setWeek10(rs.getInt(56));
					mm.setSHour10(rs.getInt(57));
					mm.setSMinute10(rs.getInt(58));
					mm.setEHour10(rs.getInt(59));
					mm.setEMinute10(rs.getInt(60));
					mm.setManage10(rs.getInt(61));
					mm.setDeviceID(rs.getInt(62));
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
			
			return mm;
		}
		
		
		public NoActKey SelNoActKey(int deviceID){
			Connection conn = null;
			String sql = "select idx, ";
			sql = sql + "FirstKey, SecondKey, ThirdKey, FourthKey,";
			sql = sql + " DeviceID from NoActKey where DeviceID = " + deviceID + ";";
			NoActKey nak = new NoActKey();
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					rs.next();
					
					nak.setIdx(rs.getInt(1));
					nak.setFirstKey(rs.getInt(2));
					nak.setSecondKey(rs.getInt(3));
					nak.setThirdKey(rs.getInt(4));
					nak.setFourthKey(rs.getInt(5));
					nak.setDeviceID(rs.getInt(6));
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
			
			return nak;
		}
		
		public Sunshine SelSunshine(int deviceID){
			Connection conn = null;
			String sql = "select idx, ";
			sql = sql + "SYear, SMonth, SDay,SHour,SMinute, SCYear, SCMonth, SCDay, SCHour, SCMinute, RYear, RMonth, RDay, RHour, RMinute, RCYear, RCMonth, RCDay, RCHour, RCMinute, ";
			sql = sql + " DeviceID from Sunshine where DeviceID = " + deviceID + ";";
			Sunshine ss = new Sunshine();
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					rs.next();
					
					ss.setIdx(rs.getInt(1));
					ss.setSYear(rs.getInt(2));
					ss.setSMonth(rs.getInt(3));
					ss.setSDay(rs.getInt(4));
					ss.setSHour(rs.getInt(5));
					ss.setSMinute(rs.getInt(6));
					ss.setSCYear(rs.getInt(7));
					ss.setSCMonth(rs.getInt(8));
					ss.setSCDay(rs.getInt(9));
					ss.setSCHour(rs.getInt(10));
					ss.setSCMinute(rs.getInt(11));
					ss.setRYear(rs.getInt(12));
					ss.setRMonth(rs.getInt(13));
					ss.setRDay(rs.getInt(14));
					ss.setRHour(rs.getInt(15));
					ss.setRMinute(rs.getInt(16));
					ss.setRCYear(rs.getInt(17));
					ss.setRCMonth(rs.getInt(18));
					ss.setRCDay(rs.getInt(19));
					ss.setRCHour(rs.getInt(20));
					ss.setRCMinute(rs.getInt(21));
					ss.setDeviceID(rs.getInt(22));
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
			
			
			return ss;
		}
		
		public Device[] deviceList() {

			
			Connection conn = null;
			Device[] device = null;
			Device dev = null;
			String sql = "select ID, ControllerName from dbo.SetupTcpip order by id asc; ";
				try {
						Context init = new InitialContext();
						DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
						conn = ds.getConnection();
						Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						ResultSet rs = pstmt.executeQuery(sql);
						int cout = 0;
						rs.last(); 
						device = new Device[rs.getRow()];
						rs.beforeFirst();
						
						while(rs.next()){
							dev = new Device();
							dev.setID(rs.getString(1));
							dev.setControllerName(rs.getString(2));
							device[cout] = dev;
							cout++;
						}
						rs.close();
						conn.close();
				}catch(Exception e){
					e.printStackTrace();
				}
			return device;
		}
}
