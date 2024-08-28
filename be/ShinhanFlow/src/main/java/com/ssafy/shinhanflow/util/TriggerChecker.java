package com.ssafy.shinhanflow.util;

import java.time.LocalDateTime;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.shinhanflow.domain.action.Action;
import com.ssafy.shinhanflow.domain.entity.TriggerEntity;
import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.repository.ActionRepository;
import com.ssafy.shinhanflow.repository.FlowRepository;
import com.ssafy.shinhanflow.repository.TriggerRepository;
import com.ssafy.shinhanflow.service.finance.FinanceTriggerService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class TriggerChecker {

	private final FinanceTriggerService financeTriggerService;
	private final TriggerRepository triggerRepository;
	private final ActionRepository actionRepository;
	private final FlowRepository flowRepository;
	private final ObjectMapper objectMapper;
	private final FirebaseCloudMessageService firebaseCloudMessageService;

	/**
	 *
	 *	오늘 트리거 되지않은 트리거를 가져온 후
	 *  isTriggered 함수를 호출하여 같은 플로우에 속해있는 모든 트리거가 만족하는지 검사.
	 *  만족한다면 action을 실행하고 isTriggered를 갱신
	 *  만족하지 않는다면 다음 플로우로 넘어감
	 *  모든 플로우를 검사한 후에는 다시 처음부터 검사
	 *  enable이 false인 플로우는 검사하지 않음
	 */
	public void run() {
		triggerRepository.findNotTriggered(LocalDateTime.now()).stream().collect(
			Collectors.groupingBy(TriggerEntity::getFlowId)
		).forEach((flowId, triggers) -> {
			boolean allTriggered = triggers.stream()
				.allMatch(trigger -> {
					try {
						Trigger t = objectMapper.readValue(trigger.getData(), Trigger.class);
						return t.isTriggered(financeTriggerService);
					} catch (JsonProcessingException e) {
						log.error(e.getMessage());
						return false;
					}
				});

			if (allTriggered) {
				actionRepository.findByFlowId(flowId)
					.forEach(actionEntity -> {
							try {
								Action a = objectMapper.readValue(actionEntity.getData(), Action.class);
								a.execute();
							} catch (JsonProcessingException e) {
								log.error(e.getMessage());
							}
						}
					);
				triggers.forEach(triggerEntity -> {
					triggerEntity.triggered();
					triggerRepository.save(triggerEntity);
				});
			}

		});
	}
}
