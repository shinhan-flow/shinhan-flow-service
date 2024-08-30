package com.ssafy.shinhanflow.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ssafy.shinhanflow.domain.entity.ExchangeRateEntity;

public interface ExchangeRateRepository extends JpaRepository<ExchangeRateEntity, Long> {
	ExchangeRateEntity findByCurrency(String currency);
}
