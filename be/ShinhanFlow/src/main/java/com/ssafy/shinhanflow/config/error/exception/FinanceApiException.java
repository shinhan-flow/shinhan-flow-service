package com.ssafy.shinhanflow.config.error.exception;

import org.springframework.http.HttpStatus;

import lombok.Getter;

@Getter
public class FinanceApiException extends RuntimeException {
	final HttpStatus status = HttpStatus.valueOf(400);
	final String errorCode;

	public FinanceApiException(String errorCode, String message) {
		super(message);
		this.errorCode = errorCode;
	}

}
