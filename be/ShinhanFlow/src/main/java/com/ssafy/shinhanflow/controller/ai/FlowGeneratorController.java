package com.ssafy.shinhanflow.controller.ai;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.ssafy.shinhanflow.auth.jwt.JWTUtil;
import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.dto.ai.FlowGeneratorRequestDto;
import com.ssafy.shinhanflow.dto.ai.FlowGeneratorResponseDto;
import com.ssafy.shinhanflow.dto.flow.CreateFlowRequestDto;
import com.ssafy.shinhanflow.service.ai.LocalFlowGeneratorService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@RestController
@RequestMapping("/api/v1/ai")
@RequiredArgsConstructor
public class FlowGeneratorController {

	private final JWTUtil jwtUtil;
	private final LocalFlowGeneratorService flowGeneratorService;

	@PostMapping("/flow-generator")
	public SuccessResponse<FlowGeneratorResponseDto> generateFlow(
		@RequestHeader("Authorization") String token,
		@RequestBody FlowGeneratorRequestDto dto
	) throws JsonProcessingException {
		log.info("FlowGeneratorController.generateFlow");
		CreateFlowRequestDto flow = flowGeneratorService.generateFlow(jwtUtil.getId(token), dto.prompt());
		return SuccessResponse.of(
			FlowGeneratorResponseDto.builder()
				.flow(flow)
				.build()
		);
	}
}
