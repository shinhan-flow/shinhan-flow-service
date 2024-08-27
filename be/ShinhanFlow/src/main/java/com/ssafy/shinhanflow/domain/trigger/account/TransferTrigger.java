package com.ssafy.shinhanflow.domain.trigger.account;

import java.util.ArrayList;
import java.util.List;

import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.service.finance.FinanceTriggerService;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record TransferTrigger(
	@NotBlank
	String fromAccount,
	@NotBlank
	String toAccount,
	@NotNull
	@Positive
	Long amount

) implements Trigger {

	@Override
	public boolean isTriggered(FinanceTriggerService financeTriggerService) {
		//todo: 송금하면 이니까 fromAccount에서 최근 거래내역 가져오기
		List<Long> amounts = new ArrayList<>();
		for (Long amount : amounts) {
			if (amount.compareTo(this.amount) >= 0) {
				return true;
			}
		}
		return false;
	}
}
