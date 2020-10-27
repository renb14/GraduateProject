package com.awsserverless.apigatelambda.datamodel.constructreqandresponse;

public class SearchRestaurantByCity {
	private String restCity;
	private String restState;
	private String restNation;

	public String getRestCity(){
		return this.restCity;
	}
	public void setRestCity(String input){
		this.restCity = input;
	}
	
	public String getRestState(){
		return this.restState;
	}
	public void setRestState(String input){
		this.restState = input;
	}
	
	public String getRestNation(){
		return this.restNation;
	}
	public void setRestNation(String input){
		this.restNation = input;
	}
}
