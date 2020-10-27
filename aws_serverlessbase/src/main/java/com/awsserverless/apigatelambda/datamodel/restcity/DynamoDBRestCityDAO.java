package com.awsserverless.apigatelambda.datamodel.restcity;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBScanExpression;
import com.amazonaws.services.dynamodbv2.model.AttributeValue;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
//import com.awsserverless.apigatelambda.datamodel.user.DynamoDBUserDAO;
import com.awsserverless.apigatelambda.exception.DAOException;
import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.*;

import java.util.List;
import java.util.Map;
import java.util.HashMap;

public class DynamoDBRestCityDAO implements RestCityDAO {
	private static DynamoDBRestCityDAO instance = null;
	private static AmazonDynamoDBClient dynamoClient = new AmazonDynamoDBClient();
	
	public static DynamoDBRestCityDAO getInstance(){
		if(instance ==null)
		{
			instance = new DynamoDBRestCityDAO();
		}
		return instance;
	}
	
	

	protected DynamoDBMapper getMapper(){
		dynamoClient.setRegion(Region.getRegion(Regions.US_WEST_2));
		return new DynamoDBMapper(dynamoClient);
	}



	public List<RestCity> searchRestaurantByCity(SearchRestaurantByCity input) throws DAOException{
		// don't need to check the input?
		if(input == null)
		{
			throw new DAOException("DAO got an invalid input");
		}
		//set up search onditions
		Map<String, AttributeValue> conditions = new HashMap<String, AttributeValue>();
		conditions.put(":city", new AttributeValue().withS(input.getRestCity()));
		conditions.put(":nation", new AttributeValue().withS(input.getRestNation()));
		conditions.put(":state", new AttributeValue().withS(input.getRestState()));
		
		DynamoDBScanExpression scanExpression = new DynamoDBScanExpression().withFilterExpression("restCity = :city and restNation = :nation and restState = :state ").withExpressionAttributeValues(conditions);
		//DynamoDBScanExpression scanExpression = new DynamoDBScanExpression().withFilterExpression("restCity = :city").withExpressionAttributeValues(conditions);
		List<RestCity> scanResult = this.getMapper().scan(RestCity.class, scanExpression);
		//System.out.println("############## System : " + scanResult.size() + "##############\n");
		return scanResult;
	}
	public List<RestCity> searchRestaurantByMap(SearchRestaurantByMap input) throws DAOException{
		// don't need to check the input?
				if(input == null)
				{
					throw new DAOException("DAO got an invalid input");
				}
				//set up search onditions
				Map<String, AttributeValue> conditions = new HashMap<String, AttributeValue>();
				
				conditions.put(":maxLong", new AttributeValue().withN(Float.toString(input.getMaxLongitude())));
				conditions.put(":minLong", new AttributeValue().withN(Float.toString(input.getMinLongitude())));
				conditions.put(":minLat", new AttributeValue().withN(Float.toString(input.getMinLatitude())));
				conditions.put(":maxLat", new AttributeValue().withN(Float.toString(input.getMaxLatitude())));
				
				
				DynamoDBScanExpression scanExpression = new DynamoDBScanExpression().withFilterExpression(":minLat< latitude and latitude < :maxLat and :minLong < longitude and  longitude < :maxLong ").withExpressionAttributeValues(conditions);
				List<RestCity> scanResult = this.getMapper().scan(RestCity.class, scanExpression);
				
				return scanResult;
	}
}
