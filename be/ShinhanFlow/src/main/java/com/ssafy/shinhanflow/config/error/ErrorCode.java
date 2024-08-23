package com.ssafy.shinhanflow.config.error;

import org.springframework.http.HttpStatus;

import lombok.Getter;

/*
 *
 * Status code : BadRequest(400), NotFound(401),
 *
 *
 *
 *
 * */
@Getter
public enum ErrorCode {
	METHOD_NOT_ALLOWED(HttpStatus.METHOD_NOT_ALLOWED, "4001", "잘못된 HTTP 메서드를 호출했습니다."),
	INVALID_INPUT_VALUE(HttpStatus.BAD_REQUEST, "4002", "올바르지 않은 입력값입니다."),
	NOT_FOUND(HttpStatus.NOT_FOUND, "4003", "존재하지 않는 엔티티입니다."),
	INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "5001", "서버 에러가 발생했습니다.")
	;

	private final HttpStatus status;
	private final String message;
	private final String code;


	ErrorCode(final HttpStatus status, final String code, final String message) {
		this.status = status;
		this.code = code;
		this.message = message;
	}
}