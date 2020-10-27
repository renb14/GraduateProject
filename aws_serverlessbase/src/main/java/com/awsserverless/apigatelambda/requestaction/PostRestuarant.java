package com.awsserverless.apigatelambda.requestaction;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.awsserverless.apigatelambda.datamodel.restuarant.RestuarantDAO;
import com.awsserverless.apigatelambda.datamodel.restuarant.Restuarant;
import com.awsserverless.apigatelambda.datamodel.DAOFactory;
import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.PostRestuarantRequest;
import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.PostRestuarantResponse;
import com.awsserverless.apigatelambda.exception.BadRequestException;
import com.awsserverless.apigatelambda.exception.DAOException;
import com.google.gson.JsonObject;


public class PostRestuarant extends AbstractRequestAction {
	private static LambdaLogger logger;
	public String handler(JsonObject request, Context context) throws BadRequestException
	{
		logger = context.getLogger();
		logger.log("########### Logger: I am in PostRestuarant.handler ##########\n" );
		logger.log("########### Logger: I am in PostRestuarant. request : "  + request + "#################\n" );
		PostRestuarantRequest input = this.getGson().fromJson(request, PostRestuarantRequest.class);
		logger.log("########### Logger: I am in PostRestuarant. input : "  + this.getGson().toJson(input) + "#################\n" );
		if(input == null || input.getRestaurantType() == null || input.getRestaurantType().trim().equals("") )
		{
			throw new BadRequestException("invalid input");
		}
		
		RestuarantDAO restDAO = DAOFactory.getRestuarantDAO();
		Restuarant rest = new Restuarant();
		rest.setRestuarantName(input.getRestaurantName());
		rest.setRestuarantType(input.getRestaurantType());
		rest.setLongitude(input.getLongitude());
		rest.setLatitude(input.getLatitude());
		String restID = null;
		try {
			restID = restDAO.uploadNewRestuarant(rest);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if (restID == null || restID.trim().equals(""))
		{
			logger.log("################## Logger : Cannot get restuarant ID #################");
			throw new BadRequestException("cannot update dynamodb");
		}
		PostRestuarantResponse response = new PostRestuarantResponse();
		response.setRestuarantID(restID);
		
		return this.getGson().toJson(response);
	}
}
