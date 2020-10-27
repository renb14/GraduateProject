package com.awsserverless.apigatelambda;

import org.apache.commons.io.IOUtils;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.IOException;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.google.gson.JsonParser;
import com.google.gson.JsonObject;
import com.awsserverless.apigatelambda.exception.InternalErrorException;
import com.awsserverless.apigatelambda.exception.BadRequestException;
import com.awsserverless.apigatelambda.requestaction.HttpRequestAction;

public class RequestRouter {

	public static void lambdaHandler(InputStream request, OutputStream response, Context context) throws InternalErrorException, BadRequestException
	{
		LambdaLogger logger  = context.getLogger();
		logger.log("###############LOGGER : Got in lambdaHandler latest ###############\n");
		JsonParser parser = new JsonParser();
		JsonObject inputObj;
		try{
			inputObj = parser.parse(IOUtils.toString(request)).getAsJsonObject();
		} catch(IOException e) {
			logger.log("Error  while Parsing request " + e.getMessage());
			throw new InternalErrorException(e.getMessage());
		}
		
		if(inputObj == null || inputObj.get("action") == null || inputObj.get("action").getAsString().trim().equals(""))
		{
			logger.log("Invalid inputObj, cannot find action");
			throw new BadRequestException("cannot find action parameter");
		}
		
		String requestactionClass = inputObj.get("action").getAsString();
		HttpRequestAction requestAction = null;
		
			try {
				try {
					requestAction= HttpRequestAction.class.cast( Class.forName(requestactionClass).newInstance( ) );
				} catch (ClassNotFoundException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			} catch (InstantiationException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IllegalAccessException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		
		JsonObject body = null;
		
		if(inputObj.get("body") != null){
			body = inputObj.get("body").getAsJsonObject();
		}
		logger.log("######## Logger : " + inputObj.get("body")  + "##################\n");
		String output = requestAction.handler(body, context);
		
		try {
			IOUtils.write(output, response);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
	}
}
