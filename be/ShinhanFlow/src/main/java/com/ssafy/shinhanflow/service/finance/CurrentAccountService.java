package com.ssafy.shinhanflow.service.finance;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.domain.entity.MemberEntity;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountBalanceRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountBalanceResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountDepositRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountDepositResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountHolderRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountHolderResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransferRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransferResponseDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountWithdrawRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountWithdrawResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.repository.MemberRepository;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;
import com.ssafy.shinhanflow.util.FinanceApiService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class CurrentAccountService {

	private final FinanceApiService financeApiFetcher;
	private final MemberRepository memberRepository;
	private final FinanceApiHeaderGenerator financeApiHeaderGenerator;

	public CurrentAccountResponseDto createCurrentAccount(long userId, String accountTypeUniqueNo) {

		log.info("createDemandDepositAccount - userId: {}, accountTypeUniqueNo: {}", userId, accountTypeUniqueNo);
		if (accountTypeUniqueNo == null) {
			throw new BadRequestException(ErrorCode.NULL_REQUIRED_VALUE);
		}

		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();

		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("createDemandDepositAccount", userKey,
			institutionCode);
		CurrentAccountRequestDto dto = CurrentAccountRequestDto.builder()
			.header(header)
			.accountTypeUniqueNo(accountTypeUniqueNo)
			.build();

		return financeApiFetcher.createCurrentAccount(dto);
	}

	public CurrentAccountHolderResponseDto currentAccountHolderName(long userId, String accountNo) {

		log.info("currentAccountHolderName - userId: {}, accountNo: {}", userId, accountNo);
		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();

		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("inquireDemandDepositAccountHolderName",
			userKey,
			institutionCode);
		CurrentAccountHolderRequestDto dto = CurrentAccountHolderRequestDto.builder()
			.header(header)
			.accountNo(accountNo)
			.build();

		return financeApiFetcher.currentAccountHolderName(dto);
	}

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

	public CurrentAccountTransferResponseDto transferCurrentAccount(long userId, CurrentAccountTransferRequestDto dto) {
		log.info("transferCurrentAccount - userId: {}", userId);
		log.info("입금 계좌번호: {}, 출금 계좌번호: {}, 금액: {}", dto.getDepositAccountNo(), dto.getWithdrawalAccountNo(),
			dto.getTransactionBalance());

		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();

		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("updateDemandDepositAccountTransfer", userKey,
			institutionCode);
		CurrentAccountTransferRequestDto requestDto = CurrentAccountTransferRequestDto.builder()
			.header(header)
			.depositAccountNo(dto.getDepositAccountNo())
			.withdrawalAccountNo(dto.getWithdrawalAccountNo())
			.transactionBalance(dto.getTransactionBalance())
			.build();

		return financeApiFetcher.transferCurrentAccount(requestDto);
	}

	public CurrentAccountWithdrawResponseDto withdrawCurrentAccount(long userId, CurrentAccountWithdrawRequestDto dto) {

		log.info("withdrawCurrentAccount - userId: {}", userId);
		log.info("출금 계좌번호: {}, 금액: {}", dto.getAccountNo(), dto.getTransactionBalance());

		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();

		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("updateDemandDepositAccountWithdrawal",
			userKey,
			institutionCode);

		CurrentAccountWithdrawRequestDto requestDto = CurrentAccountWithdrawRequestDto.builder()
			.header(header)
			.accountNo(dto.getAccountNo())
			.transactionBalance(dto.getTransactionBalance())
			.transactionSummary(dto.getTransactionSummary())
			.build();

		return financeApiFetcher.withdrawCurrentAccount(requestDto);
	}

	public CurrentAccountDepositResponseDto depositCurrentAccount(long userId, CurrentAccountDepositRequestDto dto) {
		log.info("depositCurrentAccount - userId: {}", userId);
		log.info("입금 계좌번호: {}, 금액: {}", dto.getAccountNo(), dto.getTransactionBalance());

		MemberEntity memberEntity = findMemberOrThrow(userId);

		String userKey = memberEntity.getUserKey();
		String institutionCode = memberEntity.getInstitutionCode();

		RequestHeaderDto header = financeApiHeaderGenerator.createHeader("updateDemandDepositAccountDeposit",
			userKey,
			institutionCode);

		CurrentAccountDepositRequestDto requestDto = CurrentAccountDepositRequestDto.builder()
			.header(header)
			.accountNo(dto.getAccountNo())
			.transactionBalance(dto.getTransactionBalance())
			.transactionSummary(dto.getTransactionSummary())
			.build();
		
		return financeApiFetcher.depositCurrentAccount(requestDto);
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
