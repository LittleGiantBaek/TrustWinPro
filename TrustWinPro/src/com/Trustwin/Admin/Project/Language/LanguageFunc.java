package com.Trustwin.Admin.Project.Language;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class LanguageFunc {
	public Language SelLan(int idx){
		Connection conn = null;
		String sql = "select  idx,";
		sql = sql + "ko, en, etc";
		sql = sql + "  from Language where idx = "+idx+";";
		Language lag = new Language();
		
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				int count = 0;
				rs.next();
				lag.setIdx(rs.getInt(1));
				lag.setKo(rs.getString(2));
				lag.setEn(rs.getString(3));
				lag.setEtc(rs.getString(4));
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return lag;
	}
	
	public String language(String lan, int idx){
		Connection conn = null;
		Language language = new Language();
		String val = "";
		String sql = "select idx, ko, en, etc from dbo.Language where idx = " + idx + "; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					rs.next();
					if(lan != null){
						if(lan.equals("ko")){
							val = rs.getString(2);
						}else if(lan.equals("en")){
							val = rs.getString(3);
						}else if(lan.equals("etc")){
							val = rs.getString(4);
						}
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		return val;
	}
	
	
	public Language[] SelLanguage(){
		Connection conn = null;
		String sql = "select  idx,";
		sql = sql + "ko, en, etc";
		sql = sql + "  from Language order by idx desc;";
		Language[] lags = null;
		
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				rs.last();
				lags = new Language[rs.getRow()];
				rs.beforeFirst();
				int count = 0;
				while(rs.next()){
					Language lag = new Language();
					lag.setIdx(rs.getInt(1));
					lag.setKo(rs.getString(2));
					lag.setEn(rs.getString(3));
					lag.setEtc(rs.getString(4));
					lags[count] = lag;
					count++;
				}
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		
		return lags;
	}

}
