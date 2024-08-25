package com.ssafy.shinhanflow.dto;

import lombok.Builder;

@Builder
public record FcmMessageRequestDto(Long memberId, String title, String content) {
}
