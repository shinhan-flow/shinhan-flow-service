package com.ssafy.shinhanflow.config.error.exception;

import com.ssafy.shinhanflow.config.error.ErrorCode;

public class NotFoundException extends BusinessBaseException {

	public NotFoundException(ErrorCode errorCode) {
		super(errorCode.getMessage(), errorCode);
	}

	public NotFoundException() {
		super(ErrorCode.NOT_FOUND);
	}
}
