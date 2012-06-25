package com.hypermatix.entitybean.test;

import javax.validation.constraints.*;

public class EntityBean {
	private String prop_value, prop2_value;
	
	
	public String getTestProperty(){
		return prop_value; 
	}
	
	@NotNull
	public void setTestProperty(String value){
		this.prop_value = value;
	}
	
	public String getSecondTestProperty(){
		return prop2_value; 
	}
	
	public void setSecondTestProperty(String value){
		this.prop2_value = value;
	}
}
