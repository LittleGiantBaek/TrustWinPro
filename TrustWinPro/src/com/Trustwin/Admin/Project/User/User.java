package com.Trustwin.Admin.Project.User;

public class User {

	private String id;
	
	private String name;
	
	private String userId;
	
	private String userClass;
	
	private int department;

	private String firstName;
	
	private String middleName;
	
	private String lastName;
	
	private String passWord;
	
	private String CompanyID;

	private String FP1;
	
	private String FP2;
	
	public String getFP1() {
		return FP1;
	}

	public void setFP1(String fP1) {
		FP1 = fP1;
	}

	public String getFP2() {
		return FP2;
	}

	public void setFP2(String fP2) {
		FP2 = fP2;
	}

	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getDepartment() {
		return department;
	}

	public void setDepartment(int department) {
		this.department = department;
	}

	public String getUserClass() {
		return userClass;
	}

	public void setUserClass(String userClass) {
		this.userClass = userClass;
	}

	public String getFirstName() {
		return firstName;
	}

	public void setFirstName(String firstName) {
		this.firstName = firstName;
	}

	public String getMiddleName() {
		return middleName;
	}

	public void setMiddleName(String middleName) {
		this.middleName = middleName;
	}

	public String getLastName() {
		return lastName;
	}

	public void setLastName(String lastName) {
		this.lastName = lastName;
	}

	public String getPassWord() {
		return passWord;
	}

	public void setPassWord(String passWord) {
		this.passWord = passWord;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public String getCompanyID() {
		return CompanyID;
	}

	public void setCompanyID(String companyID) {
		CompanyID = companyID;
	}
	
}
