package com.ssafy.shinhanflow.service.finance;

import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.domain.entity.MemberEntity;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountBalanceRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountBalanceResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountHolderRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountHolderResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransactionHistoryRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransactionHistoryResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductsRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductsResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductsRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductsResponseDto;
import com.ssafy.shinhanflow.repository.MemberRepository;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;
import com.ssafy.shinhanflow.util.FinanceApiService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class FinanceTriggerService {
	private final FinanceApiService financeApiFetcher;
	private final FinanceApiHeaderGenerator financeApiHeaderGenerator;
	private final MemberRepository memberRepository;

	/**
	 * 예금 상품 정보 조회
	 */
	public DepositAndSavingProductsResponseDto depositProductsInfo() {
		log.info("depositProductInfo - 조회 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireDepositProducts", null,
			"00100");
		DepositAndSavingProductsRequestDto dto = DepositAndSavingProductsRequestDto.builder()
			.header(header)
			.build();
		return financeApiFetcher.depositProductsInfo(dto);
	}

	/**
	 * 적금 상품 정보 조회
	 */
	public DepositAndSavingProductsResponseDto savingProductsInfo() {
		log.info("savingsProductsInfo - 조회 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireSavingsProducts", null,
			"00100");
		DepositAndSavingProductsRequestDto dto = DepositAndSavingProductsRequestDto.builder()
			.header(header)
			.build();
		return financeApiFetcher.savingProductsInfo(dto);
	}

	/**
	 * 대출 상품 정보 조회
	 */
	public LoanProductsResponseDto loanProductsInfo() {
		log.info("loanProductsInfo - 조회 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireLoanProductList", null,
			"00100");
		LoanProductsRequestDto dto = LoanProductsRequestDto.builder()
			.header(header)
			.build();
		return financeApiFetcher.loanProductsInfo(dto);
	}

	/**
	 * 수시입출금 계좌 잔액 조회
	 */
	public CurrentAccountBalanceResponseDto currentAccountBalance(long userId, String accountNo) {

		log.info("currentAccountBalance - userId: {}, accountNo: {}", userId, accountNo);
		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();

		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireDemandDepositAccountBalance", userKey,
			institutionCode);
		CurrentAccountBalanceRequestDto dto = CurrentAccountBalanceRequestDto.builder()
			.header(header)
			.accountNo(accountNo)
			.build();

		return financeApiFetcher.currentAccountBalance(dto);
	}

	/**
	 * 수시입출금 계좌 거래내역 조회
	 */
	public CurrentAccountTransactionHistoryResponseDto currentAccountTransactionHistory(long userId, String accountNo,
		String startDate, String endDate, String transactionType,
		String orderByType) {
		log.info("currentAccountTransactionHistory - userId: {}, accountNo: {}, startDate: {}, endDate: {}", userId,
			accountNo, startDate, endDate);
		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();

		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireTransactionHistoryList", userKey,
			institutionCode);
		CurrentAccountTransactionHistoryRequestDto dto = CurrentAccountTransactionHistoryRequestDto.builder()
			.header(header)
			.accountNo(accountNo)
			.startDate(startDate)
			.endDate(endDate)
			.transactionType(transactionType)
			.orderByType(orderByType)
			.build();

		return financeApiFetcher.currentAccountTransactionHistory(dto);
	}

	/**
	 * 계좌 -> 예금주 확인 -> userId
	 */
	public Long findIdByAccountNo(String accountNo) {
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireTransactionHistoryList", null,
			"00100");
		CurrentAccountHolderRequestDto dto = CurrentAccountHolderRequestDto.builder()
			.header(header)
			.accountNo(accountNo)
			.build();

		CurrentAccountHolderResponseDto holderInfo = financeApiFetcher.currentAccountHolderName(dto);
		String userName = holderInfo.getRec().userName();
		List<MemberEntity> byEmailContaining = memberRepository.findByEmailContaining(userName);
		return byEmailContaining.get(0).getId();
	}

	private MemberEntity findMemberOrThrow(long userId) {
		Optional<MemberEntity> memberEntityOptional = memberRepository.findById(userId);
		if (memberEntityOptional.isEmpty()) {
			throw new BadRequestException(ErrorCode.NOT_FOUND);
		} else {
			return memberEntityOptional.get();
		}
	}
}
