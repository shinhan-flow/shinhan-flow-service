package com.ssafy.shinhanflow.util;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.dto.finance.MemberRequestDto;
import com.ssafy.shinhanflow.dto.finance.MemberResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountBalanceRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountBalanceResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountHolderRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountHolderResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransferRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransferResponseDto;

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
	public CurrentAccountResponseDto createCurrentAccount(
		CurrentAccountRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/createDemandDepositAccount", dto,
			CurrentAccountResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 예금주 확인
	 */
	public CurrentAccountHolderResponseDto currentAccountHolderName(
		CurrentAccountHolderRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/inquireDemandDepositAccountHolderName", dto,
			CurrentAccountHolderResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 잔액 조회
	 */
	public CurrentAccountBalanceResponseDto currentAccountBalance(CurrentAccountBalanceRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/inquireDemandDepositAccountBalance", dto,
			CurrentAccountBalanceResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 이체
	 */
	public CurrentAccountTransferResponseDto transferCurrentAccount(CurrentAccountTransferRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/updateDemandDepositAccountTransfer", dto,
			CurrentAccountTransferResponseDto.class);
	}
}
