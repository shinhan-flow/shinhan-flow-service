package com.ssafy.shinhanflow.util;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.config.error.exception.FinanceApiException;
import com.ssafy.shinhanflow.dto.finance.MemberRequestDto;
import com.ssafy.shinhanflow.dto.finance.MemberResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountBalanceRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountBalanceResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountDeleteRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountDeleteResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountDepositRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountDepositResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountHolderRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountHolderResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountInfoListResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountInfoRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountInfoResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountProductRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountProductResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransactionHistoryRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransactionHistoryResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransferRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransferResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountWithdrawRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountWithdrawResponseDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRateRequestDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRateResponseDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRatesRequestDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRatesResponseDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeRequestDto;
import com.ssafy.shinhanflow.dto.finance.exchange.ExchangeResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductCreateRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductCreateResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductsRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductsResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductCreateRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductCreateResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductsRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductsResponseDto;
import com.ssafy.shinhanflow.dto.member.CreditScoreRequestDto;
import com.ssafy.shinhanflow.dto.member.CreditScoreResponseDto;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class FinanceApiService {
	private final FinanceApiFetcher financeApiFetcher;

	public MemberResponseDto createMember(MemberRequestDto memberRequestDto) {
		try {
			return financeApiFetcher.fetch("/member", memberRequestDto, MemberResponseDto.class);

		} catch (FinanceApiException e) {
			if (e.getErrorCode().equals("E4002")) {
				return financeApiFetcher.fetch("/member/search", memberRequestDto, MemberResponseDto.class);
			} else
				throw e;
		}
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

	/**
	 * 수시 입출금 계좌 출금
	 */
	public CurrentAccountWithdrawResponseDto withdrawCurrentAccount(CurrentAccountWithdrawRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/updateDemandDepositAccountWithdrawal", dto,
			CurrentAccountWithdrawResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 입금
	 */
	public CurrentAccountDepositResponseDto depositCurrentAccount(CurrentAccountDepositRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/updateDemandDepositAccountDeposit", dto,
			CurrentAccountDepositResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 정보 조회 (단건)
	 */
	public CurrentAccountInfoResponseDto currentAccountInfo(CurrentAccountInfoRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/inquireDemandDepositAccount", dto,
			CurrentAccountInfoResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 정보 조회 (전체)
	 */
	public CurrentAccountInfoListResponseDto currentAccountListInfo(CurrentAccountInfoRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/inquireDemandDepositAccountList", dto,
			CurrentAccountInfoListResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 거래내역 조회
	 */
	public CurrentAccountTransactionHistoryResponseDto currentAccountTransactionHistory(
		CurrentAccountTransactionHistoryRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/inquireTransactionHistoryList", dto,
			CurrentAccountTransactionHistoryResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 상품 조회
	 */
	public CurrentAccountProductResponseDto currentAccountProducts(CurrentAccountProductRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/inquireDemandDepositList", dto,
			CurrentAccountProductResponseDto.class);
	}

	/**
	 * 예금 상품 조회
	 */
	public DepositAndSavingProductsResponseDto depositProductsInfo(DepositAndSavingProductsRequestDto dto) {
		return financeApiFetcher.fetch("/edu/deposit/inquireDepositProducts", dto,
			DepositAndSavingProductsResponseDto.class);
	}

	/**
	 * 적금 상품 조회
	 */
	public DepositAndSavingProductsResponseDto savingProductsInfo(DepositAndSavingProductsRequestDto dto) {
		return financeApiFetcher.fetch("/edu/savings/inquireSavingsProducts", dto,
			DepositAndSavingProductsResponseDto.class);
	}

	/**
	 * 대출 상품 조회
	 */
	public LoanProductsResponseDto loanProductsInfo(LoanProductsRequestDto dto) {
		return financeApiFetcher.fetch("/edu/loan/inquireLoanProductList", dto, LoanProductsResponseDto.class);
	}

	/**
	 * 전체 환율 조회
	 */
	public ExchangeRatesResponseDto getExchangeRates(ExchangeRatesRequestDto dto) {
		return financeApiFetcher.fetch("/edu/exchangeRate", dto, ExchangeRatesResponseDto.class);
	}

	/**
	 * 특정 환율 조회
	 */
	public ExchangeRateResponseDto getExchangeRate(ExchangeRateRequestDto dto) {
		return financeApiFetcher.fetch("/edu/exchangeRate/search", dto, ExchangeRateResponseDto.class);
	}

	/**
	 * 환전 신청
	 */
	public ExchangeResponseDto exchange(ExchangeRequestDto dto) {
		return financeApiFetcher.fetch("/edu/exchange", dto, ExchangeResponseDto.class);
	}

	public CurrentAccountDeleteResponseDto deleteCurrentAccount(CurrentAccountDeleteRequestDto dto) {
		return financeApiFetcher.fetch("/edu/demandDeposit/deleteDemandDepositAccount", dto,
			CurrentAccountDeleteResponseDto.class);
	}

	public CreditScoreResponseDto getCreditScore(CreditScoreRequestDto dto) {
		return financeApiFetcher.fetch("/edu/loan/inquireMyCreditRating", dto, CreditScoreResponseDto.class);
	}

	public DepositAndSavingProductCreateResponseDto depositProductRegister(
		DepositAndSavingProductCreateRequestDto dto) {
		return financeApiFetcher.fetch("/edu/deposit/createDeposit", dto,
			DepositAndSavingProductCreateResponseDto.class);
	}

	public DepositAndSavingProductCreateResponseDto savingProductRegister(DepositAndSavingProductCreateRequestDto dto) {
		return financeApiFetcher.fetch("/edu/savings/createProduct", dto,
			DepositAndSavingProductCreateResponseDto.class);
	}

	public LoanProductCreateResponseDto loansProductRegister(LoanProductCreateRequestDto dto) {
		return financeApiFetcher.fetch("/edu/loan/createLoanProduct", dto, LoanProductCreateResponseDto.class);
	}
}
