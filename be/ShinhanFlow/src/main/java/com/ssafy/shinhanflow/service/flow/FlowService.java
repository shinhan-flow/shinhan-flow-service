package com.ssafy.shinhanflow.service.flow;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.domain.action.Action;
import com.ssafy.shinhanflow.domain.entity.ActionEntity;
import com.ssafy.shinhanflow.domain.entity.FlowEntity;
import com.ssafy.shinhanflow.domain.entity.TriggerEntity;
import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.dto.flow.CreateFlowRequestDto;
import com.ssafy.shinhanflow.dto.flow.GetFlowListResponseDto;
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

	@Transactional
	public Boolean createFlow(Long memberId, CreateFlowRequestDto createFlowRequestDto) {

		// flow 생성
		FlowEntity flowEntity = FlowEntity
			.builder()
			.memberId(memberId)
			.title(createFlowRequestDto.title())
			.description(createFlowRequestDto.description())
			.build();

		FlowEntity flow = flowRepository.save(flowEntity);

		// trigger 생성
		Trigger[] triggers = createFlowRequestDto.triggers();
		for (Trigger trigger : triggers) {
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
		for (Action action : actions) {
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

	public GetFlowListResponseDto getFlowList(Long memberId, Integer nowPage, Integer perPage) {
		Pageable pageable = PageRequest.of(nowPage, perPage);
		Page<FlowEntity> res = flowRepository.findAll(pageable);

		return GetFlowListResponseDto
			.builder()
			.totalPage(res.getTotalPages())
			.nowPage(res.getNumber())
			.pageContent(res.getContent())
			.build();
	}
}
