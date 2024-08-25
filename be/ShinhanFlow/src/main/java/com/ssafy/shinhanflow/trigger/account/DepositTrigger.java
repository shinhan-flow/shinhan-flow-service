package com.ssafy.shinhanflow.trigger.account;

import java.util.ArrayList;
import java.util.List;

import com.ssafy.shinhanflow.trigger.Trigger;

import lombok.NonNull;

public record DepositTrigger(@NonNull String account, @NonNull Long amount) implements Trigger{
	@Override
	public boolean isTriggered() {
		//todo: 최근 입금내역 가져오기 몇건중에
		List<Long> amounts = new ArrayList<>();
		for(Long amount: amounts){
			if(Long.compare(amount, this.amount) >= 0){
				return true;
			}
		}
		return false;
	}
}
