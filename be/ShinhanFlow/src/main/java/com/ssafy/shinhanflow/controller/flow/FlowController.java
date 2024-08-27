package com.ssafy.shinhanflow.controller.flow;

import org.springframework.data.repository.query.Param;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.ssafy.shinhanflow.auth.jwt.JWTUtil;
import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.dto.flow.CreateFlowRequestDto;
import com.ssafy.shinhanflow.dto.flow.FlowDetailResponseDto;
import com.ssafy.shinhanflow.dto.flow.GetFlowListResponseDto;
import com.ssafy.shinhanflow.service.flow.FlowService;

import jakarta.validation.Valid;
import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@RestController
@RequestMapping("/api/v1/flows")
public class FlowController {

	private final JWTUtil jwtUtil;
	private final FlowService flowService;

	@PostMapping
	public SuccessResponse<Boolean> createFlow(
		@RequestHeader("Authorization") String token,
		@RequestBody @Valid CreateFlowRequestDto createFlowRequestDto
	) {
		return SuccessResponse.of(flowService.createFlow(jwtUtil.getId(token), createFlowRequestDto));
	}

	@GetMapping
	public SuccessResponse<GetFlowListResponseDto> getFlowList(
		@RequestHeader("Authorization") String token,
		@Param("nowPage") Integer nowPage,
		@Param("perPage") Integer perPage
	) {
		return SuccessResponse.of(flowService.getFlowList(jwtUtil.getId(token), nowPage, perPage));

	}

	@GetMapping("/{flowId}")
	public SuccessResponse<FlowDetailResponseDto> getFlowDetail(
		@RequestHeader("Authorization") String token,
		@PathVariable Long flowId
	) throws JsonProcessingException {
		return SuccessResponse.of(flowService.getFlowDetail(jwtUtil.getId(token), flowId));
	}

	@GetMapping("/test")
	public String test() throws JsonProcessingException {
		flowService.testFlowTrigger();
		return "test";
	}

}
