package com.ssafy.shinhanflow.trigger.date;

import java.time.LocalDate;
import java.util.List;
import java.util.Set;

import com.ssafy.shinhanflow.trigger.Trigger;

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