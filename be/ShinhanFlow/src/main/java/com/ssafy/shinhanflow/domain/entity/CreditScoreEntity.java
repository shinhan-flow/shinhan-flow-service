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
@Entity(name = "Credit_score")
public class CreditScoreEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotNull
	@Column(name = "member_id")
	private Long memberId;

	@NotNull
	@Column(name = "rating_name")
	private String ratingName;

	@NotNull
	@Column(name = "demand_deposit_asset_value")
	private Long demandDepositAssetValue;

	@NotNull
	@Column(name = "deposit_savings_asset_value")
	private Long depositSavingsAssetValue;

	@NotNull
	@Column(name = "total_asset_value")
	private Long totalAssetValue;

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
	public CreditScoreEntity(Long id, Long memberId, String ratingName, Long demandDepositAssetValue,
		Long depositSavingsAssetValue,
		Long totalAssetValue) {
		this.id = id;
		this.ratingName = ratingName;
		this.demandDepositAssetValue = demandDepositAssetValue;
		this.depositSavingsAssetValue = depositSavingsAssetValue;
		this.totalAssetValue = totalAssetValue;
		this.memberId = memberId;
		this.updatedAt = LocalDateTime.now();
	}
}
