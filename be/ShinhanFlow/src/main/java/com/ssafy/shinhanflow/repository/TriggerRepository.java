package com.ssafy.shinhanflow.repository;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.ssafy.shinhanflow.domain.entity.TriggerEntity;

public interface TriggerRepository extends JpaRepository<TriggerEntity, Long> {

	List<TriggerEntity> findByFlowId(Long flowId);

	@Query(value = "SELECT t.* FROM triggers t JOIN flows f ON t.flow_id = f.id WHERE (t.triggered_at IS NULL OR DATE(t.triggered_at) <> DATE(:currentDateTime)) AND f.enable = true", nativeQuery = true)
	List<TriggerEntity> findNotTriggered(@Param("currentDateTime") LocalDateTime currentDateTime);

}
