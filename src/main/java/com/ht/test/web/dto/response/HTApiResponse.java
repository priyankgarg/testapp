package com.ht.test.web.dto.response;

import com.ht.test.error.HTException;

public class HTApiResponse {
	private Object data;
	private HTException error;
	public Object getData() {
		return data;
	}
	public void setData(Object data) {
		this.data = data;
	}
	public HTException getError() {
		return error;
	}
	public void setError(HTException error) {
		this.error = error;
	}
	public void setError(Exception exception) {
		HTException error;
		if(exception instanceof HTException){
			error = (HTException) exception;
		} else {
			error = new HTException(exception);
		}
		this.error = error;
	}
	
	public void setError(String message) {
		HTException error = new HTException(message);
		this.error = error;
	}
}
