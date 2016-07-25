package com.Trustwin.Admin.Project.Dbcheck;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class DBCheck {
	
	public int ColumnCheck(String name){
		Connection conn = null;
		try{
		Context init = new InitialContext();
		DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
		conn = ds.getConnection();
		Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
		String sql = "select column_name from information_schema.columns where table_name = 'AccessDevice' and column_name = ";
		sql = sql + "'"+name+"'";
		ResultSet rs = pstmt.executeQuery(sql);
		if(rs.next()){
			return 1;
		}else{
			return 0;
		}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return 0;
	}
	
	public void AccessDeviceCheck() {
		
		Connection conn = null;
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sql = "select name from sysobjects where name= ";
					sql = sql + "'AccessDevice'";
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					
					if(rs.next()){
						String[] Columns = {};		
						String[] attribute = {};		
						for(int i=0;i<Columns.length;i++){
							if(ColumnCheck(Columns[i])==1){
								String update = "alter table AccessDevice add("+Columns[i]+" "+attribute[i]+");";
								Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
								pstmt2.executeUpdate(update);
							}else{
								
							}
						
						}
						
						
					}else{
						Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						String create = "CREATE TABLE [dbo].[AccessDevice]( " +
										"[idx] [int] IDENTITY(1,1) NOT NULL," +
										"[device] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL," +
										"[timezone] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL," +
										"[access] [int] NOT NULL," + "CONSTRAINT [PK_AccessDevice] PRIMARY KEY CLUSTERED" +
										"(" + "[idx] ASC" +	")WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]" +
										") ON [PRIMARY]";
						pstmt2.executeUpdate(create);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	public void AccessGroupCheck() {
		
		Connection conn = null;
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sql = "select name from sysobjects where name=";
					sql = sql + "'AccessGroup'";
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					
					if(rs.next()){
						String[] Columns = {};		
						String[] attribute = {};		
						for(int i=0;i<Columns.length;i++){
							if(ColumnCheck(Columns[i])==1){
								String update = "alter table AccessGroup add("+Columns[i]+" "+attribute[i]+");";
								Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
								pstmt2.executeUpdate(update);
							}else{
								
							}
						
						}
					}else{
						Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						String create = "CREATE TABLE [dbo].[AccessGroup]("+
										"[idx] [int] IDENTITY(1,1) NOT NULL,"+
										"[name] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL,"+
										"[info] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL,"+
										"CONSTRAINT [PK_AccessGroup] PRIMARY KEY CLUSTERED"+ 
										"("+"[idx] ASC"+")WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]"+") ON [PRIMARY]";
						pstmt2.executeUpdate(create);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	public void AccessUserCheck() {
		
		Connection conn = null;
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sql = "select name from sysobjects where name=";
					sql = sql + "'AccessUser'";
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					
					if(rs.next()){
						String[] Columns = {};		
						String[] attribute = {};		
						for(int i=0;i<Columns.length;i++){
							if(ColumnCheck(Columns[i])==1){
								String update = "alter table AccessUser add("+Columns[i]+" "+attribute[i]+");";
								Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
								pstmt2.executeUpdate(update);
							}else{
								
							}
						}
					}else{
						Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						String create = "CREATE TABLE [dbo].[AccessUser]("+
								"[idx] [int] IDENTITY(1,1) NOT NULL,"+
								"[userID] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL,"+
								"[department] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL,"+
								"[access] [int] NOT NULL,"+"CONSTRAINT [PK_AccessUser] PRIMARY KEY CLUSTERED "+"("+"[idx] ASC"+
								")WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]"+") ON [PRIMARY]";
						pstmt2.executeUpdate(create);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	public void AlarmTimeCheck() {
		
		Connection conn = null;
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sql = "select name from sysobjects where name=";
					sql = sql + "'AlarmTime'";
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					
					if(rs.next()){
						String[] Columns = {};		
						String[] attribute = {};		
						for(int i=0;i<Columns.length;i++){
							if(ColumnCheck(Columns[i])==1){
								String update = "alter table AlarmTime add("+Columns[i]+" "+attribute[i]+");";
								Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
								pstmt2.executeUpdate(update);
							}else{
								
							}
						}
					}else{
						Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						String create = "CREATE TABLE [dbo].[AlarmTime]("+
									"[idx] [int] IDENTITY(1,1) NOT NULL,"+
									"[week1] [int] NULL,[SHour1] [int] NULL,"+
									"[SMinute1] [int] NULL,[Sec1] [int] NULL,[week2] [int] NULL,"+
									"[SHour2] [int] NULL,[SMinute2] [int] NULL,[Sec2] [int] NULL,"+
									"[week3] [int] NULL,[SHour3] [int] NULL,[SMinute3] [int] NULL,"+
									"[Sec3] [int] NULL,[week4] [int] NULL,[SHour4] [int] NULL,"+
									"[SMinute4] [int] NULL,[Sec4] [int] NULL,[week5] [int] NULL,"+
									"[SHour5] [int] NULL,[SMinute5] [int] NULL,[Sec5] [int] NULL,"+
									"[week6] [int] NULL,[SHour6] [int] NULL,[SMinute6] [int] NULL,"+
									"[Sec6] [int] NULL,[week7] [int] NULL,[SHour7] [int] NULL,"+
									"[SMinute7] [int] NULL,[Sec7] [int] NULL,[week8] [int] NULL,"+
									"[SHour8] [int] NULL,[SMinute8] [int] NULL,[Sec8] [int] NULL,"+
									"[week9] [int] NULL,[SHour9] [int] NULL,[SMinute9] [int] NULL,"+
									"[Sec9] [int] NULL,[week10] [int] NULL,[SHour10] [int] NULL,"+
									"[SMinute10] [int] NULL,[Sec10] [int] NULL,[week11] [int] NULL,"+
									"[SHour11] [int] NULL,[SMinute11] [int] NULL,[Sec11] [int] NULL,"+
									"[week12] [int] NULL,[SHour12] [int] NULL,[SMinute12] [int] NULL,"+
									"[Sec12] [int] NULL,[week13] [int] NULL,[SHour13] [int] NULL,"+
									"[SMinute13] [int] NULL,[Sec13] [int] NULL,[week14] [int] NULL,"+
									"[SHour14] [int] NULL,[SMinute14] [int] NULL,[Sec14] [int] NULL,"+
									"[week15] [int] NULL,[SHour15] [int] NULL,[SMinute15] [int] NULL,"+
									"[Sec15] [int] NULL,[week16] [int] NULL,[SHour16] [int] NULL,"+
									"[SMinute16] [int] NULL,[Sec16] [int] NULL,[week17] [int] NULL,"+
									"[SHour17] [int] NULL,[SMinute17] [int] NULL,[Sec17] [int] NULL,"+
									"[week18] [int] NULL,[SHour18] [int] NULL,[SMinute18] [int] NULL,"+
									"[Sec18] [int] NULL,[week19] [int] NULL,[SHour19] [int] NULL,"+
									"[SMinute19] [int] NULL,[Sec19] [int] NULL,[week20] [int] NULL,"+
									"[SHour20] [int] NULL,[SMinute20] [int] NULL,[Sec20] [int] NULL,"+
									"[DeviceID] [int] NULL,CONSTRAINT [PK_AlarmTime] PRIMARY KEY CLUSTERED"+ 
									"([idx] ASC)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]"+
									") ON [PRIMARY]";
						pstmt2.executeUpdate(create);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	public void AutoDoorCheck() {
		
		Connection conn = null;
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sql = "select name from sysobjects where name=";
					sql = sql + "'AutoDoor'";
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					if(rs.next()){
						String[] Columns = {};		
						String[] attribute = {};		
						for(int i=0;i<Columns.length;i++){
							if(ColumnCheck(Columns[i])==1){
								String update = "alter table AutoDoor add("+Columns[i]+" "+attribute[i]+");";
								Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
								pstmt2.executeUpdate(update);
							}else{
								
							}
						}
					}else{
						Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						String create = "CREATE TABLE [dbo].[AutoDoor]("+
									"[idx] [int] IDENTITY(1,1) NOT NULL,[week1] [int] NULL,	[SHour1] [int] NULL,"+
									"[SMinute1] [int] NULL,[EHour1] [int] NULL,[EMinute1] [int] NULL,[week2] [int] NULL,"+
									"[SHour2] [int] NULL,[SMinute2] [int] NULL,[EHour2] [int] NULL,[EMinute2] [int] NULL,"+
									"[week3] [int] NULL,[SHour3] [int] NULL,[SMinute3] [int] NULL,[EHour3] [int] NULL,"+
									"[EMinute3] [int] NULL,[week4] [int] NULL,[SHour4] [int] NULL,[SMinute4] [int] NULL,"+
									"[EHour4] [int] NULL,[EMinute4] [int] NULL,[week5] [int] NULL,[SHour5] [int] NULL,"+
									"[SMinute5] [int] NULL,[EHour5] [int] NULL,[EMinute5] [int] NULL,[week6] [int] NULL,"+
									"[SHour6] [int] NULL,[SMinute6] [int] NULL,[EHour6] [int] NULL,[EMinute6] [int] NULL,"+
									"[week7] [int] NULL,[SHour7] [int] NULL,[SMinute7] [int] NULL,[EHour7] [int] NULL,"+
									"[EMinute7] [int] NULL,[week8] [int] NULL,[SHour8] [int] NULL,[SMinute8] [int] NULL,"+
									"[EHour8] [int] NULL,[EMinute8] [int] NULL,[week9] [int] NULL,[SHour9] [int] NULL,"+
									"[SMinute9] [int] NULL,[EHour9] [int] NULL,[EMinute9] [int] NULL,[week10] [int] NULL,"+
									"[SHour10] [int] NULL,[SMinute10] [int] NULL,[EHour10] [int] NULL,[EMinute10] [int] NULL,"+
									"[DeviceID] [int] NULL,CONSTRAINT [PK_AutoDoor] PRIMARY KEY CLUSTERED"+ 
								 	"([idx] ASC)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY]";
						pstmt2.executeUpdate(create);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	public void AutoKeyCheck() {
		
		Connection conn = null;
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sql = "select name from sysobjects where name=";
					sql = sql + "'AutoKey'";
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					if(rs.next()){
						String[] Columns = {};		
						String[] attribute = {};		
						for(int i=0;i<Columns.length;i++){
							if(ColumnCheck(Columns[i])==1){
								String update = "alter table AutoKey add("+Columns[i]+" "+attribute[i]+");";
								Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
								pstmt2.executeUpdate(update);
							}else{
								
							}
						}
					}else{
						Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						String create = "CREATE TABLE [dbo].[AutoKey]([idx] [int] IDENTITY(1,1) NOT NULL,[week1] [int] NULL,"+
									"[SHour1] [int] NULL,[SMinute1] [int] NULL,[EHour1] [int] NULL,[EMinute1] [int] NULL,"+
									"[Key1] [int] NULL,[week2] [int] NULL,[SHour2] [int] NULL,[SMinute2] [int] NULL,[EHour2] [int] NULL,"+
									"[EMinute2] [int] NULL,[Key2] [int] NULL,[week3] [int] NULL,[SHour3] [int] NULL,[SMinute3] [int] NULL,"+
									"[EHour3] [int] NULL,[EMinute3] [int] NULL,[Key3] [int] NULL,[week4] [int] NULL,[SHour4] [int] NULL,"+
									"[SMinute4] [int] NULL,[EHour4] [int] NULL,[EMinute4] [int] NULL,[Key4] [int] NULL,[week5] [int] NULL,"+
									"[SHour5] [int] NULL,[SMinute5] [int] NULL,[EHour5] [int] NULL,[EMinute5] [int] NULL,[Key5] [int] NULL,"+
									"[week6] [int] NULL,[SHour6] [int] NULL,[SMinute6] [int] NULL,[EHour6] [int] NULL,[EMinute6] [int] NULL,"+
									"[Key6] [int] NULL,[week7] [int] NULL,[SHour7] [int] NULL,[SMinute7] [int] NULL,[EHour7] [int] NULL,"+
									"[EMinute7] [int] NULL,[Key7] [int] NULL,[week8] [int] NULL,[SHour8] [int] NULL,[SMinute8] [int] NULL,"+
									"[EHour8] [int] NULL,[EMinute8] [int] NULL,[Key8] [int] NULL,[week9] [int] NULL,[SHour9] [int] NULL,"+
									"[SMinute9] [int] NULL,[EHour9] [int] NULL,[EMinute9] [int] NULL,[Key9] [int] NULL,[week10] [int] NULL,"+
									"[SHour10] [int] NULL,[SMinute10] [int] NULL,[EHour10] [int] NULL,[EMinute10] [int] NULL,[Key10] [int] NULL,"+
									"[DeviceID] [int] NULL,CONSTRAINT [PK_AutoKey] PRIMARY KEY CLUSTERED" +
									"([idx] ASC)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY]";
						pstmt2.executeUpdate(create);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	public void DepartCheck() {
		
		Connection conn = null;
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sql = "select name from sysobjects where name=";
					sql = sql + "'Depart'";
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					if(rs.next()){
						String[] Columns = {};		
						String[] attribute = {};		
						for(int i=0;i<Columns.length;i++){
							if(ColumnCheck(Columns[i])==1){
								String update = "alter table Depart add("+Columns[i]+" "+attribute[i]+");";
								Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
								pstmt2.executeUpdate(update);
							}else{
								
							}
						}
					}else{
						Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						String create = "CREATE TABLE [dbo].[Depart]([idx] [int] IDENTITY(1,1) NOT NULL,"+
										"[Name] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NOT NULL,"+
										"[UpNumber] [int] NOT NULL,[Depth] [int] NOT NULL,"+
										"[reidx] [int] NULL, CONSTRAINT [PK_Depart] PRIMARY KEY CLUSTERED"+ 
										"([idx] ASC)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]"+
										") ON [PRIMARY]";
						pstmt2.executeUpdate(create);
					}
					
					sql = "select * from depart";
					rs = pstmt.executeQuery(sql);
					if(rs.next()){
						
					}else{
						String add = "insert into depart(name,upnumber,depth,reidx) values(USER,0,0,1);"
								+ "insert into depart(name,upnumber,depth,reidx) values(new department,1,1,2)";
						pstmt.executeUpdate(add);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	public void DeviceGroupCheck() {
		
		Connection conn = null;
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sql = "select name from sysobjects where name=";
					sql = sql + "'DeviceGroup'";
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					if(rs.next()){
						String[] Columns = {};		
						String[] attribute = {};		
						for(int i=0;i<Columns.length;i++){
							if(ColumnCheck(Columns[i])==1){
								String update = "alter table DeviceGroup add("+Columns[i]+" "+attribute[i]+");";
								Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
								pstmt2.executeUpdate(update);
							}else{
								
							}
						}
					}else{
						Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						String create = "CREATE TABLE [dbo].[DeviceGroup]([idx] [int] IDENTITY(1,1) NOT NULL,"+
									"[GroupName] [varchar](50) COLLATE Korean_Wansung_CI_AS NOT NULL,"+
									"[UpNumber] [int] NOT NULL,[Depth] [int] NOT NULL,[reidx] [int] NULL,"+
									"CONSTRAINT [PK_DeviceGroup] PRIMARY KEY CLUSTERED"
									+ "([idx] ASC)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]"
									+ ") ON [PRIMARY]";
						pstmt2.executeUpdate(create);
					}
					
					sql = "select * from DeviceGroup";
					rs = pstmt.executeQuery(sql);
					if(rs.next()){
						
					}else{
						String add = "insert into DeviceGroup(groupname,upnumber,depth,reidx) values('Device',0,0,1);"
								+ "insert into DeviceGroup(groupname,upnumber,depth,reidx) values('new group',1,1,2);";
						pstmt.executeUpdate(add);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	public void EventOptionCheck() {
		
		Connection conn = null;
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sql = "select name from sysobjects where name=";
					sql = sql + "'EventOption'";
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					if(rs.next()){
						String[] Columns = {};		
						String[] attribute = {};		
						for(int i=0;i<Columns.length;i++){
							if(ColumnCheck(Columns[i])==1){
								String update = "alter table DeviceGroup add("+Columns[i]+" "+attribute[i]+");";
								Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
								pstmt2.executeUpdate(update);
							}else{
								
							}
						}
					}else{
						Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						String create = "CREATE TABLE [dbo].[EventOption]("
								+ "[idx] [int] NOT NULL,"
								+ "[Type] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[Display] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[Color] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "CONSTRAINT [PK_EventOption] PRIMARY KEY CLUSTERED"
								+ "([idx] ASC)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]"
								+ ") ON [PRIMARY]";
						pstmt2.executeUpdate(create);
					}
					
					sql = "select * from EventOption";
					rs = pstmt.executeQuery(sql);
					if(rs.next()){
						
					}else{
						String add = "insert into EventOption(idx,Type,Display,Color) values(1,'Granted',1,'000000');"
								+ "insert into EventOption(idx,Type,Display,Color) values(2,'Denied',1,'000000');"
								+ "insert into EventOption(idx,Type,Display,Color) values(3,'UserEnroll',1,'000000');"
								+ "insert into EventOption(idx,Type,Display,Color) values(4,'DeleteUser',1,'000000');"
								+ "insert into EventOption(idx,Type,Display,Color) values(5,'SettingChange',1,'000000');"
								+ "insert into EventOption(idx,Type,Display,Color) values(6,'Operation',1,'000000');"
								+ "insert into EventOption(idx,Type,Display,Color) values(7,'Alarm',1,'000000');"
								+ "insert into EventOption(idx,Type,Display,Color) values(8,'Start',1,'000000');";
						pstmt.executeUpdate(add);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	
	public void HistoryCheck() {
		
		Connection conn = null;
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sql = "select name from sysobjects where name=";
					sql = sql + "'History'";
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					if(rs.next()){
						String[] Columns = {};		
						String[] attribute = {};		
						for(int i=0;i<Columns.length;i++){
							if(ColumnCheck(Columns[i])==1){
								String update = "alter table History add("+Columns[i]+" "+attribute[i]+");";
								Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
								pstmt2.executeUpdate(update);
							}else{
								
							}
						}
					}else{
						Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						String create = "CREATE TABLE [dbo].[History]("+
									"[EventType] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[EventDate] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[EventTime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[EventPlace] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[EventName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[EventUserID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[EventUserName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[EventUserDept] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[EventDoorMode] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[EventDoorState] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[EventFunKeyName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[EventDesc] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[EventCompanyID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
									+ "[id] [int] NULL) ON [PRIMARY]";
						pstmt2.executeUpdate(create);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	public void HistoryTempCheck() {
		
		Connection conn = null;
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sql = "select name from sysobjects where name=";
					sql = sql + "'History_temp'";
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					if(rs.next()){
						String[] Columns = {};		
						String[] attribute = {};		
						for(int i=0;i<Columns.length;i++){
							if(ColumnCheck(Columns[i])==1){
								String update = "alter table History_temp add("+Columns[i]+" "+attribute[i]+");";
								Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
								pstmt2.executeUpdate(update);
							}else{
								
							}
						}
					}else{
						Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						String create = "CREATE TABLE [dbo].[History_temp]("
								+ "[EventType] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventDate] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventTime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventPlace] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventUserID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventUserName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventUserDept] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventDoorMode] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventDoorState] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventFunKeyName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventDesc] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventCompanyID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL"
								+ ") ON [PRIMARY]";
						pstmt2.executeUpdate(create);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	public void History2Check() {
		
		Connection conn = null;
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String sql = "select name from sysobjects where name=";
					sql = sql + "'History2'";
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					if(rs.next()){
						String[] Columns = {};		
						String[] attribute = {};		
						for(int i=0;i<Columns.length;i++){
							if(ColumnCheck(Columns[i])==1){
								String update = "alter table History2 add("+Columns[i]+" "+attribute[i]+");";
								Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
								pstmt2.executeUpdate(update);
							}else{
								
							}
						}
					}else{
						Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
						String create = "CREATE TABLE [dbo].[History2]("
								+ "[EventType] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventDate] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventTime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventPlace] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventUserID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventUserName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventUserDept] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventDoorMode] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventDoorState] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventFunKeyName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventDesc] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
								+ "[EventCompanyID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL"
								+ ") ON [PRIMARY]";
						pstmt2.executeUpdate(create);
					}
					
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
	}
	
	public void HolidaysCheck() {
		
		Connection conn = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				String sql = "select name from sysobjects where name=";
				sql = sql + "'Holidays'";
				ResultSet rs = pstmt.executeQuery(sql);
				int cout = 0;
				if(rs.next()){
					String[] Columns = {};		
					String[] attribute = {};		
					for(int i=0;i<Columns.length;i++){
						if(ColumnCheck(Columns[i])==1){
							String update = "alter table Holidays add("+Columns[i]+" "+attribute[i]+");";
							Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							pstmt2.executeUpdate(update);
						}else{
							
						}
					}
				}else{
					Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String create = "CREATE TABLE [dbo].[Holidays]("
							+ "[HolidayName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[HolidayDate] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Used] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL"
							+ ") ON [PRIMARY]";
					pstmt2.executeUpdate(create);
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void LanguageCheck() {
		
		Connection conn = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				String sql = "select name from sysobjects where name=";
				sql = sql + "'Language'";
				ResultSet rs = pstmt.executeQuery(sql);
				int cout = 0;
				if(rs.next()){
					String[] Columns = {};		
					String[] attribute = {};		
					for(int i=0;i<Columns.length;i++){
						if(ColumnCheck(Columns[i])==1){
							String update = "alter table Language add("+Columns[i]+" "+attribute[i]+");";
							Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							pstmt2.executeUpdate(update);
						}else{
							
						}
					}
				}else{
					Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String create = "CREATE TABLE [dbo].[Language]("
							+ "[idx] [int] IDENTITY(1,1) NOT NULL,"
							+ "[ko] [varchar](200) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[en] [varchar](200) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[etc] [varchar](200) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "CONSTRAINT [PK_Language] PRIMARY KEY CLUSTERED"
							+ "([idx] ASC)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY]";
					pstmt2.executeUpdate(create);
				}
				
				sql = "select * from language;";
				rs = pstmt.executeQuery(sql);
				if(rs.next()){
					
				}else{
					String add = "SET IDENTITY_INSERT language ON;"
					+ "insert into language(idx,ko,en,etc) values(1,'장비이름','devicename','devicename');"
					+ "insert into language(idx,ko,en,etc) values(2,'아이디','ID','ID');"
					+ "insert into language(idx,ko,en,etc) values(3,'주소','Address','Address');"
					+ "insert into language(idx,ko,en,etc) values(4,'포트 번호','Port Number','Port Number');"
					+ "insert into language(idx,ko,en,etc) values(5,'비밀 번호','Password','Password');"
					+ "insert into language(idx,ko,en,etc) values(6,'고유 아이디','UniqueID','UniqueID');"
					+ "insert into language(idx,ko,en,etc) values(7,'서버 포트','Server Port','Server Port');"
					+ "insert into language(idx,ko,en,etc) values(8,'일광시간','Sunshine Time','Sunshine Time');"
					+ "insert into language(idx,ko,en,etc) values(9,'운영모드','Oper Mode','Oper Mode');"
					+ "insert into language(idx,ko,en,etc) values(10,'벨울림 시간','Bell Time','Bell Time');"
					+ "insert into language(idx,ko,en,etc) values(11,'자동문','Auto Door','Auto Door');"
					+ "insert into language(idx,ko,en,etc) values(12,'자동 F-Key','AutoKey','AutoKey');"
					+ "insert into language(idx,ko,en,etc) values(13,'NoAct F-Key','NoActKey','NoActKey');"
					+ "insert into language(idx,ko,en,etc) values(14,'시작 시간','Start Time','Start Time');"
					+ "insert into language(idx,ko,en,etc) values(15,'시','Hour','Hour');"
					+ "insert into language(idx,ko,en,etc) values(16,'분','Minute','Minute');"
					+ "insert into language(idx,ko,en,etc) values(17,'변경시간','Change Time','Change Time');"
					+ "insert into language(idx,ko,en,etc) values(18,'복귀시간','Reset Time','Reset Time');"
					+ "insert into language(idx,ko,en,etc) values(19,'요일','Week','Week');"
					+ "insert into language(idx,ko,en,etc) values(20,'종료시간','End Time','End Time');"
					+ "insert into language(idx,ko,en,etc) values(21,'시간','Sec','Sec');"
					+ "insert into language(idx,ko,en,etc) values(22,'기능키','Function Key','Function Key');"
					+ "insert into language(idx,ko,en,etc) values(23,'첫번째','First','First');"
					+ "insert into language(idx,ko,en,etc) values(24,'두번째','Second','Second');"
					+ "insert into language(idx,ko,en,etc) values(25,'세번째','Third','Bell Time');"
					+ "insert into language(idx,ko,en,etc) values(26,'첫번째 이름','First Name','First Name');"
					+ "insert into language(idx,ko,en,etc) values(27,'중간 이름','Middle Name','Middle Name');"
					+ "insert into language(idx,ko,en,etc) values(28,'성','Last Name','Last Name');"
					+ "insert into language(idx,ko,en,etc) values(29,'사용자 아이디','User ID','User ID');"
					+ "insert into language(idx,ko,en,etc) values(30,'사용자 등급','User Class','User Class');"
					+ "insert into language(idx,ko,en,etc) values(31,'접속 아이디','Login ID','Login ID');"
					+ "insert into language(idx,ko,en,etc) values(32,'공공정보','Official','Official');"
					+ "insert into language(idx,ko,en,etc) values(33,'개인정보','Private','Private');"
					+ "insert into language(idx,ko,en,etc) values(34,'카드','Card','Card');"
					+ "insert into language(idx,ko,en,etc) values(35,'장비','Device','Device');"
					+ "insert into language(idx,ko,en,etc) values(36,'이벤트','Event','Event');"
					+ "insert into language(idx,ko,en,etc) values(37,'접근권한','Access','Access');"
					+ "insert into language(idx,ko,en,etc) values(38,'사원번호','Employee Number','Employee Number');"
					+ "insert into language(idx,ko,en,etc) values(39,'부서','Department','Department');"
					+ "insert into language(idx,ko,en,etc) values(40,'직급','Position','Position');"
					+ "insert into language(idx,ko,en,etc) values(41,'회사 연락처','Company Tel','Company Tel');"
					+ "insert into language(idx,ko,en,etc) values(42,'입사일','Join a Company','Join a Company');"
					+ "insert into language(idx,ko,en,etc) values(43,'승진일','Promotion Tel','Promotion Tel');"
					+ "insert into language(idx,ko,en,etc) values(44,'퇴사일','Resignation','Resignation');"
					+ "insert into language(idx,ko,en,etc) values(45,'자격증','License','License');"
					+ "insert into language(idx,ko,en,etc) values(46,'시간 당 임금','Hourly Wage','Hourly Wage');"
					+ "insert into language(idx,ko,en,etc) values(47,'이메일','E-mail','E-mail');"
					+ "insert into language(idx,ko,en,etc) values(48,'성별','Sex','Sex');"
					+ "insert into language(idx,ko,en,etc) values(49,'결혼 여부','Marital Status','Marital Status');"
					+ "insert into language(idx,ko,en,etc) values(50,'주민등록번호','Resident Registration Number','Resident Registration Number');"
					+ "insert into language(idx,ko,en,etc) values(51,'집연락처','Home Call','Home Call');"
					+ "insert into language(idx,ko,en,etc) values(52,'휴대폰','Phone Number','Phone Number');"
					+ "insert into language(idx,ko,en,etc) values(53,'자동차번호','Car Number','Car Number');"
					+ "insert into language(idx,ko,en,etc) values(54,'우편번호','ZipCode','ZipCode');"
					+ "insert into language(idx,ko,en,etc) values(55,'카드아이디','CardID','CardID');"
					+ "insert into language(idx,ko,en,etc) values(56,'카드 종류','Card Type','Card Type');"
					+ "insert into language(idx,ko,en,etc) values(57,'기관 코드','Facility Code','Facility Code');"
					+ "insert into language(idx,ko,en,etc) values(58,'카드 속성','CardAttribute','CardAttribute');"
					+ "insert into language(idx,ko,en,etc) values(59,'시간대','TimeZone','TimeZone');"
					+ "insert into language(idx,ko,en,etc) values(60,'접속 방법','AccessMode','AccessMode');"
					+ "insert into language(idx,ko,en,etc) values(61,'재접근 허용시간','ReAcessLimitTime','ReAcessLimitTime');"
					+ "insert into language(idx,ko,en,etc) values(62,'서브센서 사용여부','Use Sub Sensor','Use Sub Sensor');"
					+ "insert into language(idx,ko,en,etc) values(63,'지문입력 사용여부','Use Duress Fingerprint','Use Duress Fingerprint');"
					+ "insert into language(idx,ko,en,etc) values(64,'장비 그룹','Device Group','Device Group');"
					+ "insert into language(idx,ko,en,etc) values(65,'옵션 선택','Select Option','Select Option');"
					+ "insert into language(idx,ko,en,etc) values(66,'제어장치 이름','ControllerName','ControllerName');"
					+ "insert into language(idx,ko,en,etc) values(67,'포트','Port','Port');"
					+ "insert into language(idx,ko,en,etc) values(68,'유일 아이디','UniqueID','UniqueID');"
					+ "insert into language(idx,ko,en,etc) values(69,'서버 포트','ServerPort','ServerPort');"
					+ "insert into language(idx,ko,en,etc) values(70,'그룹 번호','GroupIdx','GroupIdx');"
					+ "insert into language(idx,ko,en,etc) values(71,'날짜','Date','Date');"
					+ "insert into language(idx,ko,en,etc) values(72,'이벤트 타입','EventType','EventType');"
					+ "insert into language(idx,ko,en,etc) values(73,'이벤트 날짜','EventDate','EventDate');"
					+ "insert into language(idx,ko,en,etc) values(74,'이벤트 시간','EventTime','EventTime');"
					+ "insert into language(idx,ko,en,etc) values(75,'이벤트 장소','EventPlace','EventPlace');"
					+ "insert into language(idx,ko,en,etc) values(76,'이벤트 이름','EventName','EventName');"
					+ "insert into language(idx,ko,en,etc) values(77,'이벤트 사용자 아이디','EventUserID','EventUserID');"
					+ "insert into language(idx,ko,en,etc) values(78,'이벤트 사용자 이름','EventUserName','EventUserName');"
					+ "insert into language(idx,ko,en,etc) values(79,'이벤트 문 상태','EventDoorState','EventDoorState');"
					+ "insert into language(idx,ko,en,etc) values(80,'이벤트 회사 아이디','EventCompanyID','EventCompanyID');"
					+ "insert into language(idx,ko,en,etc) values(81,'이름','Name','Name');"
					+ "insert into language(idx,ko,en,etc) values(82,'정보','Info','Info');"
					+ "insert into language(idx,ko,en,etc) values(83,'휴일명','HoliDayName','HoliDayName');"
					+ "insert into language(idx,ko,en,etc) values(84,'사용여부','UseF','UseF');"
					+ "insert into language(idx,ko,en,etc) values(85,'선택','Select','Select');"
					+ "insert into language(idx,ko,en,etc) values(86,'사용중','Occupied','Occupied');"
					+ "insert into language(idx,ko,en,etc) values(87,'미사용중','Not Occupied','Not Occupied');"
					+ "insert into language(idx,ko,en,etc) values(88,'삭제','Delete','Delete');"
					+ "insert into language(idx,ko,en,etc) values(89,'상태변경','StatusChange','StatusChange');"
					+ "insert into language(idx,ko,en,etc) values(90,'추가','Add','Add');"
					+ "insert into language(idx,ko,en,etc) values(91,'표시할 갯수','DisplayNumber','DisplayNumber');"
					+ "insert into language(idx,ko,en,etc) values(92,'적용','Application','Application');"
					+ "insert into language(idx,ko,en,etc) values(93,'범위가 잘못 지정되었습니다.','The range has been specified incorrectly.','The range has been specified incorrectly.');"
					+ "insert into language(idx,ko,en,etc) values(95,'번호','Number','Number');"
					+ "insert into language(idx,ko,en,etc) values(96,'일요일','SunDay','SunDay');"
					+ "insert into language(idx,ko,en,etc) values(97,'월요일','Monday','Monday');"
					+ "insert into language(idx,ko,en,etc) values(98,'화요일','Tuesday','Tuesday');"
					+ "insert into language(idx,ko,en,etc) values(99,'수요일','Wednesday','Wednesday');"
					+ "insert into language(idx,ko,en,etc) values(100,'목요일','Thursday','Thursday');"
					+ "insert into language(idx,ko,en,etc) values(101,'금요일','Friday','Friday');"
					+ "insert into language(idx,ko,en,etc) values(102,'토요일','Saturday','Saturday');"
					+ "insert into language(idx,ko,en,etc) values(103,'정말 삭제하시겠습니까?','Are you sure you want to delete?','Are you sure you want to delete?');"
					+ "insert into language(idx,ko,en,etc) values(104,'정보 표 보기','DateTable Show','DateTable Show');"
					+ "insert into language(idx,ko,en,etc) values(105,'타입','Type','Type');"
					+ "insert into language(idx,ko,en,etc) values(106,'시간','Time','Time');"
					+ "insert into language(idx,ko,en,etc) values(107,'출입통제','Access Control','Access Control');"
					+ "insert into language(idx,ko,en,etc) values(108,'사용자','User','User');"
					+ "insert into language(idx,ko,en,etc) values(109,'출입시간','Access Time','Access Time');"
					+ "insert into language(idx,ko,en,etc) values(110,'범주','Category','Category');"
					+ "insert into language(idx,ko,en,etc) values(111,'표준시간','TimeZone','TimeZone');"
					+ "insert into language(idx,ko,en,etc) values(112,'정보표','Data Table','Data Table');"
					+ "insert into language(idx,ko,en,etc) values(113,'정보가 없습니다.','Information is available.','Information is available.');"
					+ "insert into language(idx,ko,en,etc) values(114,'중복 된 사원번호입니다.','This is a duplicate employee number.','This is a duplicate employee number.');"
					+ "insert into language(idx,ko,en,etc) values(115,'사용가능한 사원번호입니다.','The employee number available.','The employee number available.');"
					+ "insert into language(idx,ko,en,etc) values(116,'중복 된 CardID입니다.','Bell Time','Bell Time');"
					+ "insert into language(idx,ko,en,etc) values(117,'사용가능한 CardID입니다.','The CardID available.','The CardID available.');"
					+ "insert into language(idx,ko,en,etc) values(118,'입력값이 비어 있습니다.','Input value is empty.','Input value is empty.');"
					+ "insert into language(idx,ko,en,etc) values(119,'범위가 잘못 지정되었습니다.','The range has been specified incorrectly.','The range has been specified incorrectly.');"
					+ "insert into language(idx,ko,en,etc) values(120,'실시간 로그','realLog','realLog');"
					+ "insert into language(idx,ko,en,etc) values(121,'로그 검색','searchlog','searchlog');"
					+ "insert into language(idx,ko,en,etc) values(122,'년','year','year');"
					+ "insert into language(idx,ko,en,etc) values(123,'월','month','month');"
					+ "insert into language(idx,ko,en,etc) values(124,'제어장치 명','ControllerName','ControllerName');"
					+ "insert into language(idx,ko,en,etc) values(125,'사용자 클레스','UserClass','UserClass');"
					+ "insert into language(idx,ko,en,etc) values(126,'분류 번호','cateIdx','cateIdx');"
					+ "insert into language(idx,ko,en,etc) values(127,'새 부서','New Department','New Department');"
					+ "insert into language(idx,ko,en,etc) values(128,'해당 그룹에 추가 할 수 없습니다.','Can not be added to this group.','Can not be added to this group.');"
					+ "insert into language(idx,ko,en,etc) values(129,'새 그룹','New Group','New Group');"
					+ "insert into language(idx,ko,en,etc) values(132,'테스트','test','test');"
					+ "insert into language(idx,ko,en,etc) values(133,'출입 그룹','Access Group','Access Group');"
					+ "insert into language(idx,ko,en,etc) values(134,'사용자 범주','User Category','User Category');"
					+ "insert into language(idx,ko,en,etc) values(135,'네번째','Bell Time','Bell Time');"
					+ "insert into language(idx,ko,en,etc) values(136,'회사아이디','CompanyID','CompanyID');"
					+ "insert into language(idx,ko,en,etc) values(137,'기본정보','Basic','Basic');"
					+ "insert into language(idx,ko,en,etc) values(138,'문전달','DoorRelay','DoorRelay');"
					+ "insert into language(idx,ko,en,etc) values(139,'문방식','DoorMode','DoorMode');"
					+ "insert into language(idx,ko,en,etc) values(140,'문시간','DoorTime','DoorTime');"
					+ "insert into language(idx,ko,en,etc) values(141,'문알람','DoorAlarm','DoorAlarm');"
					+ "insert into language(idx,ko,en,etc) values(142,'CD타입','CdType','CdType');"
					+ "insert into language(idx,ko,en,etc) values(143,'재입장','ReAccess','ReAccess');"
					+ "insert into language(idx,ko,en,etc) values(144,'CD2기능','Cd2Fun','Cd2Fun');"
					+ "insert into language(idx,ko,en,etc) values(145,'알람방식기능','AlmRelayFun','AlmRelayFun');"
					+ "insert into language(idx,ko,en,etc) values(146,'알람부저기능','AlmBuzzFun','AlmBuzzFun');"
					+ "insert into language(idx,ko,en,etc) values(147,'AntiPass','AntiPass','AntiPass');"
					+ "insert into language(idx,ko,en,etc) values(148,'화재','Fire','Fire');"
					+ "insert into language(idx,ko,en,etc) values(149,'ID숨김','IdSecret','IdSecret');"
					+ "insert into language(idx,ko,en,etc) values(150,'제한','Limit','Limit');"
					+ "insert into language(idx,ko,en,etc) values(151,'VoiceOut','VoiceOut','VoiceOut');"
					+ "insert into language(idx,ko,en,etc) values(152,'기계ID','MachineID','MachineID');"
					+ "insert into language(idx,ko,en,etc) values(153,'보드속도','Baudrate','Baudrate');"
					+ "insert into language(idx,ko,en,etc) values(154,'장비시간','DeviceTime','DeviceTime');"
					+ "insert into language(idx,ko,en,etc) values(155,'사용자수','UserCount','UserCount');"
					+ "insert into language(idx,ko,en,etc) values(156,'관리자수','ManagerCount','ManagerCount');"
					+ "insert into language(idx,ko,en,etc) values(157,'FP수','FpCount','FpCount');"
					+ "insert into language(idx,ko,en,etc) values(158,'카드수','CardCount','CardCount');"
					+ "insert into language(idx,ko,en,etc) values(159,'총 SLog수','SLogTotal','SLogTotal');"
					+ "insert into language(idx,ko,en,etc) values(160,'SLog 읽기','SLogRead','SLogRead');"
					+ "insert into language(idx,ko,en,etc) values(161,'총 GLog수','GLogTotal','GLogTotal');"
					+ "insert into language(idx,ko,en,etc) values(162,'GLog 읽기','GLogRead','GLogRead');"
					+ "insert into language(idx,ko,en,etc) values(163,'Cur문 방식','CurDoorMode','CurDoorMode');"
					+ "insert into language(idx,ko,en,etc) values(164,'항목추가','AddItem','AddItem');"
					+ "insert into language(idx,ko,en,etc) values(165,'PC정보 관리자','Manager PC Information','Manager PC Information');"
					+ "insert into language(idx,ko,en,etc) values(166,'배경 이미지','Background Image','Background Image');"
					+ "insert into language(idx,ko,en,etc) values(167,'전체','All','All');"
					+ "insert into language(idx,ko,en,etc) values(168,'사용중','use','use');"
					+ "insert into language(idx,ko,en,etc) values(169,'미사용중','not use','not use');"
					+ "insert into language(idx,ko,en,etc) values(170,'사용자','User','User');"
					+ "insert into language(idx,ko,en,etc) values(171,'관리자','Admin','Admin');"
					+ "insert into language(idx,ko,en,etc) values(172,'남자','male','male');"
					+ "insert into language(idx,ko,en,etc) values(173,'여자','female','female');"
					+ "insert into language(idx,ko,en,etc) values(174,'기혼','married','married');"
					+ "insert into language(idx,ko,en,etc) values(175,'미혼','single','single');"
					+ "insert into language(idx,ko,en,etc) values(176,'항목 설정','item selection','item selection');"
					+ "insert into language(idx,ko,en,etc) values(177,'저장할 항목','storage article','storage article');"
					+ "insert into language(idx,ko,en,etc) values(178,'조회내용','content check','content check');"
					+ "insert into language(idx,ko,en,etc) values(179,'확인','confirmation','confirmation');"
					+ "insert into language(idx,ko,en,etc) values(180,'휴일','Holiday','Holiday');"
					+ "insert into language(idx,ko,en,etc) values(181,'AccessGroup, TimeZone 중에서 하나를 선택하시오.','Please select one of the AccessGroup, TimeZone','Please select one of the AccessGroup, TimeZone');"
					+ "insert into language(idx,ko,en,etc) values(182,'검색','Search','Search');"
					+ "insert into language(idx,ko,en,etc) values(183,'등록','Enroll','Enroll');"
					+ "insert into language(idx,ko,en,etc) values(184,'받기','Recive','Recive');"
					+ "insert into language(idx,ko,en,etc) values(185,'닫기','Close','Close');";
					
					pstmt.executeUpdate(add);
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void ManageModeCheck() {
		
		Connection conn = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				String sql = "select name from sysobjects where name=";
				sql = sql + "'ManageMode'";
				ResultSet rs = pstmt.executeQuery(sql);
				int cout = 0;
				if(rs.next()){
					String[] Columns = {};		
					String[] attribute = {};		
					for(int i=0;i<Columns.length;i++){
						if(ColumnCheck(Columns[i])==1){
							String update = "alter table ManageMode add("+Columns[i]+" "+attribute[i]+");";
							Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							pstmt2.executeUpdate(update);
						}else{
							
						}
					}
				}else{
					Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String create = "CREATE TABLE [dbo].[ManageMode]("
							+ "[idx] [int] IDENTITY(1,1) NOT NULL,[week1] [int] NULL,[SHour1] [int] NULL,"
							+ "[SMinute1] [int] NULL,[EHour1] [int] NULL,[EMinute1] [int] NULL,[Manage1] [int] NULL,"
							+ "[week2] [int] NULL,[SHour2] [int] NULL,[SMinute2] [int] NULL,[EHour2] [int] NULL,"
							+ "[EMinute2] [int] NULL,[Manage2] [int] NULL,[week3] [int] NULL,[SHour3] [int] NULL,"
							+ "[SMinute3] [int] NULL,[EHour3] [int] NULL,[EMinute3] [int] NULL,[Manage3] [int] NULL,"
							+ "[week4] [int] NULL,[SHour4] [int] NULL,[SMinute4] [int] NULL,[EHour4] [int] NULL,"
							+ "[EMinute4] [int] NULL,[Manage4] [int] NULL,[week5] [int] NULL,[SHour5] [int] NULL,"
							+ "[SMinute5] [int] NULL,[EHour5] [int] NULL,[EMinute5] [int] NULL,[Manage5] [int] NULL,"
							+ "[week6] [int] NULL,[SHour6] [int] NULL,[SMinute6] [int] NULL,[EHour6] [int] NULL,"
							+ "[EMinute6] [int] NULL,[Manage6] [int] NULL,[week7] [int] NULL,[SHour7] [int] NULL,"
							+ "[SMinute7] [int] NULL,[EHour7] [int] NULL,[EMinute7] [int] NULL,[Manage7] [int] NULL,"
							+ "[week8] [int] NULL,[SHour8] [int] NULL,[SMinute8] [int] NULL,[EHour8] [int] NULL,"
							+ "[EMinute8] [int] NULL,[Manage8] [int] NULL,[week9] [int] NULL,[SHour9] [int] NULL,"
							+ "[SMinute9] [int] NULL,[EHour9] [int] NULL,[EMinute9] [int] NULL,[Manage9] [int] NULL,"
							+ "[week10] [int] NULL,[SHour10] [int] NULL,[SMinute10] [int] NULL,[EHour10] [int] NULL,"
							+ "[Eminute10] [int] NULL,[Manage10] [int] NULL,[DeviceID] [int] NULL,CONSTRAINT [PK_ManageMode] PRIMARY KEY CLUSTERED"
							+ "([idx] ASC)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]"
							+ ") ON [PRIMARY]";
					pstmt2.executeUpdate(create);
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	public void MemberCheck() {
		
		Connection conn = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				String sql = "select name from sysobjects where name=";
				sql = sql + "'Member'";
				ResultSet rs = pstmt.executeQuery(sql);
				int cout = 0;
				if(rs.next()){
					String[] Columns = {};		
					String[] attribute = {};		
					for(int i=0;i<Columns.length;i++){
						if(ColumnCheck(Columns[i])==1){
							String update = "alter table Member add("+Columns[i]+" "+attribute[i]+");";
							Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							pstmt2.executeUpdate(update);
						}else{
							
						}
					}
				}else{
					Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String create = "CREATE TABLE [dbo].[Member]("
							+ "[UserID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[FirstName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[MiddleName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[LastName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[UserClass] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[ID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Password] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[CardType] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[CardAttribute] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[FacilityCode] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[CardID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[CardID2] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[TimeZoneNo1] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[TimeZoneNo2] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[CompanyID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Department] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Position] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[TelOffice] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[EngagedDay] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[LatestPromoted] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[RetiredDay] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[EMail] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[License1] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[License2] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[License3] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Sex] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Married] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[ResidentRegNo] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[TelHome] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[MobilePhone] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[CarName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Photo] [nvarchar](200) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[ZipCode] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Address] [nvarchar](200) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[UserMode] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[TempId] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[TempIdNumber] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[UseSubSensor] [int] NULL,[UseDuressFinger] [int] NULL DEFAULT ((0)),"
							+ "[HourlyWage] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[DeviceGroup] [int] NULL,"
							+ "[ReAccessLimitTime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL ) ON [PRIMARY]";
					pstmt2.executeUpdate(create);
				}
				
				sql = "select * from member";
				rs = pstmt.executeQuery(sql);
				if(rs.next()){
					
				}else{
					String add = "INSERT INTO [dbo].[Member] ([UserID],[FirstName],[MiddleName],[LastName],[UserClass],[ID],[Password],[CardType],[CardAttribute],[FacilityCode]"
							+ " ,[CardID],[CardID2],[TimeZoneNo1],[TimeZoneNo2]"
							+ " ,[CompanyID],[Department],[Position],[TelOffice]"
							+ " ,[EngagedDay],[LatestPromoted],[RetiredDay] ,[EMail],[License1],[License2]"
							+ " ,[License3],[Sex],[Married] ,[ResidentRegNo] ,[TelHome],[MobilePhone] ,[CarName] ,[Photo] ,[ZipCode] ,[Address]"
							+ " ,[UserMode],[TempId],[TempIdNumber],[UseSubSensor],[DeviceGroup])"
							+ " VALUES ('00000001' ,'Jon' ,'None' ,'Telford' ,'0' ,'1' ,'1' ,'0' ,'0' ,'00100' ,'0000000001' ,'2' ,'0' ,'0' ,'00000001'"
							+ " ,'1' ,'None' ,'None' ,'2012-01-01' ,'2012-01-01','2100-01-01','None','None','None','None','0','0','None','None','None'"
							+ " ,'None','None','None','None','0','0','0','0',1)";
					
					pstmt.executeUpdate(add);
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	public void NoActKeyCheck() {
		
		Connection conn = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				String sql = "select name from sysobjects where name=";
				sql = sql + "'NoActKey'";
				ResultSet rs = pstmt.executeQuery(sql);
				int cout = 0;
				if(rs.next()){
					String[] Columns = {};		
					String[] attribute = {};		
					for(int i=0;i<Columns.length;i++){
						if(ColumnCheck(Columns[i])==1){
							String update = "alter table NoActKey add("+Columns[i]+" "+attribute[i]+");";
							Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							pstmt2.executeUpdate(update);
						}else{
							
						}
					}
				}else{
					Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String create = "CREATE TABLE [dbo].[NoActKey]([idx] [int] IDENTITY(1,1) NOT NULL,"
							+ "[FirstKey] [int] NULL,[SecondKey] [int] NULL,[ThirdKey] [int] NULL,"
							+ "[FourthKey] [int] NULL,[DeviceID] [int] NULL,CONSTRAINT [PK_NoActKey] PRIMARY KEY CLUSTERED"
							+ "([idx] ASC)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY]";
					pstmt2.executeUpdate(create);
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void SetupSerialCheck() {
		
		Connection conn = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				String sql = "select name from sysobjects where name=";
				sql = sql + "'SetupSerial'";
				ResultSet rs = pstmt.executeQuery(sql);
				int cout = 0;
				if(rs.next()){
					String[] Columns = {};		
					String[] attribute = {};		
					for(int i=0;i<Columns.length;i++){
						if(ColumnCheck(Columns[i])==1){
							String update = "alter table SetupSerial add("+Columns[i]+" "+attribute[i]+");";
							Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							pstmt2.executeUpdate(update);
						}else{
							
						}
					}
				}else{
					Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String create = "CREATE TABLE [dbo].[SetupSerial]("
							+ "[ControllerName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[ID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,[Port] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL"
							+ ") ON [PRIMARY]";
					pstmt2.executeUpdate(create);
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	
	public void SetupTcpipCheck() {
		
		Connection conn = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				String sql = "select name from sysobjects where name=";
				sql = sql + "'SetupTcpip'";
				ResultSet rs = pstmt.executeQuery(sql);
				int cout = 0;
				if(rs.next()){
					String[] Columns = {};		
					String[] attribute = {};		
					for(int i=0;i<Columns.length;i++){
						if(ColumnCheck(Columns[i])==1){
							String update = "alter table SetupTcpip add("+Columns[i]+" "+attribute[i]+");";
							Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							pstmt2.executeUpdate(update);
						}else{
							
						}
					}
				}else{
					Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String create = "CREATE TABLE [dbo].[SetupTcpip]("
							+ "[ControllerName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[ID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NOT NULL,"
							+ "[Address] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Port] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Password] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[UniqueID] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[ServerPort] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[groupIdx] [int] NULL,[photo] [nvarchar](200) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[DoorRelay] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[DoorMode] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[DoorTime] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[DoorAlarm] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[CdType] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[ReAccess] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Cd2Fun] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[AlmRelayFun] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[AlmBuzzFun] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[AntiPass] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Fire] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[IdSecret] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Limit] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[VoiceOut] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[MachineID] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[Baudrate] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[DeviceTime] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[UserCount] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[ManagerCount] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[FpCount] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[CardCount] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[SLogTotal] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[SLogRead] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[GLogTotal] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[GLogRead] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[CurDoorMode] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[DoorStatus] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[MPCI] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[BGI] [nvarchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "CONSTRAINT [PK_SetupTcpip] PRIMARY KEY CLUSTERED"
							+ "([ID] ASC)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]"
							+ ") ON [PRIMARY]";
					pstmt2.executeUpdate(create);
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void SunshineCheck() {
		
		Connection conn = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				String sql = "select name from sysobjects where name=";
				sql = sql + "'Sunshine'";
				ResultSet rs = pstmt.executeQuery(sql);
				int cout = 0;
				if(rs.next()){
					String[] Columns = {};		
					String[] attribute = {};		
					for(int i=0;i<Columns.length;i++){
						if(ColumnCheck(Columns[i])==1){
							String update = "alter table Sunshine add("+Columns[i]+" "+attribute[i]+");";
							Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							pstmt2.executeUpdate(update);
						}else{
							
						}
					}
				}else{
					Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String create = "CREATE TABLE [dbo].[Sunshine]("
							+ "[SYear] [int] NULL,[idx] [int] IDENTITY(1,1) NOT NULL,[SMonth] [int] NULL,"
							+ "[SDay] [int] NULL,[SCYear] [int] NULL,[SCMonth] [int] NULL,[SCDay] [int] NULL,"
							+ "[RYear] [int] NULL,[RMonth] [int] NULL,[RDay] [int] NULL,[RCYear] [int] NULL,"
							+ "[RCMonth] [int] NULL,[RCDay] [int] NULL,[DeviceID] [int] NULL,[SHour] [int] NULL,"
							+ "[SMinute] [int] NULL,[SCHour] [int] NULL,[SCMinute] [int] NULL,[RHour] [int] NULL,"
							+ "[RMinute] [int] NULL,[RCHour] [int] NULL,[RCMinute] [int] NULL,CONSTRAINT [PK_Sunshine_1] PRIMARY KEY CLUSTERED"
							+ "([idx] ASC)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]) ON [PRIMARY]";
					pstmt2.executeUpdate(create);
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void Table_1Check() {
		
		Connection conn = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				String sql = "select name from sysobjects where name=";
				sql = sql + "'Table_1'";
				ResultSet rs = pstmt.executeQuery(sql);
				int cout = 0;
				if(rs.next()){
					String[] Columns = {};		
					String[] attribute = {};		
					for(int i=0;i<Columns.length;i++){
						if(ColumnCheck(Columns[i])==1){
							String update = "alter table Table_1 add("+Columns[i]+" "+attribute[i]+");";
							Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							pstmt2.executeUpdate(update);
						}else{
							
						}
					}
				}else{
					Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String create = "CREATE TABLE [dbo].[Table_1]([idx] [int] NOT NULL,"
							+ "[name] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[info] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[device] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[timezone] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[userID] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[deviceGroup] [varchar](50) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "CONSTRAINT [PK_Table_1] PRIMARY KEY CLUSTERED"
							+ "([idx] ASC)WITH (PAD_INDEX  = OFF, IGNORE_DUP_KEY = OFF) ON [PRIMARY]"
							+ ") ON [PRIMARY]";
					pstmt2.executeUpdate(create);
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
	public void TimezoneCheck() {
		
		Connection conn = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				String sql = "select name from sysobjects where name=";
				sql = sql + "'Timezone'";
				ResultSet rs = pstmt.executeQuery(sql);
				int cout = 0;
				if(rs.next()){
					String[] Columns = {};		
					String[] attribute = {};		
					for(int i=0;i<Columns.length;i++){
						if(ColumnCheck(Columns[i])==1){
							String update = "alter table Timezone add("+Columns[i]+" "+attribute[i]+");";
							Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
							pstmt2.executeUpdate(update);
						}else{
							
						}
					}
				}else{
					Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					String create = "CREATE TABLE [dbo].[Timezone]("
							+ "[TimeZoneNo] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[TimeZoneName] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[HolSTime1] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[HolETime1] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[HolSTime2] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[HolETime2] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[MonSTime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[MonETime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[TueSTime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[TueETime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[WedSTime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[WedETime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[ThuSTime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[ThuETime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[FriSTime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[FriETime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[SatSTime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL,"
							+ "[SatETime] [nvarchar](100) COLLATE Korean_Wansung_CI_AS NULL"
							+ ") ON [PRIMARY]";
					pstmt2.executeUpdate(create);
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
	
}
