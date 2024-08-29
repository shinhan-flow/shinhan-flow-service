package com.ssafy.shinhanflow.domain.trigger.date;

import java.time.LocalDate;
import java.util.Set;

import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.service.finance.FinanceTriggerService;

import jakarta.validation.Valid;
import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;

public record MultiDateTrigger(
	@NotEmpty
	@Valid
	Set<@NotNull @FutureOrPresent LocalDate> dates

) implements Trigger {
	@Override
	public boolean isTriggered(FinanceTriggerService financeTriggerService, Long userId) {
		LocalDate today = LocalDate.now();
		for (LocalDate date : dates) {
			if (today.isEqual(date)) {
				return true;
			}
		}
		return false;
	}
}
