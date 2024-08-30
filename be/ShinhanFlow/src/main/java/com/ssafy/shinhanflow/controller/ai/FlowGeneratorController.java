package com.ssafy.shinhanflow.controller.ai;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.dto.ai.FlowGeneratorRequestDto;
import com.ssafy.shinhanflow.dto.ai.FlowGeneratorResponseDto;
import com.ssafy.shinhanflow.dto.flow.CreateFlowRequestDto;
import com.ssafy.shinhanflow.service.ai.FlowGeneratorService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/v1/ai")
@RequiredArgsConstructor
public class FlowGeneratorController {

	private final FlowGeneratorService flowGeneratorService;

	@PostMapping("/flow-generator")
	public SuccessResponse<FlowGeneratorResponseDto> generateFlow(
		@RequestHeader("Authorization") String token,
		@RequestBody FlowGeneratorRequestDto dto
	) throws JsonProcessingException {
		CreateFlowRequestDto flow = flowGeneratorService.generateFlow(dto.prompt());
		return SuccessResponse.of(
			FlowGeneratorResponseDto.builder()
				.flow(flow)
				.build()
		);
	}
}
