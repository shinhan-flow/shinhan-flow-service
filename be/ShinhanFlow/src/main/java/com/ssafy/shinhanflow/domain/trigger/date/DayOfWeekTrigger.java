package com.ssafy.shinhanflow.domain.trigger.date;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.util.Set;

import com.ssafy.shinhanflow.domain.trigger.Trigger;

import jakarta.validation.constraints.NotEmpty;

public record DayOfWeekTrigger(
	@NotEmpty Set<DayOfWeek> daysOfWeek

) implements Trigger {
	@Override
	public boolean isTriggered() {
		LocalDate today = LocalDate.now();
		DayOfWeek todayOfWeek = today.getDayOfWeek();

		for (DayOfWeek day : daysOfWeek) {
			if (todayOfWeek.equals(day)) {
				return true;
			}

		}
		return false;
	}
}
