package com.ssafy.shinhanflow.service.flow;

import java.util.Optional;
import java.util.concurrent.Flow;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.domain.action.Action;
import com.ssafy.shinhanflow.domain.entity.ActionEntity;
import com.ssafy.shinhanflow.domain.entity.FlowEntity;
import com.ssafy.shinhanflow.domain.entity.TriggerEntity;
import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.dto.flow.CreateFlowRequestDto;
import com.ssafy.shinhanflow.repository.ActionRepository;
import com.ssafy.shinhanflow.repository.FlowRepository;
import com.ssafy.shinhanflow.repository.TriggerRepository;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class FlowService {
	private final FlowRepository flowRepository;
	private final TriggerRepository triggerRepository;
	private final ActionRepository actionRepository;

	public Boolean createFlow(Long memberId, CreateFlowRequestDto createFlowRequestDto) {

		// flow 생성
		FlowEntity flowEntity = FlowEntity
			.builder()
			.memberId(memberId)
			.title(createFlowRequestDto.title())
			.description(createFlowRequestDto.description())
			.build();

		FlowEntity flow =  flowRepository.save(flowEntity);

		// trigger 생성
		Trigger[] triggers = createFlowRequestDto.triggers();
		for(Trigger trigger : triggers) {
			TriggerEntity triggerEntity = TriggerEntity
				.builder()
				.flowId(flow.getId())
				.memberId(memberId)
				.type(trigger.getClass().getSimpleName())
				.data(trigger.toJson())
				.build();

			triggerRepository.save(triggerEntity);
		}

		// action 생성
		Action[] actions = createFlowRequestDto.actions();
		for(Action action : actions) {
			ActionEntity actionEntity = ActionEntity
				.builder()
				.memberId(memberId)
				.flowId(flow.getId())
				.type(action.getClass().getSimpleName())
				.data(action.toJson())
				.build();

			actionRepository.save(actionEntity);
		}
		return true;
	}
}
