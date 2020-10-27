package com.awsserverless.apigatelambda.requestaction;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

public abstract class AbstractRequestAction implements HttpRequestAction {

	protected Gson getGson() {
		return new GsonBuilder().setPrettyPrinting().create();
	}
}
