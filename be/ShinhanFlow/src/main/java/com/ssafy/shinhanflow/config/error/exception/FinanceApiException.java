package com.ssafy.shinhanflow.config.error.exception;

import org.springframework.http.HttpStatusCode;

import lombok.Getter;

@Getter
public class FinanceApiException extends RuntimeException {
	final HttpStatusCode httpStatusCode;
	final String errorCode;

	public FinanceApiException(HttpStatusCode httpStatusCode, String errorCode, String message) {
		super(message);
		this.httpStatusCode = httpStatusCode;
		this.errorCode = errorCode;
	}

}
