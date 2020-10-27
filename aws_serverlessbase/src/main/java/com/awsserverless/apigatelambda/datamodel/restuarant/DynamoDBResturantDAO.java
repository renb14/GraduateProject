package com.awsserverless.apigatelambda.datamodel.restuarant;


//import com.amazonaws.auth.BasicAWSCredentials;
import com.amazonaws.services.dynamodbv2.AmazonDynamoDBClient;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBMapper;
import com.amazonaws.services.dynamodbv2.datamodeling.DynamoDBScanExpression;
import com.amazonaws.regions.Region;
import com.amazonaws.regions.Regions;
import com.awsserverless.apigatelambda.exception.DAOException;
import java.util.List;

public class DynamoDBResturantDAO  implements RestuarantDAO {
	private static DynamoDBResturantDAO instance = null;
	private static AmazonDynamoDBClient dbClient = new AmazonDynamoDBClient();
	
	public static DynamoDBResturantDAO getInstance()
	{
		if(instance == null)
		{
			instance = new DynamoDBResturantDAO();
		}
		return instance;
	}
	
	public List<Restuarant> getRestuarantList()
	{
		 //BasicAWSCredentials b = new BasicAWSCredentials("AKIAICTP2FQD5KPZ4MCA","Dzs0vHM6xBkm2vKPZkYw8CLztlE6rQ57cOrk7FEs");
		 //AmazonDynamoDBClient dbClient = new AmazonDynamoDBClient(b);
		// AmazonDynamoDBClient dbClient = new AmazonDynamoDBClient();
		 
		System.out.println("########## Printer:  I am In getRestuarantList  Begin DynamoDBScanExpression ##############\n");
		DynamoDBScanExpression express = new DynamoDBScanExpression();
		System.out.println("########## Printer:  I am In getRestuarantList  End DynamoDBScanExpression ##############\n");
		return getMapper().scan(Restuarant.class, express);
	}
	
	public Restuarant getRestuarantById(String id)
	{
		if(id == null || id.trim().equals(""))
		{
			return null;
		}
		return getMapper().load(Restuarant.class, id);
	}
	
	public String uploadNewRestuarant(Restuarant rest)  throws  DAOException{
		//class check
		if(rest.getRestuarantType() == null || rest.getRestuarantType().trim().equals("") ){
			throw new DAOException("Got a wrong Restuarant Data, Please check out input");
		}
		getMapper().save(rest);
		return rest.getRestuarantID();
	}
	
	protected DynamoDBMapper getMapper()
	{
		dbClient.setRegion(Region.getRegion(Regions.US_WEST_2));
		return new DynamoDBMapper(dbClient);
	}
	
}
