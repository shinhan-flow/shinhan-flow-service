package com.ssafy.shinhanflow.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.ssafy.shinhanflow.domain.entity.CreditScoreEntity;

public interface CreditScoreRepository extends JpaRepository<CreditScoreEntity, Long> {
	CreditScoreEntity findByMemberId(Long memberId);
}
