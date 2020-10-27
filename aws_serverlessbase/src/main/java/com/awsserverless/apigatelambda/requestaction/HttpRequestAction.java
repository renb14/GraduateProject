package com.awsserverless.apigatelambda.requestaction;

import com.awsserverless.apigatelambda.exception.BadRequestException;
import com.awsserverless.apigatelambda.exception.InternalErrorException;
import com.amazonaws.services.lambda.runtime.Context;
//import com.google.gson.Gson;
//import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

public interface HttpRequestAction {
	String handler(JsonObject request, Context context) throws BadRequestException, InternalErrorException;
}
