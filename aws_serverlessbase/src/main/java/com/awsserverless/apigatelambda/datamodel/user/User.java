package com.awsserverless.apigatelambda.datamodel.user;

import com.awsserverless.apigatelambda.comfiguration.DBConfiguration;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBAttribute;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBHashKey;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBTable;
import java.util.List;

@DynamoDBTable(tableName = DBConfiguration.USER_TABLE_NAME)
public class User {
	private String deviceID;
	private String eMail;
	private String historyID;
	private List<String> tags;
	private String userName;
	
	@DynamoDBHashKey(attributeName = "DeviceID")
	public String getDeviceID(){
		return this.deviceID;
	}
	public void setDeviceID(String ID){
		this.deviceID = ID;
	}
	
	@DynamoDBAttribute(attributeName = "EMail")
	public String getEMail(){
		return this.eMail;
	}
	public void setEMail(String email){
		this.eMail = email;
	}
	
	@DynamoDBAttribute(attributeName = "HistoryID")
	public String getHistoryID(){
		return this.historyID;
	}
	public void setHistoryID(String historyID){
		this.historyID = historyID;
	}
	
	@DynamoDBAttribute(attributeName = "UserName")
	public String getUserName(){
		return this.userName;
	}
	public void setUserName(String userName){
		this.userName = userName;
	}
	
	@DynamoDBAttribute(attributeName = "Tags")
	public List<String>  getTagList(){
		return this.tags;
	}
	public void setTagList(List<String> tags){
		this.tags = tags;
	}
}
