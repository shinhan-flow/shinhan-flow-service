package com.ssafy.shinhanflow.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ssafy.shinhanflow.entity.FlowEntity;

public interface FlowRepository extends JpaRepository<FlowEntity, Long> {
}