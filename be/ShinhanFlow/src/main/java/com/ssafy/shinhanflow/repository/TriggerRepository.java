package com.ssafy.shinhanflow.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ssafy.shinhanflow.domain.entity.TriggerEntity;

public interface TriggerRepository extends JpaRepository<TriggerEntity, Long> {
}
