package com.ssafy.shinhanflow.config.error;

import org.springframework.http.ResponseEntity;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;

import com.ssafy.shinhanflow.config.error.exception.BusinessBaseException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@ControllerAdvice // 모든 컨트롤러에서 발생하는 예외를 잡아서 처리
public class GlobalExceptionHandler {
	@ExceptionHandler(HttpRequestMethodNotSupportedException.class)
	protected ResponseEntity<ErrorResponse> handle(HttpRequestMethodNotSupportedException e){
		log.error("HttpRequestMethodNotSupportedException", e);
		return createErrorResponseEntity(ErrorCode.METHOD_NOT_ALLOWED);
	}

	@ExceptionHandler(BusinessBaseException.class)
	protected ResponseEntity<ErrorResponse> handle(BusinessBaseException e){
		log.error("BusinessException", e);
		return createErrorResponseEntity(e.getErrorCode());
	}

	@ExceptionHandler(Exception.class)
	protected ResponseEntity<ErrorResponse> handle(Exception e){
		e.printStackTrace();
		log.error("Exception", e);
		return createErrorResponseEntity(ErrorCode.INTERNAL_SERVER_ERROR);
	}

	private ResponseEntity<ErrorResponse> createErrorResponseEntity(ErrorCode errorCode){
		return new ResponseEntity<>(
			ErrorResponse.of(errorCode),
			errorCode.getStatus()
		);
	}
}
