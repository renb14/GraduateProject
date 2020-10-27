package com.awsserverless.apigatelambda.datamodel.user;

import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.awsserverless.apigatelambda.exception.DAOException;

public class DynamoDBUserDAO implements UserDAO {
	private static DynamoDBUserDAO instance = null;
	private static AmazonDynamoDBClient dynamoClient = new AmazonDynamoDBClient();
	
	public static DynamoDBUserDAO getInstance(){
		if(instance ==null)
		{
			instance = new DynamoDBUserDAO();
		}
		return instance;
	}
	

	public void  postUser(User user) throws DAOException {

		if (user == null || user.getDeviceID().trim().equals("") )
		{
			throw new DAOException("############postUser get a wrong input##########\n");
		}
		getMapper().save(user);

	}
	public void modifyUserNameByDeviceID(String deviceID, User user) throws DAOException{
		User retrivedUser = getMapper().load(User.class,deviceID);
		if( retrivedUser == null)
		{
			postUser(user);
		}
		else
		{
			 retrivedUser.setEMail(user.getEMail());
			 retrivedUser.setHistoryID(user.getHistoryID());
			 retrivedUser.setTagList(user.getTagList());
			 retrivedUser.setUserName(user.getUserName());
			 getMapper().save(retrivedUser);
		}
	}
	
	public User getSpecifiedUserByDeviceID(String deviceID) throws DAOException{
		User retrivedUser = getMapper().load(User.class,deviceID);
		return retrivedUser;
	}
	
	protected DynamoDBMapper getMapper(){
		dynamoClient.setRegion(Region.getRegion(Regions.US_WEST_2));
		return new DynamoDBMapper(dynamoClient);
	}
}
