package com.awsserverless.apigatelambda.datamodel.restcity;

import com.awsserverless.apigatelambda.comfiguration.DBConfiguration;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBAttribute;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBHashKey;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBTable;

@DynamoDBTable(tableName = DBConfiguration.RESTCITY_TABLE_NAME)
public class RestCity {
	private String restID;
	private String restCity;
	private String restState;
	private String restNation;
	private float longitude;
	private float latitude;
	private String typeTag;
	private String restAddress;
	private String restName;
	private String restPhone;
	private String restMenu;
	
	@DynamoDBHashKey(attributeName = "restID")
	public String getRestID(){
		return this.restID;
	}
	public void setRestID(String id){
		this.restID = id;
	}
	
	@DynamoDBAttribute(attributeName = "restCity")
	public String getRestCity(){
		return this.restCity;
	}
	public void setRestCity(String input){
		this.restCity = input;
	}
	
	@DynamoDBAttribute(attributeName = "restState")
	public String getRestState(){
		return this.restState;
	}
	public void setRestState(String input){
		this.restState = input;
	}
	
	@DynamoDBAttribute(attributeName = "restNation")
	public String getRestNation(){
		return this.restNation;
	}
	public void setRestNation(String input){
		this.restNation = input;
	}
	
	@DynamoDBAttribute(attributeName = "typeTag")
	public String getTypeTag(){
		return this.typeTag;
	}
	public void setTypeTag(String input){
		this.typeTag = input;
	}
	
	@DynamoDBAttribute(attributeName = "longitude")
	public float getLongitude(){
		return this.longitude;
	}
	public void setLongitude(float input){
		this.longitude = input;
	}
	
	@DynamoDBAttribute(attributeName = "latitude")
	public float getLatitude(){
		return this.latitude;
	}
	public void setLatitude(float input){
		this.latitude = input;
	}
	
	
	@DynamoDBAttribute(attributeName = "restAddress")
	public String getRestAddress(){
		return this.restAddress;
	}
	public void setRestAddress(String input){
		this.restAddress = input;
	}
	
	@DynamoDBAttribute(attributeName = "restName")
	public String getRestName(){
		return this.restName;
	}
	public void setRestName(String input){
		this.restName = input;
	}
	
	@DynamoDBAttribute(attributeName = "restPhone")
	public String getRestPhone(){
		return this.restPhone;
	}
	public void setRestPhone(String input){
		this.restPhone = input;
	}

	@DynamoDBAttribute(attributeName = "restMenu")
	public String getRestMenu(){
		return this.restMenu;
	}
	public void setRestMenu(String input){
		this.restMenu = input;
	}
}
