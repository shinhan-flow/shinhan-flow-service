package com.ssafy.shinhanflow.domain.trigger.date;

import java.time.LocalDate;
import java.util.Set;

import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.service.finance.FinanceTriggerService;

import jakarta.validation.constraints.NotEmpty;

public record DayOfMonthTrigger(
	@NotEmpty
	Set<Integer> days

) implements Trigger {

	@Override
	public boolean isTriggered(FinanceTriggerService financeTriggerService) {
		LocalDate today = LocalDate.now();
		for (Integer day : days) {
			if (today.getDayOfMonth() == day) {
				return true;
			}
		}
		return false;
	}
}
