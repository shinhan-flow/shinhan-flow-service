package com.ssafy.shinhanflow.domain.trigger.date;

import java.time.LocalDate;

import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.service.finance.FinanceTriggerService;

import jakarta.validation.constraints.FutureOrPresent;
import jakarta.validation.constraints.NotNull;

public record PeriodDateTrigger(
	@NotNull
	@FutureOrPresent
	LocalDate startDate,
	@NotNull
	@FutureOrPresent
	LocalDate endDate

) implements Trigger {
	@Override
	public boolean isTriggered(FinanceTriggerService financeTriggerService, Long userId) {
		LocalDate today = LocalDate.now();
		return
			today.isEqual(startDate) || today.isEqual(endDate)
				|| (today.isAfter(startDate) && today.isBefore(endDate));
	}
}
