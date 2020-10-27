package com.awsserverless.apigatelambda.datamodel.restuarant;

import com.awsserverless.apigatelambda.datamodel.restuarant.Restuarant;
import com.awsserverless.apigatelambda.exception.DAOException;

import java.util.List;

public interface RestuarantDAO {
	Restuarant getRestuarantById(String id);
	List<Restuarant> getRestuarantList();
	 String uploadNewRestuarant(Restuarant rest)  throws  DAOException; 
}
