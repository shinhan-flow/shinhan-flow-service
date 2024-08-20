package com.ssafy.shinhanflow.entity;

import java.time.LocalDateTime;

import org.hibernate.annotations.ColumnDefault;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.validation.constraints.NotNull;
import lombok.AccessLevel;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name = "Flow")
public class FlowEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotNull
	@Column(name = "title", length = 30)
	private String title;

	@NotNull
	@Column(name = "description", length = 100)
	private String description;

	@NotNull
	@ColumnDefault("true")
	@Column(name = "enable")
	private Boolean enable;

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
}
