package com.ssafy.shinhanflow.flow.trigger.date;

import java.time.LocalDate;
import java.util.Set;

import com.ssafy.shinhanflow.domain.trigger.Trigger;

import lombok.NonNull;

public record DayOfMonthTrigger(@NonNull Set<Integer> days) implements Trigger {

	@Override
	public boolean isTriggered() {
		LocalDate today = LocalDate.now();
		for (Integer day : days) {
			if (today.getDayOfMonth() == day) {
				return true;
			}
		}
		return false;
	}
}
