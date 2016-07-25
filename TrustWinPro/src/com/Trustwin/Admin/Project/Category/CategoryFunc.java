package com.Trustwin.Admin.Project.Category;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CategoryFunc {

	private int Usernum = 0;
	private int count;
	
	public void setCount(){
		count = 0;
	}
	// UserInfo
	
	public Category[] CategoryDefind() {

		
		Connection conn = null;
		Category[] catagory = null;
		Category cata = new Category();
		String sql = "select idx, name, upnumber, depth from dbo.Depart order by idx asc; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					int cout = 0;
					rs.last(); 
					catagory = new Category[rs.getRow()];
					rs.beforeFirst();
					
					while(rs.next()){
						cata = new Category();
						cata.setIdx(rs.getInt(1));
						cata.setName(rs.getString(2));
						cata.setUpnumber(rs.getInt(3));
						cata.setDepth(rs.getInt(4));
						catagory[cout] = cata;
						cout++;
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		return catagory;
	}
	
	
	public int CataUpNum(int idx) {
		Connection conn = null;
		int retValue = 0;
		String sql = "select upnumber from dbo.Depart where idx = "+idx+"; ";
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
	
	
	
	public Category[] SortCategoryOne(Category[] catag){
		Category[] newCategory = new Category[catag.length];
		int total = catag.length;
		
		newCategory[0] = catag[0]; 
		
		SortCategoryTwo(catag,newCategory,catag[0].getIdx(),total);
		
		return newCategory;
	}
	
	public void SortCategoryTwo(Category[] Cata,Category[] newCata,int n,int total){
		
		for(int i=1;i<total;i++){
			if(n == Cata[i].getUpnumber()){
				Usernum++;
				newCata[Usernum] = Cata[i];
				for(int j=0;j<total;j++){
					if(newCata[Usernum].getIdx() == Cata[j].getUpnumber()){
						SortCategoryTwo(Cata, newCata,newCata[Usernum].getIdx(), total);
					}
				}
				
				
			}
			
			if(Usernum == total){
				break;
			}
			
		}
	}
	
	public int[] CategoryIdx(int upn, int[] num){
		Connection conn = null;
		String sql = "select idx from dbo.Depart where UpNumber = "+upn+";";
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
					
				while(rs.next()){
					num[count] = rs.getInt(1);
					count++;
					num = CategoryIdx(rs.getInt(1), num);
				}
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return num;
	}
	
	public String selCategory(int idx){
		Connection conn = null;
		String sql = "select Name from dbo.Depart where idx = "+idx+";";
		String name = "";
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				
				rs.next();
				name = rs.getString(1);
				
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		
		return name;
	}
	
}