package com.ssafy.shinhanflow.entity;

import java.math.BigDecimal;
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
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Table(name = "product_trigger")
@Entity
public class ProductTrigger {

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
	@Column(name = "interest", precision = 5, scale = 3)
	private BigDecimal interest;

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
