package com.ssafy.shinhanflow.controller.finance;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingsProductsResponseDto;
import com.ssafy.shinhanflow.service.finance.FinanceProductService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/v1/finances/products")
@RequiredArgsConstructor
public class FinanceProductController {
	private final FinanceProductService financeProductService;

	/**
	 * 예금 상품 조회
	 */
	@GetMapping("/deposits")
	public SuccessResponse<DepositAndSavingsProductsResponseDto> depositProductInfo() {
		return SuccessResponse.of(financeProductService.depositProductsInfo());
	}

	/**
	 * 적금 상품 조회
	 */
	@GetMapping("/savings")
	public SuccessResponse<DepositAndSavingsProductsResponseDto> savingsProductsInfo() {
		return SuccessResponse.of(financeProductService.savingsProductsInfo());
	}
}
