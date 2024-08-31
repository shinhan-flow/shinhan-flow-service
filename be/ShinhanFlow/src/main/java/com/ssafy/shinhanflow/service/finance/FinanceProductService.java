package com.ssafy.shinhanflow.service.finance;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountProductRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountProductResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductCreateRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductCreateResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductsRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.DepositAndSavingProductsResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductCreateRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductCreateResponseDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductsRequestDto;
import com.ssafy.shinhanflow.dto.finance.product.LoanProductsResponseDto;
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

	public DepositAndSavingProductsResponseDto depositProductsInfo() {
		log.info("depositProductInfo - 조회 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireDepositProducts", null,
			"00100");
		DepositAndSavingProductsRequestDto dto = DepositAndSavingProductsRequestDto.builder()
			.header(header)
			.build();
		return financeApiFetcher.depositProductsInfo(dto);
	}

	public DepositAndSavingProductsResponseDto savingProductsInfo() {
		log.info("savingsProductsInfo - 조회 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireSavingsProducts", null,
			"00100");
		DepositAndSavingProductsRequestDto dto = DepositAndSavingProductsRequestDto.builder()
			.header(header)
			.build();
		return financeApiFetcher.savingProductsInfo(dto);
	}

	public LoanProductsResponseDto loanProductsInfo() {
		log.info("loanProductsInfo - 조회 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireLoanProductList", null,
			"00100");
		LoanProductsRequestDto dto = LoanProductsRequestDto.builder()
			.header(header)
			.build();
		return financeApiFetcher.loanProductsInfo(dto);
	}

	public CurrentAccountProductResponseDto currentAccountProducts() {
		log.info("currentAccountProducts - 조회 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireDemandDepositList", null,
			"00100");
		CurrentAccountProductRequestDto dto = CurrentAccountProductRequestDto.builder()
			.header(header)
			.build();

		return financeApiFetcher.currentAccountProducts(dto);
	}

	public DepositAndSavingProductCreateResponseDto depositProductRegister(
		DepositAndSavingProductCreateRequestDto dto) {
		log.info("depositProductRegister - 등록 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("createDeposit", null,
			"00100");
		DepositAndSavingProductCreateRequestDto requestDto = DepositAndSavingProductCreateRequestDto.builder()
			.header(header)
			.bankCode(dto.getBankCode())
			.accountName(dto.getAccountName())
			.accountDescription(dto.getAccountDescription())
			.subscriptionPeriod(dto.getSubscriptionPeriod())
			.minSubscriptionBalance(dto.getMinSubscriptionBalance())
			.maxSubscriptionBalance(dto.getMaxSubscriptionBalance())
			.interestRate(dto.getInterestRate())
			.rateDescription(dto.getRateDescription())
			.build();
		return financeApiFetcher.depositProductRegister(requestDto);
	}

	public DepositAndSavingProductCreateResponseDto savingProductRegister(DepositAndSavingProductCreateRequestDto dto) {
		log.info("loansProductRegister - 등록 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("createProduct", null,
			"00100");
		DepositAndSavingProductCreateRequestDto requestDto = DepositAndSavingProductCreateRequestDto.builder()
			.header(header)
			.bankCode(dto.getBankCode())
			.accountName(dto.getAccountName())
			.accountDescription(dto.getAccountDescription())
			.subscriptionPeriod(dto.getSubscriptionPeriod())
			.minSubscriptionBalance(dto.getMinSubscriptionBalance())
			.maxSubscriptionBalance(dto.getMaxSubscriptionBalance())
			.interestRate(dto.getInterestRate())
			.rateDescription(dto.getRateDescription())
			.build();
		return financeApiFetcher.savingProductRegister(requestDto);
	}

	public LoanProductCreateResponseDto loansProductRegister(LoanProductCreateRequestDto dto) {
		log.info("loansProductRegister - 등록 요청");
		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("createLoanProduct", null,
			"00100");
		LoanProductCreateRequestDto requestDto = LoanProductCreateRequestDto.builder()
			.header(header)
			.bankCode(dto.getBankCode())
			.accountName(dto.getAccountName())
			.accountDescription(dto.getAccountDescription())
			.ratingUniqueNo(dto.getRatingUniqueNo())
			.loanPeriod(dto.getLoanPeriod())
			.minLoanBalance(dto.getMinLoanBalance())
			.maxLoanBalance(dto.getMaxLoanBalance())
			.interestRate(dto.getInterestRate())
			.build();

		return financeApiFetcher.loansProductRegister(requestDto);
	}
}
