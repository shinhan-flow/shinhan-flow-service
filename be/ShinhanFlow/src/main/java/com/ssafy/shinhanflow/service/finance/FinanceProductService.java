package com.ssafy.shinhanflow.service.finance;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductResponseDto;
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

	public DepositAndSavingProductResponseDto depositProductInfo() {
		log.info("depositProductInfo");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireDepositProducts", null,
			"00100");
		DepositAndSavingProductRequestDto dto = DepositAndSavingProductRequestDto.builder()
			.header(header)
			.build();
		return financeApiFetcher.depositProductInfo(dto);
	}
}
