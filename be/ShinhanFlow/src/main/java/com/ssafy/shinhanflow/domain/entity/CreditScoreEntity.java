package com.ssafy.shinhanflow.domain.entity;

import java.time.LocalDateTime;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import lombok.AccessLevel;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Entity(name = "Credit_score")
public class CreditScoreEntity {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	// @NotNull
	@Column(name = "member_id")
	private Long memberId;

	// @NotNull
	@Setter
	@Column(name = "rating_name")
	private String ratingName;

	// @NotNull
	@Setter
	@Column(name = "demand_deposit_asset_value")
	private Long demandDepositAssetValue;

	// @NotNull
	@Setter
	@Column(name = "deposit_savings_asset_value")
	private Long depositSavingsAssetValue;

	// @NotNull
	@Setter
	@Column(name = "total_asset_value")
	private Long totalAssetValue;

	@Setter
	@Column(name = "updated_at", columnDefinition = "TIMESTAMP")
	private LocalDateTime updatedAt;

	@Builder
	public CreditScoreEntity(String ratingName, Long demandDepositAssetValue, Long depositSavingsAssetValue,
		Long totalAssetValue, Long memberId) {
		this.ratingName = ratingName;
		this.demandDepositAssetValue = demandDepositAssetValue;
		this.depositSavingsAssetValue = depositSavingsAssetValue;
		this.totalAssetValue = totalAssetValue;
		this.memberId = memberId;
		this.updatedAt = LocalDateTime.now();
	}
}
