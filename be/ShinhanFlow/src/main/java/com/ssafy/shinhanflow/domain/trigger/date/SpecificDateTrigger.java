package com.ssafy.shinhanflow.domain.trigger.date;

import java.time.LocalDate;

import com.ssafy.shinhanflow.domain.trigger.Trigger;

import lombok.NonNull;

public record SpecificDateTrigger(@NonNull LocalDate localDate) implements Trigger {
	@Override
	public boolean isTriggered() {
		LocalDate today = LocalDate.now();
		return today.isEqual(localDate);
	}

}
