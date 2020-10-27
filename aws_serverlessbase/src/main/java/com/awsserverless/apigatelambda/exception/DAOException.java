package com.awsserverless.apigatelambda.exception;

@SuppressWarnings("serial")
public class DAOException extends Exception {
	public DAOException(String s, Exception e){
		super(s,e);
	}
	
	public DAOException(String s){
		super(s);
	}
}
