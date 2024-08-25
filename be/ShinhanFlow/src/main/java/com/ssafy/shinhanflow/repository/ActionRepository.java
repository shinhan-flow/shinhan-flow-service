package com.ssafy.shinhanflow.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ssafy.shinhanflow.entity.ActionEntity;

public interface ActionRepository extends JpaRepository<ActionEntity, Long> {
}
