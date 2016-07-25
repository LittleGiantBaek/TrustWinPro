package com.Trustwin.Admin.Project.Map;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MapFunc {

	public Map[] mapList(){
		Connection conn = null;
		Map[] maps = null;
		Map map = null;
		String sql = "select idx, image, name from dbo.Map order by idx asc; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					rs.last(); 
					maps = new Map[rs.getRow()];
					rs.beforeFirst();
					
					while(rs.next()){
						map = new Map();
						map.setIdx(rs.getInt(1));
						map.setImage(rs.getString(2));
						map.setName(rs.getString(3));
						maps[cout] = map;
						cout++;
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		return maps;
		
	}
	
	
	public MapDevice[] selMapDev(String id){
		Connection conn = null;
		MapDevice[] mapDevs = null;
		MapDevice mapDev = null;
		String sql = "select idx, X, Y , deviceID from dbo.MapDevice where mapID = " + id + " order by idx asc; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					rs.last(); 
					mapDevs = new MapDevice[rs.getRow()];
					rs.beforeFirst();
					
					while(rs.next()){
						mapDev = new MapDevice();
						mapDev.setIdx(rs.getInt(1));
						mapDev.setX(rs.getInt(2));
						mapDev.setY(rs.getInt(3));
						mapDev.setDeviceID(rs.getString(4));
						mapDevs[cout] = mapDev;
						cout++;
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		return mapDevs;
		
	}
	
	public Map selMap(String id){
		Connection conn = null;
		Map map = null;
		String sql = "select idx, image, name from dbo.Map where idx = " + id + ";";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					
					while(rs.next()){
						map = new Map();
						map.setIdx(rs.getInt(1));
						map.setImage(rs.getString(2));
						map.setName(rs.getString(3));
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		return map;
		
	}
	
	public Map topMap(){
		Connection conn = null;
		Map map = new Map();
		String sql = "select top(1) idx, image, name from dbo.Map order by idx;";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					
					while(rs.next()){
						map.setIdx(rs.getInt(1));
						map.setImage(rs.getString(2));
						map.setName(rs.getString(3));
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		return map;
		
	}
	
	public void DelMapDevice(int idx){
		Connection conn = null;
		String sql = "Delete from MapDevice where idx = '" + idx + "'"; 
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
