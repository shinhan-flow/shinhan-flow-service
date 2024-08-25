package com.ssafy.shinhanflow.config.error;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;

import lombok.Getter;
import lombok.RequiredArgsConstructor;

@Getter
@RequiredArgsConstructor
public class SuccessResponse<T> {

	private HttpStatus code;
	private String message;
	private T data;

	private SuccessResponse(HttpStatus code, String message, T data){
		this.code = code;
		this.message = message;
		this.data = data;
	}

	public static <T> SuccessResponse<T> of(T data){
		return new SuccessResponse<>(HttpStatus.OK, "ok", data);
	}
}
