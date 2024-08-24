package com.ssafy.shinhanflow.util;

import lombok.Builder;

@Builder
public record FcmMessageRequestDto(Long memberId, String title, String content) {
}
