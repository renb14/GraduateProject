package com.awsserverless.apigatelambda.datamodel.menudish;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBScanExpression;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.awsserverless.apigatelambda.exception.DAOException;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DynamoDBDishDataDAO implements DishDataDAO {
	private static DynamoDBDishDataDAO instance = null;
	private static AmazonDynamoDBClient dynamoClient = new AmazonDynamoDBClient();
	
	public static DynamoDBDishDataDAO getInstance(){
		if(instance ==null)
		{
			instance = new DynamoDBDishDataDAO();
		}
		return instance;
	}
	
	protected DynamoDBMapper getMapper(){
		dynamoClient.setRegion(Region.getRegion(Regions.US_WEST_2));
		return new DynamoDBMapper(dynamoClient);
	}
	
	public List<DishData>  getRestMenuByRestID(String restID) throws DAOException{
		if(restID == null)
		{
			throw new DAOException("DAO got an invalid input");
		}
		//set up search onditions
		Map<String, AttributeValue> conditions = new HashMap<String, AttributeValue>();
		conditions.put(":restid", new AttributeValue().withS(restID));

		
		DynamoDBScanExpression scanExpression = new DynamoDBScanExpression().withFilterExpression("RestID = :restid ").withExpressionAttributeValues(conditions);
		List<DishData> scanResult = this.getMapper().scan(DishData.class, scanExpression);
		System.out.println("########### System" +scanResult.size()+  "###########");
		return scanResult;
	}
}
