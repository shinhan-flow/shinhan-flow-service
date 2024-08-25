package com.ssafy.shinhanflow.controller.finance;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.auth.jwt.JWTUtil;
import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountBalanceResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountDepositRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountDepositResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountHolderResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransferRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransferResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountWithdrawRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountWithdrawResponseDto;
import com.ssafy.shinhanflow.service.finance.CurrentAccountService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/v1/finances/current-accounts")
@RequiredArgsConstructor
public class CurrentAccountController {

	private final CurrentAccountService currentAccountService;
	private final JWTUtil jwtUtil;

	/**
	 * 수시 입출금 계좌 생성
	 */
	@PostMapping()
	public SuccessResponse<CurrentAccountResponseDto> createCurrentAccount(
		@RequestHeader("Authorization") String token,
		@RequestBody CurrentAccountRequestDto dto) {
		return SuccessResponse.of(
			currentAccountService.createCurrentAccount(jwtUtil.getId(token),
				dto.getAccountTypeUniqueNo()));
	}

	/**
	 * 수시 입출금 계좌의 예금주 조회
	 */
	@GetMapping("/{accountNo}/account-holder")
	public SuccessResponse<CurrentAccountHolderResponseDto> currentAccountHolderName(
		@RequestHeader("Authorization") String token,
		@PathVariable String accountNo) {
		return SuccessResponse.of(
			currentAccountService.currentAccountHolderName(jwtUtil.getId(token), accountNo));
	}

	/**
	 *  수시 입출금 게좌의 잔액 조회
	 */
	@GetMapping("/{accountNo}/balance")
	public SuccessResponse<CurrentAccountBalanceResponseDto> currentAccountBalance(
		@RequestHeader("Authorization") String token,
		@PathVariable String accountNo) {
		return SuccessResponse.of(
			currentAccountService.currentAccountBalance(jwtUtil.getId(token), accountNo));
	}

	/**
	 * 수시 입출금 계좌 이체
	 */
	@PostMapping("/transfer")
	public SuccessResponse<CurrentAccountTransferResponseDto> transferCurrentAccount(
		@RequestHeader("Authorization") String token,
		@RequestBody CurrentAccountTransferRequestDto dto) {
		return SuccessResponse.of(currentAccountService.transferCurrentAccount(jwtUtil.getId(token), dto));
	}

	/**
	 * 수시 입출금 계좌 출금
	 */
	@PostMapping("/withdraw")
	public SuccessResponse<CurrentAccountWithdrawResponseDto> withdrawCurrentAccount(
		@RequestHeader("Authorization") String token,
		@RequestBody CurrentAccountWithdrawRequestDto dto) {
		return SuccessResponse.of(currentAccountService.withdrawCurrentAccount(jwtUtil.getId(token), dto));
	}

	/**
	 * 수시 입출금 계좌 입금
	 */
	@PostMapping("/deposit")
	public SuccessResponse<CurrentAccountDepositResponseDto> depositCurrentAccount(
		@RequestHeader("Authorization") String token,
		@RequestBody CurrentAccountDepositRequestDto dto) {
		return SuccessResponse.of(currentAccountService.depositCurrentAccount(jwtUtil.getId(token), dto));
	}
}
