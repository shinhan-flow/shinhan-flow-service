package com.ssafy.shinhanflow.domain.trigger.account;

import java.util.ArrayList;
import java.util.List;

import com.ssafy.shinhanflow.domain.trigger.Trigger;

import lombok.NonNull;

public record TransferTrigger(@NonNull String fromAccount, @NonNull String toAccount, @NonNull Long amount) implements
	Trigger {

	@Override
	public boolean isTriggered() {
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
