package com.ssafy.shinhanflow.service.flow;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.domain.entity.MemberEntity;
import com.ssafy.shinhanflow.dto.FcmMessageRequestDto;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountBalanceRequestDto;
import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;
import com.ssafy.shinhanflow.repository.MemberRepository;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;
import com.ssafy.shinhanflow.util.FinanceApiService;
import com.ssafy.shinhanflow.util.FirebaseCloudMessageService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FinanceActionService {
	private final FirebaseCloudMessageService fcmService;
	private final FinanceApiHeaderGenerator headerGenerator;
	private final MemberRepository memberRepository;
	private final FinanceApiService financeApiService;

	public void sendTextNotification(Long memberId, String text) {

		fcmService.sendMessage(FcmMessageRequestDto.builder()
			.memberId(memberId)
			.title("플로우 알림")
			.content(text)
			.build());
	}

	public void sendBalanceNotification(Long memberId, String accountNo) {
		MemberEntity memberEntity = memberRepository.findById(memberId).orElseThrow();
		RequestHeaderDto requestHeaderDto = headerGenerator.createHeader("inquireDemandDepositAccountBalance",
			memberEntity.getUserKey(), "00100");
		CurrentAccountBalanceRequestDto requestDto = CurrentAccountBalanceRequestDto.builder()
			.header(requestHeaderDto)
			.accountNo(accountNo)
			.build();

		Long balance = financeApiService.currentAccountBalance(requestDto).getRec().accountBalance();
		String message = "계좌 잔액이 " + balance + "원 입니다.";
		fcmService.sendMessage(FcmMessageRequestDto.builder()
			.memberId(memberId)
			.title("플로우 알림")
			.content(message)
			.build());
	}

}
