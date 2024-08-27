package com.ssafy.shinhanflow.config.error.exception;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.http.converter.HttpMessageNotReadableException;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.servlet.resource.NoResourceFoundException;

import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.ErrorResponse;

import lombok.extern.slf4j.Slf4j;


/**
 * @ControllerAdvice를 통해 모든 컨트롤러에서 발생하는 모든 예외를 처리할 수 있음.
 * 컨트롤러에서 호출하는 서비스로직도 포함.
 */
@Slf4j
@ControllerAdvice
public class GlobalExceptionHandler {

	/**
	 * 라우팅 되지않은 자원에 접근하거나, 잘못된 method를 호출하는 예외
	 */
	@ExceptionHandler(HttpRequestMethodNotSupportedException.class)
	protected ResponseEntity<ErrorResponse> handle(HttpRequestMethodNotSupportedException e) {
		log.error("HttpRequestMethodNotSupportedException", e);
		return createErrorResponseEntity(ErrorCode.METHOD_NOT_ALLOWED);
	}

	@ExceptionHandler(NoResourceFoundException.class)
	protected ResponseEntity<ErrorResponse> handle(NoResourceFoundException e){
		log.error("NoResourceFoundException", e);
		return createErrorResponseEntity(ErrorCode.RESOURCE_NOT_FOUND);
	}

	/**
	 * 유효성을 검증하는 @Valid에서 발생시키는 예외
	 */
	@ExceptionHandler(HttpMessageNotReadableException.class)
	protected ResponseEntity<ErrorResponse> handle(HttpMessageNotReadableException e) {
		log.error("HttpMessageNotReadableException", e);
		return createErrorResponseEntity(ErrorCode.INVALID_INPUT_VALUE);
	}

	@ExceptionHandler(MethodArgumentNotValidException.class)
	protected ResponseEntity<ErrorResponse> handle(MethodArgumentNotValidException e) {
		log.error("HttpMessageNotReadableException", e);
		return createErrorResponseEntity(ErrorCode.INVALID_INPUT_VALUE);
	}

	/**
	 * 서비스 로직에서 직접 throw하는 커스텀 예외
	 */
	@ExceptionHandler(BusinessBaseException.class)
	protected ResponseEntity<ErrorResponse> handle(BusinessBaseException e) {
		log.error("BusinessException", e);
		return createErrorResponseEntity(e.getErrorCode());
	}

	/**
	 *	금융 API 에서 응답받은 예외
	 */
	@ExceptionHandler(FinanceApiException.class)
	protected ResponseEntity<ErrorResponse> handle(FinanceApiException e) {
		log.error("FinanceApiException", e);
		return new ResponseEntity<>(
			ErrorResponse.of(
				e.getErrorCode(),
				e.getMessage()),
			e.getHttpStatusCode()
		);
	}

	/**
	 * 기타 정의되지 않은 예외는 서버 에러로 처리
	 */
	@ExceptionHandler(Exception.class)
	protected ResponseEntity<ErrorResponse> handle(Exception e) {
		log.error("Exception", e);
		return createErrorResponseEntity(ErrorCode.INTERNAL_SERVER_ERROR);
	}

	// 공용 메서드
	private ResponseEntity<ErrorResponse> createErrorResponseEntity(ErrorCode errorCode) {
		return new ResponseEntity<>(
			ErrorResponse.of(errorCode),
			errorCode.getStatus()
		);
	}
}
