package com.ssafy.shinhanflow.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.ssafy.shinhanflow.domain.entity.MemberEntity;

@Repository
public interface MemberRepository extends JpaRepository<MemberEntity, Long> {

	MemberEntity findByEmail(String email);

	List<MemberEntity> findByEmailContaining(String keyword);

}
