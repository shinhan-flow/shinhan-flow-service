package com.ssafy.shinhanflow.service.finance;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRateRequestDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRateResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductsRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductsResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductsRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductsResponseDto;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;
import com.ssafy.shinhanflow.util.FinanceApiService;
import com.ssafy.shinhanflow.util.constants.Currency;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class FinanceTriggerService {
	private final FinanceApiService financeApiService;
	private final FinanceApiHeaderGenerator financeApiHeaderGenerator;

	public DepositAndSavingProductsResponseDto depositProductsInfo() {
		log.info("depositProductInfo - 조회 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireDepositProducts", null,
			"00100");
		DepositAndSavingProductsRequestDto dto = DepositAndSavingProductsRequestDto.builder()
			.header(header)
			.build();
		return financeApiService.depositProductsInfo(dto);
	}

	public DepositAndSavingProductsResponseDto savingProductsInfo() {
		log.info("savingsProductsInfo - 조회 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireSavingsProducts", null,
			"00100");
		DepositAndSavingProductsRequestDto dto = DepositAndSavingProductsRequestDto.builder()
			.header(header)
			.build();
		return financeApiService.savingProductsInfo(dto);
	}

	public LoanProductsResponseDto loanProductsInfo() {
		log.info("loanProductsInfo - 조회 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireLoanProductList", null,
			"00100");
		LoanProductsRequestDto dto = LoanProductsRequestDto.builder()
			.header(header)
			.build();
		return financeApiService.loanProductsInfo(dto);
	}

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
