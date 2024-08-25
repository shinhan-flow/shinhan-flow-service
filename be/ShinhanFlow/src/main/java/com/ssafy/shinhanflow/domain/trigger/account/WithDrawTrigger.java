package com.ssafy.shinhanflow.domain.trigger.account;

import java.util.ArrayList;
import java.util.List;

import com.ssafy.shinhanflow.domain.trigger.Trigger;

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
	public boolean isTriggered() {
		//todo: 최근 거래내역 가져오기
		List<Long> amounts = new ArrayList<>();
		for (Long amount : amounts) {
			if (Long.compare(amount, this.amount) >= 0) {
				return true;
			}
		}
		return false;
	}
}
