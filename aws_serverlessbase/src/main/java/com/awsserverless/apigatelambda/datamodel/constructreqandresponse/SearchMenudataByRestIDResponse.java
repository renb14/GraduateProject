package com.awsserverless.apigatelambda.datamodel.constructreqandresponse;

import com.awsserverless.apigatelambda.datamodel.menudish.DishData;

import java.util.List;

public class SearchMenudataByRestIDResponse {
	private int nCount;
	private List<DishData> listMenudata;
	
	public int getCount(){
		return this.nCount;
	}
	public void setCount(int input){
		this.nCount = input;
	}
	
	public List<DishData> getMenuData(){
		return this.listMenudata;
	}
	public void setMenuData(List<DishData> input){
		this.listMenudata = input;
	}
}
