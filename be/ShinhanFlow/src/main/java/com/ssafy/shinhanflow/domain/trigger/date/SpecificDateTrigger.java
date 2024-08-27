package com.ssafy.shinhanflow.domain.trigger.date;

import java.time.LocalDate;

import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.service.finance.FinanceTriggerService;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotNull;

public record SpecificDateTrigger(
	@NotNull
	@FutureOrPresent
	LocalDate localDate

) implements Trigger {
	@Override
	public boolean isTriggered(FinanceTriggerService financeTriggerService) {
		LocalDate today = LocalDate.now();
		return today.isEqual(localDate);
	}

}
