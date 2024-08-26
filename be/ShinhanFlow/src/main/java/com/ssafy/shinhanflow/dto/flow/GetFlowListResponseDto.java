package com.ssafy.shinhanflow.dto.flow;

import java.util.List;

import com.ssafy.shinhanflow.domain.entity.FlowEntity;

import lombok.Builder;

@Builder
public record GetFlowListResponseDto(Integer totalPage, Integer nowPage, List<FlowEntity> pageContent) {
}
