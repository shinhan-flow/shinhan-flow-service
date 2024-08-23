package com.ssafy.shinhanflow.config.error;

import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
public class ErrorResponse {

	private String code;
	private String message;

	private ErrorResponse(final ErrorCode code) {
		this.code = code.getCode();
		this.message = code.getMessage();
	}

	public static ErrorResponse of(final ErrorCode code) {
		return new ErrorResponse(code);
	}

}
