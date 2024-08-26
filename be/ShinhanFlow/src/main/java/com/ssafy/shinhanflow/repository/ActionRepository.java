package com.ssafy.shinhanflow.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ssafy.shinhanflow.domain.entity.ActionEntity;

public interface ActionRepository extends JpaRepository<ActionEntity, Long> {
}
