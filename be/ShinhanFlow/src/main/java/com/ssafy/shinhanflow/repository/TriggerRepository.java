package com.ssafy.shinhanflow.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ssafy.shinhanflow.domain.entity.TriggerEntity;

public interface TriggerRepository extends JpaRepository<TriggerEntity, Long> {
	List<TriggerEntity> findByFlowId(Long flowId);
}
