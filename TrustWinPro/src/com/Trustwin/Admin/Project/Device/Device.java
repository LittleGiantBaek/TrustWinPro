package com.Trustwin.Admin.Project.Device;

public class Device {

	private String UniqueID;
	
	private String ControllerName;
	
	private String ID;
	
	private String Address;
	
	private String Port;
	
	private String Password;
	
	private String ServerPort;
	
	private int groupIdx;

	
	// get set
	
	public String getUniqueID() {
		return UniqueID;
	}

	public void setUniqueID(String uniqueID) {
		UniqueID = uniqueID;
	}

	public String getControllerName() {
		return ControllerName;
	}

	public void setControllerName(String controllerName) {
		ControllerName = controllerName;
	}

	public int getGroupIdx() {
		return groupIdx;
	}

	public void setGroupIdx(int groupIdx) {
		this.groupIdx = groupIdx;
	}

	public String getID() {
		return ID;
	}

	public void setID(String iD) {
		ID = iD;
	}

	public String getAddress() {
		return Address;
	}

	public void setAddress(String address) {
		Address = address;
	}

	public String getPort() {
		return Port;
	}

	public void setPort(String port) {
		Port = port;
	}

	public String getPassword() {
		return Password;
	}

	public void setPassword(String password) {
		Password = password;
	}

	public String getServerPort() {
		return ServerPort;
	}

	public void setServerPort(String serverPort) {
		ServerPort = serverPort;
	}
	
	
}
