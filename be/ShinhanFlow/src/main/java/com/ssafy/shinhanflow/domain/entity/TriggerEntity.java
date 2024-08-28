package com.ssafy.shinhanflow.domain.entity;

import java.time.LocalDateTime;

import org.hibernate.annotations.ColumnDefault;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity
@Table(name = "triggers")
public class TriggerEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotNull
	@Column(name = "member_id")
	private Long memberId;

	@NotNull
	@Column(name = "flow_id")
	private Long flowId;

	@NotNull
	@Column(name = "type")
	private String type;

	@NotNull
	@Column(name = "data", columnDefinition = "TEXT")
	private String data;

	@ColumnDefault("NULL")
	@Column(name = "triggered_at", insertable = false, columnDefinition = "TIMESTAMP")
	private LocalDateTime triggeredAt;

	@ColumnDefault("CURRENT_TIMESTAMP")
	@Column(name = "created_at", nullable = false, insertable = false, updatable = false, columnDefinition = "TIMESTAMP")
	private LocalDateTime createdAt;

	@ColumnDefault("CURRENT_TIMESTAMP")
	@Column(name = "updated_at", nullable = false, insertable = false, columnDefinition = "TIMESTAMP")
	private LocalDateTime updatedAt;

	@ColumnDefault("NULL")
	@Column(name = "deleted_at", insertable = false, columnDefinition = "TIMESTAMP")
	private LocalDateTime deletedAt;

	@Builder
	public TriggerEntity(Long flowId, Long memberId, String type, String data) {
		this.flowId = flowId;
		this.memberId = memberId;
		this.type = type;
		this.data = data;
	}

	public void triggered() {
		this.triggeredAt = LocalDateTime.now();
	}
}
