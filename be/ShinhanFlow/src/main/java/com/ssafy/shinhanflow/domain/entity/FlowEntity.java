package com.ssafy.shinhanflow.domain.entity;

import java.time.LocalDateTime;

import org.hibernate.annotations.ColumnDefault;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name = "flows")
public class FlowEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotNull
	@Column(name = "member_id")
	private Long memberId;

	@NotNull
	@Column(name = "title", length = 30)
	private String title;

	@NotNull
	@Column(name = "description", length = 100)
	private String description;

	@ColumnDefault("1")
	@Column(name = "enable", nullable = false, insertable = false, columnDefinition = "TINYINT(1)")
	private Boolean enable;

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
	public FlowEntity(Long memberId, String title, String description) {
		this.memberId = memberId;
		this.title = title;
		this.description = description;
	}

	public Boolean toggleStatus() {
		enable = !enable;
		return enable;
	}
}
