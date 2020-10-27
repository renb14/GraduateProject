package com.awsserverless.apigatelambda.datamodel.menudish;

import com.awsserverless.apigatelambda.exception.DAOException;

import java.util.List;

public interface DishDataDAO {
	List<DishData> getRestMenuByRestID(String restID) throws DAOException;
}
