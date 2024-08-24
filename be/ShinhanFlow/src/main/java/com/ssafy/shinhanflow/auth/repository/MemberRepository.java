package com.ssafy.shinhanflow.auth.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import com.ssafy.shinhanflow.entity.MemberEntity;

@Repository
public interface MemberRepository extends JpaRepository<MemberEntity, Long> {

	MemberEntity findByEmail(String email);

	@Query("SELECT m.userKey FROM MemberEntity m WHERE m.id = :id")
	String findUserKeyById(Long id);

}
