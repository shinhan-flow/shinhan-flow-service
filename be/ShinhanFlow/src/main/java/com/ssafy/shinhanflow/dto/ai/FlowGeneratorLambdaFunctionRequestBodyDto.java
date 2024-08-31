package com.ssafy.shinhanflow.dto.ai;

import lombok.Builder;

@Builder
public record FlowGeneratorLambdaFunctionRequestBodyDto(Long userId, String prompt) {
}
