package com.Trustwin.Admin.Project.User;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.Arrays;
import java.util.*;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import com.Trustwin.Admin.Project.Language.Language;

public class UserFunc {

public User[] UserSelect(int dep) {

		Connection conn = null;
		User[] users = null;
		User user = null;
		String sql = "select UserID, FirstName, MiddleName, LastName, Department, ID from dbo.Member where department = '" + dep + "' order by UserID asc; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					int count = 0;
					String Name = "";
					rs.last(); 
					users = new User[rs.getRow()];
					rs.beforeFirst();
					
					while(rs.next()){
						user = new User();
						user.setUserId(rs.getString(1));
						Name = "";
						if(rs.getString(2)!=null&&!rs.getString(2).equals("None")){
							Name = rs.getString(2);
						}
						if(rs.getString(3)!=null&&!rs.getString(3).equals("None")){
							Name = Name + " " + rs.getString(3);
						}
						if(rs.getString(4)!=null&&!rs.getString(4).equals("None")){
							Name = Name + " " + rs.getString(4);
						}
						user.setName(Name);
						user.setDepartment(Integer.parseInt(rs.getString(5)));
						user.setId(rs.getString(6));
						users[count] = user;
						count++;
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		return users;
	}
	
	public User[] UserList(String FN, String MN, String LN, int DP) {
		Connection conn = null;
		User[] users = null;
		String sql = "select FirstName, MiddleName, LastName, UserID, ID, UserClass, Password, Department from dbo.Member where 1=1 ";
		if(FN !=null){
			if(!FN.equals("")){
				sql = sql + "and FirstName like '%" + FN + "%'"; 
			}
		}
		
		if(MN !=null){
			if(!MN.equals("")){
				sql = sql + "and MiddleName = '%" + MN + "%'"; 
			}
		}
		
		if(LN !=null){
			if(!LN.equals("")){
				sql = sql + "and LastName = '%" + LN + "%'"; 
			}
		}
		
		if(DP!=0){
			sql = sql + "and Department = '" + DP + "'"; 
		}
		
		sql = sql + ";";
		
		try {
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			ResultSet rs = pstmt.executeQuery(sql);
			int count = 0;
			String Name = "";
			rs.last(); 
			users = new User[rs.getRow()];
			rs.beforeFirst();
			while(rs.next()){
				users[count] = new User();
				users[count].setFirstName(rs.getString(1));
				users[count].setMiddleName(rs.getString(2));
				users[count].setLastName(rs.getString(3));
				users[count].setUserId(rs.getString(4));
				users[count].setId(rs.getString(5));
				users[count].setUserClass(rs.getString(6));
				users[count].setPassWord(rs.getString(7));
				users[count].setDepartment(rs.getInt(8));
				count++;
			}
			rs.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return users;
	}
	
	
	public String UserTop() {

		Connection conn = null;
		String result = "";
		String sql = "select Top 1 UserID from dbo.Member order by UserID desc; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					
					rs.next();
					result = rs.getString(1);
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
			return result;
	}
	
	public User SelUser(String idx) {

		Connection conn = null;
		User user = new User();
		String sql = "select ID,Department,UserID from dbo.Member where ID = '"+idx+"'; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					
					rs.next();
					user.setId(rs.getString(1));
					user.setDepartment(rs.getInt(2));
					user.setUserId(rs.getString(3));
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
			return user;
	}

	public User SelUserID(String user_id) {

		Connection conn = null;
		User user = new User();
		String sql = "select ID,Department from dbo.Member where UserID = '"+user_id+"'; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					
					rs.next();
					user.setId(rs.getString(1));
					user.setDepartment(rs.getInt(2));
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
			return user;
	}
	
	public String SelUserName(String idx) {

		Connection conn = null;
		String name = "";
		String sql = "select FirstName,MiddleName,LastName from dbo.Member where UserID = '"+idx+"'; ";
			try {
					Context init = new InitialContext();
					DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
					conn = ds.getConnection();
					Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
					ResultSet rs = pstmt.executeQuery(sql);
					
					if(rs.next()){
						name = rs.getString(1) + rs.getString(2) + rs.getString(3);
					}
					rs.close();
					conn.close();
			}catch(Exception e){
				e.printStackTrace();
			}
		
			return name;
	}
	
	public User[] UserSelect2(int count){
		User[] user = null;
		Connection conn = null;
		String sql = "select UserID,FirstName,MiddleName,LastName,UserClass,Department from dbo.Member where Department = "+count+" order by ID asc; ";
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				rs.last();
				user = new User[rs.getRow()];
				rs.beforeFirst();
				int num = 0;
				while(rs.next()){
					user[num] = new User();
					user[num].setUserId(rs.getString(1));
					user[num].setName(rs.getString(2) + rs.getString(3) + rs.getString(4));
					user[num].setUserClass(rs.getString(5));
					user[num].setDepartment(rs.getInt(6));
					num++;
				}
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return user;
	}
	
	public User[] searchUser(String FN, String MN, String LN, int DP, String UI, String CI){
		Connection conn = null;
		Language language = new Language();
		User[] users = null;
		String sql = "select FirstName, MiddleName, LastName, UserID, ID, UserClass, Password, Department, CompanyID, FP1, FP2 from dbo.Member where 1=1 ";
		
		if(FN !=null){
			if(!FN.equals("")){
				sql = sql + "and FirstName like '%" + FN + "%'"; 
			}
		}
		
		if(MN !=null){
			if(!MN.equals("")){
				sql = sql + "and MiddleName like '%" + MN + "%'"; 
			}
		}
		
		if(LN !=null){
			if(!LN.equals("")){
				sql = sql + "and LastName like '%" + LN + "%'"; 
			}
		}
		
		if(DP!=0){
			sql = sql + "and Department = '" + DP + "'"; 
		}
		
		if(UI !=null){
			if(!UI.equals("")){
				sql = sql + "and UserID like '%" + UI + "%'"; 
			}
		}
		
		if(CI !=null){
			if(!CI.equals("")){
				sql = sql + "and CompanyID like '%" + CI + "%'"; 
			}
		}
		
		sql = sql + " order by UserID";
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				int count = 0;
				rs.last();
				users = new User[rs.getRow()];
				rs.beforeFirst();
				
				while(rs.next()){
					users[count] = new User();
					users[count].setFirstName(rs.getString(1));
					users[count].setMiddleName(rs.getString(2));
					users[count].setLastName(rs.getString(3));
					users[count].setUserId(rs.getString(4));
					users[count].setId(rs.getString(5));
					users[count].setUserClass(rs.getString(6));
					users[count].setPassWord(rs.getString(7));
					users[count].setDepartment(rs.getInt(8));
					users[count].setCompanyID(rs.getString(9));
					users[count].setFP1(rs.getString(10));
					users[count].setFP2(rs.getString(11));
					count++;
				}
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return users;
	}
	
	public User[] searchUser(String FN, String MN, String LN, List <Integer> DP, String UI, String CI){
		Connection conn = null;
		Language language = new Language();
		List <User> userstmp = new ArrayList<User>();;
		User[] users = null;
		int count = 0;
		for(int i = 0; i< DP.size();i++){
		String sql = "select FirstName, MiddleName, LastName, UserID, ID, UserClass, Password, Department, CompanyID, FP1, FP2 from dbo.Member where 1=1 ";
		
		if(FN !=null){
			if(!FN.equals("")){
				sql = sql + "and FirstName like '%" + FN + "%'"; 
			}
		}
		
		if(MN !=null){
			if(!MN.equals("")){
				sql = sql + "and MiddleName like '%" + MN + "%'"; 
			}
		}
		
		if(LN !=null){
			if(!LN.equals("")){
				sql = sql + "and LastName like '%" + LN + "%'"; 
			}
		}
		
		if(DP.get(i)!=0){
			sql = sql + "and Department = '" + DP.get(i) + "'"; 
		}
		
		if(UI !=null){
			if(!UI.equals("")){
				sql = sql + "and UserID like '%" + UI + "%'"; 
			}
		}
		
		if(CI !=null){
			if(!CI.equals("")){
				sql = sql + "and CompanyID like '%" + CI + "%'"; 
			}
		}
		
		sql = sql + " order by UserID";
		try {
				Context init = new InitialContext();
				DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
				conn = ds.getConnection();
				Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
				ResultSet rs = pstmt.executeQuery(sql);
				rs.last();
				rs.beforeFirst();
				while(rs.next()){
					userstmp.add(count, new User());
					userstmp.get(count).setFirstName(rs.getString(1));
					userstmp.get(count).setMiddleName(rs.getString(2));
					userstmp.get(count).setLastName(rs.getString(3));
					userstmp.get(count).setUserId(rs.getString(4));
					userstmp.get(count).setId(rs.getString(5));
					userstmp.get(count).setUserClass(rs.getString(6));
					userstmp.get(count).setPassWord(rs.getString(7));
					userstmp.get(count).setDepartment(rs.getInt(8));
					userstmp.get(count).setCompanyID(rs.getString(9));
					userstmp.get(count).setFP1(rs.getString(10));
					userstmp.get(count).setFP2(rs.getString(11));
					count++;
				}
				rs.close();
				conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		}
		users = new User[userstmp.size()];
		for(int i = 0; i< userstmp.size();i++){
			users[i] = userstmp.get(i);
		}
		return users;
	}
	public List <Integer> departmentChildarr(int idx){
		Connection conn = null;
		int[][] departlist = null; //all department
		List <Integer> A = null; //tmp array
		List <Integer> B = null; //tmp array
		int count = 0;
		int countcheck = 0;
		int departmentcount = this.departmentcount();
		String sql = "select idx,upnumber from depart"; 
		try{
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE);
			ResultSet rs = pstmt.executeQuery(sql);
			rs.last();
			departlist = new int[departmentcount][2];
			rs.beforeFirst();
			A  = new ArrayList<Integer>();
			B = new ArrayList<Integer>();
			int countA = 0;
			int countB = 0;
			int[] Atmp;
			int[] Btmp;
			//all department list (idx,upnumber)
			while(rs.next()){
				departlist[count][0] = Integer.parseInt(rs.getString(1));
				departlist[count][1] = Integer.parseInt(rs.getString(2));
				count++;
			}
			//initial value
			A.add(idx);
			while(true){
				for(int i = 0; i< B.size() ;){
					B.remove(0);
				}
				for(int i = 0; i < A.size();i++){
					for(int j = 0; j < departmentcount; j++){
						if(departlist[j][1] == A.get(i)){
							B.add(countB,departlist[j][0]);
							countcheck++;
							countB++;
						}
					}
					if(countcheck == 0){
						B.add(countB,A.get(i));
						countB++;
					}
					countcheck = 0;
				}
				for(int i = 0 ; i < A.size();){
					A.remove(0);
				}
				for(int i = 0; i < B.size();i++){
					for(int j = 0; j < departmentcount; j++){
						if(departlist[j][1] == B.get(i)){
							A.add(countA,departlist[j][0]);
							countcheck++;
							countA++;
						}
					}
					if(countcheck == 0){
						A.add(countA,B.get(i));
						countA++;
					}
					countcheck = 0;
				}
				Atmp = new int[A.size()];
				Btmp = new int[B.size()];
				for(int i = 0; i < A.size(); i++){
					Atmp[i] = A.get(i);
				}
				for(int i = 0; i < B.size(); i++){
					Btmp[i] = B.get(i);
				}
				if(Arrays.equals(Atmp,Btmp)){
					break;
				}
				countcheck = 0;
				countA = 0;
				countB = 0;
			}
			
			pstmt.close();
			rs.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return A;
	}
	
	public int departmentcount(){
		Connection conn = null;
		String sql = "select count(*) from Depart";
		int ret = 0;
		try{
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			ResultSet rs = pstmt.executeQuery(sql);
			
			while(rs.next()){
				ret = rs.getInt(1);
			}
			pstmt.close();
			rs.close();
			conn.close();
	
		}catch(Exception e){
			e.printStackTrace();
		}
		return ret;
	}
	public int usercount(){
		Connection conn = null;
		String sql = "select count(*) from Member";
		int ret = 0;
		try{
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement();
			ResultSet rs = pstmt.executeQuery(sql);
			
			while(rs.next()){
				ret = rs.getInt(1);
			}
			pstmt.close();
			rs.close();
			conn.close();
	
		}catch(Exception e){
			e.printStackTrace();
		}
		return ret;
	}
	
	public void departmentDelete(int idx){
		Connection conn = null;
		String sql = "Delete from depart where idx = " + idx; 
		try{
			Context init = new InitialContext();
			DataSource ds = (DataSource)init.lookup("java:comp/env/jdbc/MssqlDB");
			conn = ds.getConnection();
			Statement pstmt = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE,ResultSet.HOLD_CURSORS_OVER_COMMIT);
			pstmt.executeUpdate(sql);
			
			Statement pstmt2 = conn.createStatement(ResultSet.TYPE_SCROLL_SENSITIVE,ResultSet.CONCUR_UPDATABLE,ResultSet.HOLD_CURSORS_OVER_COMMIT);
			
			sql = "Delete from member where department = " + idx;
			pstmt2.executeUpdate(sql);
			pstmt2.close(); 
			
			sql = "select idx from depart where upNumber = " + idx;
			ResultSet rs = pstmt.executeQuery(sql);
			while(rs.next()){
				idx = rs.getInt(1);
				departmentDelete(idx);
			}
			
			pstmt.close();
			rs.close();
			conn.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
