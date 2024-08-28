package com.ssafy.shinhanflow.controller.finance;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.auth.jwt.JWTUtil;
import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRequestDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeResponseDto;
import com.ssafy.shinhanflow.service.finance.ExchangeService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/v1/finances/exchange")
@RequiredArgsConstructor
public class ExchangeController {
	private final ExchangeService exchangeService;
	private final JWTUtil jwtUtil;

	/**
	 * 환전
	 */
	@PostMapping()
	public SuccessResponse<ExchangeResponseDto> exchange(
		@RequestHeader("Authorization") String token,
		@RequestBody ExchangeRequestDto dto
	) {
		return SuccessResponse.of(
			exchangeService.exchange(
				jwtUtil.getId(token),
				dto.getAccountNo(),
				dto.getExchangeCurrency(),
				dto.getExchangeAmount()
			)
		);
	}
}
