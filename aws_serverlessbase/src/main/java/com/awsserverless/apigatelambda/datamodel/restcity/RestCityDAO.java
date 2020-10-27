package com.awsserverless.apigatelambda.datamodel.restcity;

import com.awsserverless.apigatelambda.exception.DAOException;
import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.SearchRestaurantByMap;
import com.awsserverless.apigatelambda.datamodel.constructreqandresponse.SearchRestaurantByCity;

import java.util.List;

public interface RestCityDAO {
	List<RestCity> searchRestaurantByCity(SearchRestaurantByCity input) throws DAOException;
	List<RestCity> searchRestaurantByMap(SearchRestaurantByMap input) throws DAOException;
}
