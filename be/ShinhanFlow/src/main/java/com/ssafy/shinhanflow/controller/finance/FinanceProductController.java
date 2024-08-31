package com.ssafy.shinhanflow.controller.finance;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountProductResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductCreateRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductCreateResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductsResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductCreateRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductCreateResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductsResponseDto;
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
	public SuccessResponse<DepositAndSavingProductsResponseDto> depositProductInfo() {
		return SuccessResponse.of(financeProductService.depositProductsInfo());
	}

	/**
	 * 적금 상품 조회
	 */
	@GetMapping("/savings")
	public SuccessResponse<DepositAndSavingProductsResponseDto> savingProductsInfo() {
		return SuccessResponse.of(financeProductService.savingProductsInfo());
	}

	/**
	 * 대출 상품 조회
	 */
	@GetMapping("/loans")
	public SuccessResponse<LoanProductsResponseDto> loanProductsInfo() {
		return SuccessResponse.of(financeProductService.loanProductsInfo());
	}

	/**
	 * 수시 입출금 계좌 상품 조회
	 */
	@GetMapping("/current-accounts")
	public SuccessResponse<CurrentAccountProductResponseDto> currentAccountProducts() {
		return SuccessResponse.of(financeProductService.currentAccountProducts());
	}

	/**
	 * 예금 상품 등록
	 */
	@PostMapping("/deposits")
	public SuccessResponse<DepositAndSavingProductCreateResponseDto> depositProductRegister(
		@RequestBody DepositAndSavingProductCreateRequestDto dto
	) {
		return SuccessResponse.of(financeProductService.depositProductRegister(dto));
	}

	/**
	 * 적금 상품 등록
	 */
	@PostMapping("/savings")
	public SuccessResponse<DepositAndSavingProductCreateResponseDto> savingProductRegister(
		@RequestBody DepositAndSavingProductCreateRequestDto dto
	) {
		return SuccessResponse.of(financeProductService.savingProductRegister(dto));
	}

	/**
	 * 대출 상품 등록
	 */
	@PostMapping("/loans")
	public SuccessResponse<LoanProductCreateResponseDto> loansProductRegister(
		@RequestBody LoanProductCreateRequestDto dto
	) {
		return SuccessResponse.of(financeProductService.loansProductRegister(dto));
	}
}
