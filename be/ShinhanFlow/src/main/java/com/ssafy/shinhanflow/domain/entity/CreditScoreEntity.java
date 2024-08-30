package com.ssafy.shinhanflow.domain.entity;

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

}
