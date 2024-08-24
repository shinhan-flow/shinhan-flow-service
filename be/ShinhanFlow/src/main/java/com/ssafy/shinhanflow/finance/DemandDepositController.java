package com.ssafy.shinhanflow.finance;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.auth.jwt.JWTUtil;
import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositBalanceResponseDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositHolderResponseDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositRequestDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositResponseDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/v1/finances")
@RequiredArgsConstructor
public class FinanceController {

	private final FinanceService financeService;
	private final JWTUtil jwtUtil;

	/**
	 * 수시 입출금 계좌 생성
	 */
	@PostMapping("/demand-deposit-account")
	public SuccessResponse<DemandDepositResponseDto> createDemandDepositAccount(
		@RequestHeader("Authorization") String token,
		@RequestBody DemandDepositRequestDto dto) {
		return SuccessResponse.of(
			financeService.createDemandDepositAccount(jwtUtil.getId(token),
				dto.getAccountTypeUniqueNo()));
	}

	/**
	 * 수시 입출금 계좌의 예금주 조회
	 */
	@GetMapping("/demand-deposit-account/{accountNo}/account-holder")
	public SuccessResponse<DemandDepositHolderResponseDto> inquireDemandDepositAccountHolderName(
		@RequestHeader("Authorization") String token,
		@PathVariable String accountNo) {
		return SuccessResponse.of(
			financeService.inquireDemandDepositAccountHolderName(jwtUtil.getId(token), accountNo));
	}

	/**
	 *  수시 입출금 게좌의 잔액 조회
	 */
	@GetMapping("/demand-deposit-account/{accountNo}/balance")
	public SuccessResponse<DemandDepositBalanceResponseDto> inquireDemandDepositAccountBalance(
		@RequestHeader("Authorization") String token,
		@PathVariable String accountNo) {
		return SuccessResponse.of(
			financeService.inquireDemandDepositAccountBalance(jwtUtil.getId(token), accountNo));
	}

}
