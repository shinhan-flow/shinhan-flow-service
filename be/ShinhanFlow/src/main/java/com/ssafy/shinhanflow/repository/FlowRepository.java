package com.ssafy.shinhanflow.repository;

import org.springframework.data.domain.Page;
import org.springframework.data.domain.Pageable;
import org.springframework.data.jpa.repository.JpaRepository;

import com.ssafy.shinhanflow.domain.entity.FlowEntity;

public interface FlowRepository extends JpaRepository<FlowEntity, Long> {
	Page<FlowEntity> findByMemberId(Long memberId, Pageable pageable);
}
