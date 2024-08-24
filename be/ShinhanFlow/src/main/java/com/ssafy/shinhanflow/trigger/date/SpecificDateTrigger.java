package com.ssafy.shinhanflow.trigger.date;

import java.time.LocalDate;

import com.ssafy.shinhanflow.trigger.Trigger;

import jakarta.validation.constraints.NotNull;
import lombok.NonNull;

public record SpecificDateTrigger(@NonNull LocalDate localDate) implements Trigger {
	@Override
	public boolean isTriggered() {
		LocalDate today = LocalDate.now();
		return today.isEqual(localDate);
	}

}
