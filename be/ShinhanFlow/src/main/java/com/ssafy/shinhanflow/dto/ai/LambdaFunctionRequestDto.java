package com.ssafy.shinhanflow.dto.ai;

import lombok.Builder;

@Builder
public record LambdaFunctionRequestDto(Long userId, String prompt) {
}
