package com.awsserverless.apigatelambda.datamodel.constructreqandresponse;

import java.util.List;
import com.awsserverless.apigatelambda.datamodel.restcity.RestCity;

public class SearchRestaurantResponse {
	private int nCount;
	private List<RestCity> listResult;
	
	public int getCount(){
		return this.nCount;
	}
	
	public void setCount(int nSize){
		this.nCount = nSize;
	}
	
	public List<RestCity> getRestList(){
		return this.listResult;
	}
	
	public void setRestList(List<RestCity> input){
		this.listResult = input;
	}
}
