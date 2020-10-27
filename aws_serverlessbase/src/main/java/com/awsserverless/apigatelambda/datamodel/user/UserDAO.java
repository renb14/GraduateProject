package com.awsserverless.apigatelambda.datamodel.user;

import com.awsserverless.apigatelambda.exception.DAOException;

public interface UserDAO {
	void postUser(User user) throws DAOException;
	void modifyUserNameByDeviceID(String deviceID, User user) throws DAOException;
	User getSpecifiedUserByDeviceID(String deviceID) throws DAOException;
}
