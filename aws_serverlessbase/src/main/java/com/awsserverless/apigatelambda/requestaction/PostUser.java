package com.awsserverless.apigatelambda.requestaction;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.awsserverless.apigatelambda.datamodel.user.UserDAO;
import com.awsserverless.apigatelambda.datamodel.user.User;
import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.PostUserRequest;
import com.awsserverless.apigatelambda.datamodel.DAOFactory;
//import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.PostUserRequest;
//import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.PostRestuarantResponse;
import com.awsserverless.apigatelambda.exception.BadRequestException;
import com.awsserverless.apigatelambda.exception.DAOException;
//import com.awsserverless.apigatelambda.exception.DAOException;
import com.google.gson.JsonObject;

public class PostUser extends AbstractRequestAction  {
	private LambdaLogger logger ;
	public String handler(JsonObject request, Context context) throws BadRequestException{
		logger = context.getLogger();
		PostUserRequest input = this.getGson().fromJson(request, PostUserRequest.class);
		if(input.getDeviceID().trim().equals("") )
		{
			logger.log("############# Logger : INVALID INPUT ###############\n");
			throw new BadRequestException("thow an error : invalid input");
		}
		UserDAO dao = DAOFactory.getUserDAO();
		User user = new User();
		user.setDeviceID(input.getDeviceID());
		user.setEMail(input.getEMail());
		user.setHistoryID(input.getHistoryID());
		user.setUserName(input.getUserName());
		user.setTagList(input.getTagList());
		
		try {
			dao.modifyUserNameByDeviceID(user.getDeviceID(), user);
			} catch (DAOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return getGson().toJson("###### update a user successfully ########");
	}
}
