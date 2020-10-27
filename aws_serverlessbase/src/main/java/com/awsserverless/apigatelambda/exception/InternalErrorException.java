package com.awsserverless.apigatelambda.exception;

@SuppressWarnings("serial")
public class InternalErrorException extends Exception {
	private static final String PREFIX = "INT_ERROR";
	
	public InternalErrorException(String s, Exception e)
	{
		super(PREFIX + s, e);
	}
	public InternalErrorException(String s)
	{
		super(PREFIX + s);
	}
}
