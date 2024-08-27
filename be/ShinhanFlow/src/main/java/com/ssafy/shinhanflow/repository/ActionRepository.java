package com.ssafy.shinhanflow.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ssafy.shinhanflow.domain.entity.ActionEntity;

public interface ActionRepository extends JpaRepository<ActionEntity, Long> {
	List<ActionEntity> findByFlowId(Long flowId);
}
