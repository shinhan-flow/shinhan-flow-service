package com.ssafy.shinhanflow.domain.trigger.product;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.util.constants.AccountProduct;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record InterestRateTrigger(
	@NotNull
	AccountProduct accountProduct,
	@NotNull
	@Positive
	BigDecimal rate

) implements Trigger {

	@Override
	public boolean isTriggered() {
		// todo: product에 맞는 상품 조회
		List<BigDecimal> rates = new ArrayList<>();
		for (BigDecimal rate : rates) {
			if (this.rate.compareTo(rate) >= 0) {
				return true;
			}
		}
		return false;
	}
}