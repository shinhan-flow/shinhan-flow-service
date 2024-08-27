package com.ssafy.shinhanflow.domain.trigger.account;

import java.util.ArrayList;
import java.util.List;

import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.service.finance.FinanceTriggerService;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record DepositTrigger(
	@NotBlank
	String account,
	@NotNull
	@Positive
	Long amount

) implements Trigger {
	@Override
	public boolean isTriggered(FinanceTriggerService financeTriggerService) {
		//todo: 최근 입금내역 가져오기 몇건중에
		List<Long> amounts = new ArrayList<>();
		for (Long amount : amounts) {
			if (Long.compare(amount, this.amount) >= 0) {
				return true;
			}
		}
		return false;
	}
}
