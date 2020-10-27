package com.awsserverless.apigatelambda.datamodel;

import com.awsserverless.apigatelambda.datamodel.restuarant.RestuarantDAO;
import com.awsserverless.apigatelambda.datamodel.restuarant.DynamoDBResturantDAO;
import com.awsserverless.apigatelambda.datamodel.user.DynamoDBUserDAO;
import com.awsserverless.apigatelambda.datamodel.user.UserDAO;
import com.awsserverless.apigatelambda.datamodel.restcity.DynamoDBRestCityDAO;
import com.awsserverless.apigatelambda.datamodel.restcity.RestCityDAO;
import com.awsserverless.apigatelambda.datamodel.menudish.DishDataDAO;
import com.awsserverless.apigatelambda.datamodel.menudish.DynamoDBDishDataDAO;

public class DAOFactory {
	public enum DAOType {
		DynamoDB
	}
	
	public static RestuarantDAO getRestuarantDAO(){
		return getRestuarantDAO(DAOType.DynamoDB);
	}
	
	public static RestuarantDAO getRestuarantDAO(DAOType type)
	{
		RestuarantDAO dao = null;
		switch(type) {
			case DynamoDB:
				dao = DynamoDBResturantDAO.getInstance();
				break;
		}
		return dao;
	}
	public static UserDAO getUserDAO(DAOType type)
	{
		UserDAO dao = null;
		switch(type){
			case DynamoDB:
				dao = DynamoDBUserDAO.getInstance();
				break;
		}
		return dao;
	}
	public static UserDAO getUserDAO(){
		return getUserDAO(DAOType.DynamoDB);
	}
	
	public static RestCityDAO getRestCityDAO(DAOType type)
	{
		RestCityDAO dao = null;
		switch(type){
			case DynamoDB:
				dao = DynamoDBRestCityDAO.getInstance();
				break;
		}
		return dao;
	}
	public static RestCityDAO getRestCityDAO(){
		return getRestCityDAO(DAOType.DynamoDB);
	}
	
	public static DishDataDAO getDishDataDAO()
	{
		return getDishDataDAO(DAOType.DynamoDB);
	}
	
	public static DishDataDAO getDishDataDAO(DAOType type)
	{
		DishDataDAO dao = null;
		switch(type){
		case DynamoDB:
			dao = DynamoDBDishDataDAO.getInstance();
			break;
		}
		return dao;
	}
}
