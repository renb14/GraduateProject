package com.awsserverless.apigatelambda.datamodel.constructreqandresponse;

import java.util.List;

public class PostUserRequest {
	private String deviceID;
	private String eMail;
	private String historyID;
	private List<String> tags;
	private String userName;
	
	public String getDeviceID(){
		return this.deviceID;
	}
	public void setDeviceID(String ID){
		this.deviceID = ID;
	}
	
	public String getEMail(){
		return this.eMail;
	}
	public void setEMail(String email){
		this.eMail = email;
	}
	
	public String getHistoryID(){
		return this.historyID;
	}
	public void setHistoryID(String email){
		this.historyID = email;
	}
	
	public String getUserName(){
		return this.userName;
	}
	public void setUserName(String email){
		this.userName = email;
	}
	
	public List<String> getTagList(){
		return this.tags;
	}
	public void setTagList(List<String> email){
		this.tags = email;
	}
}
