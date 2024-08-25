package com.ssafy.shinhanflow.config.error.exception;

import com.ssafy.shinhanflow.config.error.ErrorCode;

public class BadRequestException extends  BusinessBaseException{

	public BadRequestException(String message, ErrorCode errorCode) {
		super(message, errorCode);
	}

	public BadRequestException(ErrorCode errorCode) {
		super(errorCode);
	}
}
