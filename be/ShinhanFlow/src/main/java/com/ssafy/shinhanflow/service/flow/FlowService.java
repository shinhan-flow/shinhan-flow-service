package com.ssafy.shinhanflow.service.flow;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.node.ObjectNode;
import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.NotFoundException;
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
import com.ssafy.shinhanflow.dto.flow.FlowDetailResponseDto;
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
	private final ObjectMapper objectMapper;

	@Transactional
	public Boolean createFlow(Long memberId, CreateFlowRequestDto createFlowRequestDto) {

		try {

			// flow 생성
			FlowEntity flowEntity = FlowEntity
				.builder()
				.memberId(memberId)
				.title(createFlowRequestDto.title())
				.description(createFlowRequestDto.description())
				.build();

			FlowEntity flow = flowRepository.save(flowEntity);

			// trigger 생성
			List<Trigger> triggers = createFlowRequestDto.triggers();
			for (Trigger trigger : triggers) {

				String jsonString = objectMapper.writeValueAsString(trigger);
				JsonNode jsonNode = objectMapper.readTree(jsonString);
				ObjectNode objectNode = (ObjectNode)jsonNode;
				objectNode.put("type", trigger.getClass().getSimpleName());
				jsonString = objectMapper.writeValueAsString(objectNode);

				TriggerEntity triggerEntity = TriggerEntity
					.builder()
					.flowId(flow.getId())
					.memberId(memberId)
					.type(trigger.getClass().getSimpleName())
					.data(jsonString)
					.build();

				triggerRepository.save(triggerEntity);

			}

			// action 셍성
			List<Action> actions = createFlowRequestDto.actions();
			for (Action action : actions) {
				String jsonString = objectMapper.writeValueAsString(action);
				JsonNode jsonNode = objectMapper.readTree(jsonString);
				ObjectNode objectNode = (ObjectNode)jsonNode;
				objectNode.put("type", action.getClass().getSimpleName());
				jsonString = objectMapper.writeValueAsString(objectNode);

				ActionEntity actionEntity = ActionEntity
					.builder()
					.memberId(memberId)
					.flowId(flow.getId())

					.type(action.getClass().getSimpleName())
					.data(jsonString)
					.build();

				actionRepository.save(actionEntity);
			}
		} catch (JsonProcessingException e) {
			e.printStackTrace();
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

	public FlowDetailResponseDto getFlowDetail(Long memberId, Long flowId) {
		FlowDetailResponseDto flowDetailResponseDto = null;
		FlowEntity flow = flowRepository.findById(flowId).orElseThrow(() -> new NotFoundException(ErrorCode.NOT_FOUND));
		List<TriggerEntity> triggerEntities = triggerRepository.findByFlowId(flowId);
		List<ActionEntity> actionEntities = actionRepository.findByFlowId(flowId);

		try {
			List<Trigger> triggers = new ArrayList<>();
			for (TriggerEntity triggerEntity : triggerEntities) {
				Trigger trigger = objectMapper.readValue(triggerEntity.getData(), Trigger.class);
				triggers.add(trigger);
			}

			List<Action> actions = new ArrayList<>();
			for (ActionEntity actionEntity : actionEntities) {
				Action action = objectMapper.readValue(actionEntity.getData(), Action.class);
				actions.add(action);
			}

			flowDetailResponseDto = FlowDetailResponseDto
				.builder()
				.id(flow.getId())
				.title(flow.getTitle())
				.description(flow.getDescription())
				.triggers(triggers)
				.actions(actions)
				.build();

		} catch (JsonProcessingException e) {
			e.printStackTrace();
		}
		return flowDetailResponseDto;
	}


}
