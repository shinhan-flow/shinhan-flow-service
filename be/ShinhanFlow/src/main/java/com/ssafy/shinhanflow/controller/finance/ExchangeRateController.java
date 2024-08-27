package com.ssafy.shinhanflow.controller.finance;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRateResponseDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRatesResponseDto;
import com.ssafy.shinhanflow.service.finance.ExchangeRateService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/v1/finances/exchange-rates")
@RequiredArgsConstructor
public class ExchangeRateController {
	private final ExchangeRateService exchangeRateService;

	/**
	 * 환율 조회
	 */
	@GetMapping()
	public SuccessResponse<ExchangeRatesResponseDto> exchangeRates() {
		return SuccessResponse.of(exchangeRateService.getExchangeRates());
	}

	/**
	 * 특정 환율 조회
	 */
	@GetMapping("/{currencyCode}")
	public SuccessResponse<ExchangeRateResponseDto> exchangeRate(@PathVariable String currencyCode) {
		return SuccessResponse.of(exchangeRateService.getExchangeRate(currencyCode));
	}
}
