package com.ssafy.shinhanflow.service.finance;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRateRequestDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRateResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.service.TriggerService;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;
import com.ssafy.shinhanflow.util.FinanceApiService;
import com.ssafy.shinhanflow.util.constants.Currency;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class ExchangeRateTriggerService extends TriggerService {
	private final FinanceApiService financeApiService;
	private final FinanceApiHeaderGenerator financeApiHeaderGenerator;

	public ExchangeRateResponseDto getExchangeRate(String currencyCode) {
		log.info("getExchangeRate - currencyCode: {}", currencyCode);
		if (currencyCode == null) {
			throw new BadRequestException(ErrorCode.NULL_REQUIRED_VALUE);
		}

		// userKey 필요 없음
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("exchangeRate", null, "00100");
		ExchangeRateRequestDto dto = ExchangeRateRequestDto.builder()
			.header(header)
			.currency(Currency.valueOf(currencyCode))
			.build();

		return financeApiService.getExchangeRate(dto);
	}
}
