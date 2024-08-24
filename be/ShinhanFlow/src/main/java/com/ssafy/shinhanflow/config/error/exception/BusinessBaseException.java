package com.ssafy.shinhanflow.config.error.exception;

import com.ssafy.shinhanflow.config.error.ErrorCode;

public class BusinessBaseException extends RuntimeException {
	private final ErrorCode errorCode;

	public BusinessBaseException(String message, final ErrorCode errorCode) {
		super(message);
		this.errorCode = errorCode;
	}

	public BusinessBaseException(ErrorCode errorCode) {
		super(errorCode.getMessage());
		this.errorCode = errorCode;
	}

	public ErrorCode getErrorCode() {
		return errorCode;
	}
}
