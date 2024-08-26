package com.ssafy.shinhanflow.controller.flow;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.ssafy.shinhanflow.auth.jwt.JWTUtil;
import com.ssafy.shinhanflow.config.error.SuccessResponse;
import com.ssafy.shinhanflow.dto.flow.CreateFlowRequestDto;
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
	){
		return SuccessResponse.of(flowService.createFlow(jwtUtil.getId(token), createFlowRequestDto));
	}

}
