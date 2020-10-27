package com.awsserverless.apigatelambda.datamodel.menudish;

import java.util.List;

import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBAttribute;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBAutoGeneratedKey;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBHashKey;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBTable;
import com.awsserverless.apigatelambda.comfiguration.DBConfiguration;

@DynamoDBTable(tableName = DBConfiguration.RESTMENUOLLETION_TABLE_NAME )
public class DishData {
	private String dishIDAutoGenerated;
	private String dishID;
	private String dishUrl;
	private float dishPrice;
	private List<String> dishTags;
	private String description;
	private String dishType;
	private String restID;

	/*

	*/
	@DynamoDBAttribute(attributeName = "DishIDAutoGenerated")
	public String getDishIDAutoGenerated(){
		return this.dishIDAutoGenerated;
	}
	public void setDishIDAutoGenerated(String input){
		this.dishIDAutoGenerated = input;
	}
	
	@DynamoDBAttribute(attributeName = "DishID")
	public String getDishID(){
		return this.dishID;
	}
	public void setDishID(String input){
		this.dishID = input;
	}
	
	@DynamoDBAttribute(attributeName = "DishPrice")
	public float getDishPrice(){
		return this.dishPrice;
	}
	public void setDishPrice(float input){
		this.dishPrice = input;
	}
	
	@DynamoDBAttribute(attributeName = "Description")
	public String getDescription(){
		return this.description;
	}
	public void setDescription(String input){
		this.description = input;
	}
	
	@DynamoDBAttribute(attributeName = "DishType")
	public String getDishType(){
		return this.dishType;
	}
	public void setDishType(String input){
		this.dishType = input;
	}
	/*
	@DynamoDBAttribute(attributeName = "DishType")
	public String getDishType(){
		return this.dishType;
	}
	public void seDishType(String input){
		this.dishType = input;
	}
	*/
	@DynamoDBAttribute(attributeName = "RestID")
	public String getDestID(){
		return this.restID;
	}
	public void setDestID(String input){
		this.restID = input;
	}

	@DynamoDBAttribute(attributeName = "DishTags")
	public List<String> getDishTags(){
		return this.dishTags;
	}
	public void setDishTags(List<String> input){
		this.dishTags = input;
	}
	
	@DynamoDBAttribute(attributeName = "DishUrl")
	public String getDishUrl(){
		return this.dishUrl;
	}
	public void setDishUrl(String input){
		this.dishUrl = input;
	}
}