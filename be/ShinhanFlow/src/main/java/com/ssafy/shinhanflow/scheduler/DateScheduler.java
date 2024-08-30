package com.ssafy.shinhanflow.scheduler;

import org.springframework.stereotype.Component;

import com.ssafy.shinhanflow.repository.TriggerRepository;
import com.ssafy.shinhanflow.util.TriggerChecker;

import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class DateScheduler {

	private final TriggerChecker triggerChecker;
	private final TriggerRepository triggerRepository;

	// @Scheduled(cron = "*/5 * * * * *")
	public void checkDateTrigger() {
		triggerChecker.run();
	}

}
