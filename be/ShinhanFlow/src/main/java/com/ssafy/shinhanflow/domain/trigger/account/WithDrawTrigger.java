package com.ssafy.shinhanflow.domain.trigger.account;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountTransactionHistoryResponseDto;
import com.ssafy.shinhanflow.service.finance.FinanceTriggerService;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record WithDrawTrigger(
	@NotBlank
	String account,
	@NotNull
	@Positive
	Long amount

) implements Trigger {
	@Override
	public boolean isTriggered(FinanceTriggerService financeTriggerService, Long userId) {
		String currDay = LocalDateTime.now().format(DateTimeFormatter.ofPattern("yyyyMMdd"));

		// 당일 출금 내역 최신순으로 조회 ( transactionType: D -> 출금, M -> 입금)
		List<CurrentAccountTransactionHistoryResponseDto.Transaction> list = financeTriggerService.currentAccountTransactionHistory(
			userId, account, currDay, currDay, "D", "DESC").getRec().list();
		for (CurrentAccountTransactionHistoryResponseDto.Transaction transaction : list) {
			if (Long.compare(transaction.transactionBalance(), this.amount) >= 0) {
				return true;
			}
		}
		return false;

		/**
		 * 현재 true, false 를 반환하고 있지만 true 인 경우 어떤 거래였는지 전달해주면 좋을것 같은데....
		 */
	}
}
