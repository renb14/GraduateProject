package com.awsserverless.apigatelambda.requestaction;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.awsserverless.apigatelambda.datamodel.user.UserDAO;
import com.awsserverless.apigatelambda.datamodel.user.User;
import com.awsserverless.apigatelambda.datamodel.DAOFactory;
import com.awsserverless.apigatelambda.exception.BadRequestException;
import com.awsserverless.apigatelambda.exception.DAOException;
import com.google.gson.JsonObject;

public class GetSpecifiedUserRequest extends AbstractRequestAction {
	private LambdaLogger logger = null;
	public String handler(JsonObject request, Context context) throws BadRequestException{
		logger = context.getLogger();
		String input = request.get("deviceID").getAsString();
		if(input == null || input.trim().equals(""))
		{
			logger.log("########### Logger : GetSpecifiedUserRequest got a invalid input ##########\n");
			throw new BadRequestException("GetSpecifiedUserRequest got a invalid input");
		}
		String deviceID = input.trim();
		UserDAO dao = DAOFactory.getUserDAO();
		User user = null;
		try {
			user = dao.getSpecifiedUserByDeviceID(deviceID);
		} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String result = null;
		if(user != null)
			result =  this.getGson().toJson(user);
		return result;
	}

}
