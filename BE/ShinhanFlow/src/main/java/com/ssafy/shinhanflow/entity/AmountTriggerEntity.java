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
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity()
@Table(name = "amount_trigger")
public class AmountTriggerEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotNull
	@Column(name = "flow_id")
	private Long flowId;

	@NotNull
	@Column(name = "code")
	private Byte code;

	@NotNull
	@Column(name = "withdraw")
	private String withdraw;

	@NotNull
	@Column(name = "deposit")
	private String deposit;

	@Enumerated(EnumType.STRING)
	@NotNull
	@Column(name = "condition")
	private Condition condition;

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

	private enum Condition{
		LT, GT, EQ
	}
}
