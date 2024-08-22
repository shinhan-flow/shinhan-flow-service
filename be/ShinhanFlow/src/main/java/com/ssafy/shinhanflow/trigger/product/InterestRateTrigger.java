package com.ssafy.shinhanflow.trigger.product;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.ssafy.shinhanflow.trigger.Trigger;

import lombok.NonNull;

public record InterestRateTrigger(@NonNull Product product, @NonNull BigDecimal rate) implements Trigger {

	public enum Product{
		DEPOSIT, SAVING, LOAN
	}
	@Override
	public boolean isTriggered() {
		// todo: product에 맞는 상품 조회
		List<BigDecimal> rates = new ArrayList<>();
		for(BigDecimal rate: rates){
			if(this.rate.compareTo(rate) >= 0){
				return true;
			}
		}
		return false;
	}
}
