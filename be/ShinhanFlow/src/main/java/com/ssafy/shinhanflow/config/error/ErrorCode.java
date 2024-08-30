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
	RESOURCE_NOT_FOUND(HttpStatus.NOT_FOUND, "4000", "요청하신 리소스를 찾을 수 없습니다."),
	METHOD_NOT_ALLOWED(HttpStatus.METHOD_NOT_ALLOWED, "4001", "잘못된 HTTP 메서드를 호출했습니다."),
	INVALID_INPUT_VALUE(HttpStatus.BAD_REQUEST, "4002", "올바르지 않은 입력값입니다."),
	NOT_FOUND(HttpStatus.NOT_FOUND, "4003", "존재하지 않는 엔티티입니다."),
	INVALID_TOKEN(HttpStatus.BAD_REQUEST, "4004", "토큰이 유효하지 않습니다."),
	EXPIRED_TOKEN(HttpStatus.BAD_REQUEST, "4005", "토큰이 만료됐습니다."),
	NULL_REQUIRED_VALUE(HttpStatus.BAD_REQUEST, "4006", "필수 요청값이 비어있습니다."),
	INVALID_CREDENTIALS(HttpStatus.BAD_REQUEST, "4007", "아이디 또는 비밀번호가 올바르지 않습니다."),

	INVALID_ACCOUNT_TYPE(HttpStatus.BAD_REQUEST, "4008", "올바르지 않은 계좌 유형입니다."),
	INVALID_ACCOUNT_NUMBER(HttpStatus.BAD_REQUEST, "4009", "올바르지 않은 계좌 번호입니다."),
	INVALID_TRIGGER_CONDITION(HttpStatus.BAD_REQUEST, "4010", "올바르지 않은 트리거 조건입니다."),
	NO_TOKEN(HttpStatus.BAD_REQUEST, "4012", "토큰이 존재하지 않습니다."),

	INTERNAL_SERVER_ERROR(HttpStatus.INTERNAL_SERVER_ERROR, "5001", "서버 에러가 발생했습니다."),
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