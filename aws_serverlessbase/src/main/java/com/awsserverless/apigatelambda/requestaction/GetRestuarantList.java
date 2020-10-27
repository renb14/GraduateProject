package com.awsserverless.apigatelambda.requestaction;

import com.amazonaws.services.lambda.runtime.Context;
import com.amazonaws.services.lambda.runtime.LambdaLogger;
import com.awsserverless.apigatelambda.datamodel.restuarant.RestuarantDAO;
import com.awsserverless.apigatelambda.datamodel.restuarant.Restuarant;
import com.awsserverless.apigatelambda.datamodel.DAOFactory;

import com.google.gson.JsonObject;
import java.util.List;
import java.util.ArrayList;

public class GetRestuarantList  extends AbstractRequestAction {
	private static LambdaLogger logger;
	public String handler(JsonObject request, Context context) 
	{
		logger = context.getLogger();
		List<Restuarant> list ;
		boolean bRequestNull = true;
		logger.log("#################Logger : I am in handler ################\n");
		
		RestuarantDAO dao = DAOFactory.getRestuarantDAO();
		logger.log("#################Logger : I am in handler after  ################\n");
		
		if(request != null)
		{
			int nLen = request.toString().trim().length();
			if (nLen > 2)
				bRequestNull = false;
		}
		
		if (bRequestNull)
		{
			logger.log("############# Logger: I got null request #################\n");
			list = dao.getRestuarantList();
		}
		else
		{
			logger.log("#################Logger : I am in handler after   request is not null  "+ request + "################\n");

				String restuarantID = request.get("restuarantID").getAsString();
				Restuarant rest = dao.getRestuarantById(restuarantID);
				list = new ArrayList<Restuarant>();
				list.add(rest);
		}
		logger.log("#################Logger : I am in handler  : I have found data ################");
		return getGson().toJson(list);
	} 
}
