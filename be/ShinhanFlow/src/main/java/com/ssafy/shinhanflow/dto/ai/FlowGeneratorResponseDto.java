package com.ssafy.shinhanflow.dto.ai;

import com.ssafy.shinhanflow.dto.flow.CreateFlowRequestDto;

import lombok.Builder;

@Builder
public record FlowGeneratorResponseDto(CreateFlowRequestDto flow) {
}
