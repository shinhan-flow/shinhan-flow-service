package com.ssafy.shinhanflow.trigger.account;


import com.ssafy.shinhanflow.trigger.Trigger;

import lombok.Getter;
import lombok.NonNull;

public record BalanceTrigger(@NonNull String account, @NonNull Long balance, @NonNull Condition condition) implements Trigger {

	@Override
	public boolean isTriggered() {
		Long accountBalance = 0L; // todo: account에 대한 계좌 잔액 조회

		if(condition.name().equals("LT")){
			return accountBalance.compareTo(balance) <= 0 ;
		}
		else if (condition.name().equals("GT")) {
			return accountBalance.compareTo(balance) >= 0;
		}
		else if(condition.name().equals("EQ")){
			return accountBalance.compareTo(balance) == 0;
		}
		else {
			throw new IllegalArgumentException();
		}
	}

	public enum Condition {
		LT,
		GT,
		EQ
	}
}