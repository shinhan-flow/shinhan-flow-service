package com.ssafy.shinhanflow.service.finance;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingsProductsRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingsProductsResponseDto;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;
import com.ssafy.shinhanflow.util.FinanceApiService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class FinanceProductService {
	private final FinanceApiService financeApiFetcher;
	private final FinanceApiHeaderGenerator financeApiHeaderGenerator;

	public DepositAndSavingsProductsResponseDto depositProductsInfo() {
		log.info("depositProductInfo - 조회 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireDepositProducts", null,
			"00100");
		DepositAndSavingsProductsRequestDto dto = DepositAndSavingsProductsRequestDto.builder()
			.header(header)
			.build();
		return financeApiFetcher.depositProductsInfo(dto);
	}

	public DepositAndSavingsProductsResponseDto savingsProductsInfo() {
		log.info("savingsProductsInfo - 조회 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireSavingsProducts", null,
			"00100");
		DepositAndSavingsProductsRequestDto dto = DepositAndSavingsProductsRequestDto.builder()
			.header(header)
			.build();
		return financeApiFetcher.savingsProductsInfo(dto);
	}
}
