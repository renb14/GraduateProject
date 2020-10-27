package com.awsserverless.apigatelambda.datamodel.constructreqandresponse;

public class SearchRestaurantByMap {
	private float minLongitude;
	private float maxLongitude;
	private float minLatitude;
	private float maxLatitude;

	
	
	public float getMinLongitude(){
		return this.minLongitude;
	}
	public void setMinLongitude(float input){
		this.minLongitude = input;
	}
	
	
	public float getMaxLongitude(){
		return this.maxLongitude;
	}
	public void setMaxLongitude(float input){
		this.maxLongitude = input;
	}
	public float getMinLatitude(){
		return this.minLatitude;
	}
	public void setMinLatitude(float input){
		this.minLatitude = input;
	}
	
	public float getMaxLatitude(){
		return this.maxLatitude;
	}
	public void setMaxLatitude(float input){
		this.maxLatitude = input;
	}
}
