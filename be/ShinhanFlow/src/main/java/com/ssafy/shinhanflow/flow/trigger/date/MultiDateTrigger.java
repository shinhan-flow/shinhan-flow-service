package com.ssafy.shinhanflow.flow.trigger.date;

import java.time.LocalDate;
import java.util.Set;

import com.ssafy.shinhanflow.flow.trigger.Trigger;

import lombok.NonNull;

public record MultiDateTrigger(@NonNull Set<LocalDate> dates) implements Trigger {
	@Override
	public boolean isTriggered() {
		LocalDate today = LocalDate.now();
		for(LocalDate date: dates){
			if(today.isEqual(date)){
				return true;
			}
		}
		return false;
	}
}
