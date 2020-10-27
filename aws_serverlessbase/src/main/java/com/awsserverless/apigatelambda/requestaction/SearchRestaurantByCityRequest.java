package com.awsserverless.apigatelambda.requestaction;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.awsserverless.apigatelambda.datamodel.restcity.*;
import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.SearchRestaurantByCity;
import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.SearchRestaurantResponse;
import com.awsserverless.apigatelambda.datamodel.DAOFactory;
//import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.PostUserRequest;
//import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.PostRestuarantResponse;
import com.awsserverless.apigatelambda.exception.BadRequestException;
import com.awsserverless.apigatelambda.exception.DAOException;
//import com.awsserverless.apigatelambda.exception.DAOException;
import com.google.gson.JsonObject;

import java.util.List;

public class SearchRestaurantByCityRequest extends AbstractRequestAction {
	private LambdaLogger logger;
	public String handler(JsonObject request, Context context) throws BadRequestException{
		logger = context.getLogger();
		logger.log("#############Logger : I am in  SearchRestaurantByCityRequest #########################\n");
		//format input
		SearchRestaurantByCity input = this.getGson().fromJson(request, SearchRestaurantByCity.class);
		//logger.log("#############Logger : I am in  SearchRestaurantByCityRequest"  + input.toString() + "#########################\n");
		//check input
		if(input == null || input.getRestCity().trim().equals("") || input.getRestNation().trim().equals("") || input.getRestState().trim().equals("")){
			logger.log("#############Logger : Bad Input #########################\n");
			throw new BadRequestException("Check the Input: the input is invalid ");
		}
		RestCityDAO dao = DAOFactory.getRestCityDAO();
		List<RestCity> listResult = null;
		try {
			listResult = dao.searchRestaurantByCity(input);
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
