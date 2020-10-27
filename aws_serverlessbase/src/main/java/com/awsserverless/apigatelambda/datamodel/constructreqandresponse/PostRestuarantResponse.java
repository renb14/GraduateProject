package com.awsserverless.apigatelambda.datamodel.constructreqandresponse;

public class PostRestuarantResponse {
	private String restuarantID;
	
	public String getRestuarantID(){
		return this.restuarantID;
	}
	
	public void setRestuarantID(String ID){
		this.restuarantID = ID;
	}
}
