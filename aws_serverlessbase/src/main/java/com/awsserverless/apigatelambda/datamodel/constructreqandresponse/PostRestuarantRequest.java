package com.awsserverless.apigatelambda.datamodel.constructreqandresponse;

public class PostRestuarantRequest {
	/*
	 * the class is used to create a restuarant Http request
	 * */
	private String restuarantName;
	private String restuarantType;
	private String longitude;
	private String latitude;
	
	public String getRestaurantName(){
		return this.restuarantName;
	}
	public void setRestaurantName(String restaurantName){
		this.restuarantName = restaurantName;
	}
	
	public String getRestaurantType(){
		return this.restuarantType;
	}
	public void setRestaurantType(String restaurantType){
		this.restuarantType = restaurantType;
	}
	
	public String getLongitude(){
		return this.longitude;
	}
	public void setLongitude(String Longitude){
		this.longitude = Longitude;
	}
	
	public String getLatitude(){
		return this.latitude;
	}
	public void setLatitude(String Latitude){
		this.latitude = Latitude;
	}
	
}
