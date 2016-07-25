package com.Trustwin.Admin.Project.Access;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class AccessFunc {
	public AccessGroup[] AccessGroupMenu(){
		Connection conn = null;
		String sql = "select idx,Name from AccessGroup order by idx desc;";
		AccessGroup[] accessgroup = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				int count = 0;
				
				rs.last();
				accessgroup = new AccessGroup[rs.getRow()];
				rs.beforeFirst();
				while(rs.next()){
					AccessGroup access = new AccessGroup();
					access.setIdx(rs.getInt(1));
					access.setName(rs.getString(2)); 
					accessgroup[count] = access;
					count++;
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return accessgroup;
		
	}
	
	
	public AccessGroup SelAccessGroup(int idx) throws SQLException{
		Connection conn = null;
		String sql = "select idx,Name,info from AccessGroup where idx = "+idx+";";
		AccessGroup access = new AccessGroup();
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				int count = 0;
				
				if(rs.next()){
					access.setIdx(rs.getInt(1));
					access.setName(rs.getString(2)); 
					access.setInfo(rs.getString(3));
				}
				rs.close();
				conn.close();
		}catch(Exception e){
			conn.close();
			e.printStackTrace();
		}
		
		
		return access;
		
	}
	
	public AccessDevice[] SelAccessDevice(int access){
		Connection conn = null;
		String sql = "select idx,device,timezone,access from AccessDevice where access = "+access+";";
		AccessDevice[] ads = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				int count = 0;
				
				rs.last();
				ads = new AccessDevice[rs.getRow()];
				rs.beforeFirst();
				while(rs.next()){
					AccessDevice ad = new AccessDevice();
					ad.setIdx(rs.getInt(1));
					ad.setDevice(rs.getString(2)); 
					ad.setTimezone(rs.getString(3));
					ad.setAccess(rs.getInt(4));
					ads[count] = ad;
					count++;
				}
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return ads;
		
	}
	
	public AccessUser[] SelAccessUser(int access){
		Connection conn = null;
		String sql = "select idx,userID,department,access from AccessUser where access = " + access + ";";
		AccessUser[] ads = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				int count = 0;
				
				rs.last();
				ads = new AccessUser[rs.getRow()];
				rs.beforeFirst();
				while(rs.next()){
					AccessUser ad = new AccessUser();
					ad.setIdx(rs.getInt(1));
					ad.setUserId(rs.getString(2)); 
					ad.setDeviceGroup(rs.getString(3));
					ad.setAccess(rs.getInt(4));
					ads[count] = ad;
					count++;
				}
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return ads;
		
	}
	
	public AccessUser[] SelAccessUserId(int userId){
		Connection conn = null;
		String sql = "select idx,userID,department,access from AccessUser where userID = " + userId + ";";
		AccessUser[] ads = null;
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				int count = 0;
				
				rs.last();
				ads = new AccessUser[rs.getRow()];
				rs.beforeFirst();
				while(rs.next()){
					AccessUser ad = new AccessUser();
					ad.setIdx(rs.getInt(1));
					ad.setUserId(rs.getString(2)); 
					ad.setDeviceGroup(rs.getString(3));
					ad.setAccess(rs.getInt(4));
					ads[count] = ad;
					count++;
				}
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return ads;
		
	}
	

	public AccessDevice[] SelAccessByDevice(int DeviceId){
		Connection conn = null;
		String sql = "select idx,device,timezone,access from AccessDevice where device = " + DeviceId + ";";
		AccessDevice[] ads = null;
		try {
			
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				int count = 0;
				
				rs.last();
				ads = new AccessDevice[rs.getRow()];
				rs.beforeFirst();
				while(rs.next()){
					AccessDevice ad = new AccessDevice();
					ad.setIdx(rs.getInt(1));
					ad.setDevice(rs.getString(2)); 
					ad.setTimezone(rs.getString(3));
					ad.setAccess(rs.getInt(4));
					ads[count] = ad;
					count++;
				}
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}		
		return ads;
	}
	
	
	public void delAccessGroup(int num){
		Connection conn = null;
		String sql = "Delete from AccessGroup where idx = " + num; 
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
		
		sql = "Delete from AccessUser where access = " + num; 
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
		
		sql = "Delete from AccessDevice where access = " + num; 
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
}
