package com.ssafy.shinhanflow.entity;

import java.time.LocalDateTime;

import org.hibernate.annotations.ColumnDefault;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.EnumType;
import jakarta.persistence.Enumerated;
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
@Table(name = "trigger")
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
	@Enumerated(EnumType.STRING)
	@Column(name = "category")
	private Category category;

	@NotNull
	@Column(name = "code")
	private int code;

	@NotNull
	@Column(name = "data")
	private String data;

	@ColumnDefault("CURRENT_TIMESTAMP")
	@NotNull
	@Column(name = "created_at", insertable = false, updatable = false, columnDefinition = "TIMESTAMP")
	private LocalDateTime createdAt;

	@ColumnDefault("CURRENT_TIMESTAMP")
	@NotNull
	@Column(name = "updated_at", insertable = false, columnDefinition = "TIMESTAMP")
	private LocalDateTime updatedAt;

	@ColumnDefault("NULL")
	@Column(name = "deleted_at", insertable = false)
	private LocalDateTime deletedAt;

	public enum Category {
		TIME, PRODUCT, AMOUNT, EXCHANGE
	}

	@Builder
	public TriggerEntity(Long flowId, Long memberId, Category category, int code, String data) {
		this.flowId = flowId;
		this.memberId = memberId;
		this.category = category;
		this.code = code;
		this.data = data;
	}
}
