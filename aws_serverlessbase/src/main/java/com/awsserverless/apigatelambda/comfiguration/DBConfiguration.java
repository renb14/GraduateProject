package com.awsserverless.apigatelambda.comfiguration;

public class DBConfiguration {
	public static final String RESTAURANT_TABLE_NAME = "restaurants";
	public static final String USER_TABLE_NAME = "RestuarantUsers";
	public static final String RESTCITY_TABLE_NAME = "RestCity";
	public static final String RESTMENUOLLETION_TABLE_NAME = "RestDishCollection";
	
	public enum SearchType{
		SearchRestaurantBYCITY ,
		SearchRestaurantBYMAP,
		SearchRestaurantBYTag
	}
}


