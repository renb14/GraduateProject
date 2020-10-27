package com.awsserverless.apigatelambda.requestaction;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.awsserverless.apigatelambda.datamodel.restcity.*;
import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.SearchRestaurantByMap;
import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.SearchRestaurantResponse;
import com.awsserverless.apigatelambda.datamodel.DAOFactory;
//import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.PostUserRequest;
//import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.PostRestuarantResponse;
import com.awsserverless.apigatelambda.exception.BadRequestException;
import com.awsserverless.apigatelambda.exception.DAOException;
//import com.awsserverless.apigatelambda.exception.DAOException;
import com.google.gson.JsonObject;

import java.util.List;

public class SearchRestaurantByMapRequest  extends AbstractRequestAction {
	private LambdaLogger logger;
	public String handler(JsonObject request, Context context) throws BadRequestException{
		logger = context.getLogger();
		logger.log("#############Logger : I am in  SearchRestaurantByMap #########################\n");
		//format input
		SearchRestaurantByMap input = this.getGson().fromJson(request, SearchRestaurantByMap.class);
		logger.log("#############Logger : I am in  SearchRestaurantByMap"  + input + "#########################\n");
		//check input
		if(input == null){
			logger.log("#############Logger : Bad Input #########################\n");
			throw new BadRequestException("Check the Input: the input is invalid ");
		}
		RestCityDAO dao = DAOFactory.getRestCityDAO();
		List<RestCity> listResult = null;

		try {
			listResult = dao.searchRestaurantByMap(input);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SearchRestaurantResponse output = new SearchRestaurantResponse();
		output.setCount(listResult.size());
		output.setRestList(listResult);
		
		return this.getGson().toJson(output);
	}
}

