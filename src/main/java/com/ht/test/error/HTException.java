package com.ht.test.error;

import java.util.HashMap;
import java.util.Map;

public class HTException extends Exception {
	private static final long serialVersionUID = 1000L;
	private String errorCode;
	Map<String, String> attributes = new HashMap<String, String>();
	
	public HTException(){
		super();
	}
	
	public HTException(Exception e){
		super(e);
		this.errorCode = "0x111111";
	}
	
	public HTException(String message){
		super(message);
	}
	
	public void setAttribute(String attributeName, String value){
		
	}
	
	public void getAttribute(String attributeName){
		
	}

	public Map<String, String> getAttributes() {
		return attributes;
	}

	public String getErrorCode() {
		return errorCode;
	}

	public void setErrorCode(String errorCode) {
		this.errorCode = errorCode;
	}
	
	public StackTraceElement [] getStackTrace(){
		return null;
	}
}
