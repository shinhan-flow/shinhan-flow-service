package com.ssafy.shinhanflow.dto.ai;

import lombok.Builder;

@Builder
public record FlowGeneratorRequestDto(String prompt) {
}
