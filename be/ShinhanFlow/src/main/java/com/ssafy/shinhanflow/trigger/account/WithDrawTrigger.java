package com.ssafy.shinhanflow.trigger.account;

import java.util.ArrayList;
import java.util.List;

import com.ssafy.shinhanflow.trigger.Trigger;

public record WithDrawTrigger(String account, Long amount) implements Trigger{

	@Override
	public boolean isTriggered() {
		//todo: 최근 거래내역 가져오기
		List<Long> amounts = new ArrayList<>();
		for(Long amount: amounts){
			if(Long.compare(amount, this.amount) >= 0){
				return true;
			}
		}
		return false;
	}
}
