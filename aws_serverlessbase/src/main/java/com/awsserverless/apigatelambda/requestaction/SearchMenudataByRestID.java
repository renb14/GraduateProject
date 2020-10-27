package com.awsserverless.apigatelambda.requestaction;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.awsserverless.apigatelambda.datamodel.DAOFactory;
import com.awsserverless.apigatelambda.datamodel.menudish.DishDataDAO;
import com.awsserverless.apigatelambda.datamodel.menudish.DishData;
import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.SearchMenudataByRestIDResponse;
import com.awsserverless.apigatelambda.exception.BadRequestException;
import com.awsserverless.apigatelambda.exception.DAOException;
import com.awsserverless.apigatelambda.exception.InternalErrorException;
import com.google.gson.JsonObject;

import java.util.List;
public class SearchMenudataByRestID extends AbstractRequestAction {
	private LambdaLogger logger;
	public String handler(JsonObject request, Context context) throws BadRequestException, InternalErrorException{
		logger = context.getLogger();
		logger.log("################ Logger : I am in SearchMenudataByRestID ##############\n");
		
		String restID = request.get("fandianID").getAsString();
		if(restID == null || restID.trim().equals("")){
			logger.log("########### Logger : SearchMenudataByRestID  ###################\n");
			throw new BadRequestException("SearchMenudataByRestID Invalid request\n");
		}
		logger.log("################ Logger : I am in SearchMenudataByRestID " + restID + " ##############\n");
		DishDataDAO dao = DAOFactory.getDishDataDAO();
		List<DishData> tmp = null;
		
		try {
			tmp = dao.getRestMenuByRestID(restID);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		SearchMenudataByRestIDResponse response = new SearchMenudataByRestIDResponse();
		response.setCount(tmp.size());
		response.setMenuData(tmp);
		
		String result =  this.getGson().toJson(response);
		return result;
	}
}
