package com.ssafy.shinhanflow.trigger.date;

import java.time.LocalDate;

import com.ssafy.shinhanflow.trigger.Trigger;

public record SpecificDateTrigger(LocalDate localDate) implements Trigger {
	@Override
	public boolean isTriggered() {
		LocalDate today = LocalDate.now();
		return today.isEqual(localDate);
	}

}
