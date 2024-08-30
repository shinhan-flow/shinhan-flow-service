package com.ssafy.shinhanflow.auth.jwt;

import java.io.IOException;

import org.springframework.http.HttpStatus;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.shinhanflow.config.error.ErrorResponse;
import com.ssafy.shinhanflow.config.error.SuccessResponse;

import jakarta.servlet.http.HttpServletResponse;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JWTResponse {
	static <LoginSuccessResponseDto> void respondWithSuccess(HttpServletResponse response,
		SuccessResponse<LoginSuccessResponseDto> successResponse) {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		try {
			String jsonResponse = new ObjectMapper().writeValueAsString(successResponse);
			response.setStatus(successResponse.getCode().value());
			response.getWriter().write(jsonResponse);
		} catch (IOException e) {
			log.error("Error writing JSON response", e);
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
	}

	static void respondWithError(HttpServletResponse response, ErrorResponse errorResponse) {
		response.setContentType("application/json");
		response.setCharacterEncoding("UTF-8");

		try {
			String jsonResponse = new ObjectMapper().writeValueAsString(errorResponse);
			response.setStatus(HttpStatus.BAD_REQUEST.value());
			response.getWriter().write(jsonResponse);
		} catch (IOException e) {
			log.error("Error writing JSON response", e);
			response.setStatus(HttpStatus.INTERNAL_SERVER_ERROR.value());
		}
	}
}
