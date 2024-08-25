package com.ssafy.shinhanflow.domain.trigger.date;

import java.time.LocalDate;

import com.ssafy.shinhanflow.domain.trigger.Trigger;

import lombok.NonNull;

public record PeriodDateTrigger(@NonNull LocalDate start, @NonNull LocalDate end) implements Trigger {
	@Override
	public boolean isTriggered() {
		LocalDate today = LocalDate.now();
		return today.isEqual(start) || today.isEqual(end) || (today.isAfter(start) && today.isBefore(end));
	}
}
