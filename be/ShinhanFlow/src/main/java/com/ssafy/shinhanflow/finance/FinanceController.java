package com.ssafy.shinhanflow.finance;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.auth.jwt.JWTUtil;
import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositAccountRequestDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositAccountResponseDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/v1/finances")
@RequiredArgsConstructor
public class FinanceController {

	private final FinanceService financeService;
	private final JWTUtil jwtUtil;

	@PostMapping
	public SuccessResponse<DemandDepositAccountResponseDto> createDemandDepositAccount(
		@RequestHeader("Authorization") String token,
		@RequestBody DemandDepositAccountRequestDto dto) {
		return SuccessResponse.of(
			financeService.createDemandDepositAccount(jwtUtil.getUserId(token.substring(7)),
				dto.getAccountTypeUniqueNo()));
	}
}
