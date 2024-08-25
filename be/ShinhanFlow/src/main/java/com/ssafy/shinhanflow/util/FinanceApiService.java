package com.ssafy.shinhanflow.util;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.dto.finance.MemberRequestDto;
import com.ssafy.shinhanflow.dto.finance.MemberResponseDto;
import com.ssafy.shinhanflow.dto.finance.deposit.DemandDepositBalanceRequestDto;
import com.ssafy.shinhanflow.dto.finance.deposit.DemandDepositBalanceResponseDto;
import com.ssafy.shinhanflow.dto.finance.deposit.DemandDepositHolderRequestDto;
import com.ssafy.shinhanflow.dto.finance.deposit.DemandDepositHolderResponseDto;
import com.ssafy.shinhanflow.dto.finance.deposit.DemandDepositRequestDto;
import com.ssafy.shinhanflow.dto.finance.deposit.DemandDepositResponseDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class FinanceApiService {
	private final FinanceApiFetcher financeApiFetcher;

	public MemberResponseDto createMember(MemberRequestDto memberRequestDto) {
		return financeApiFetcher.fetch("/member", memberRequestDto, MemberResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 등록
	 */
	public DemandDepositResponseDto createDemandDepositAccount(
		DemandDepositRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/createDemandDepositAccount", dto,
			DemandDepositResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 예금주 확인
	 */
	public DemandDepositHolderResponseDto inquireDemandDepositAccountHolderName(
		DemandDepositHolderRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/inquireDemandDepositAccountHolderName", dto,
			DemandDepositHolderResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 잔액 조회
	 */
	public DemandDepositBalanceResponseDto inquireDemandDepositAccountBalance(DemandDepositBalanceRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/inquireDemandDepositAccountBalance", dto,
			DemandDepositBalanceResponseDto.class);
	}

}
