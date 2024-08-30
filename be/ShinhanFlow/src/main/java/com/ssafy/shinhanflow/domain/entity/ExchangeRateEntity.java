package com.ssafy.shinhanflow.domain.entity;

import java.math.BigDecimal;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import jakarta.validation.constraints.NotNull;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Table(name = "exchange_rates")
public class ExchangeRateEntity {

	@Id
	@NotNull
	@Column(name = "currency")
	private String currency;

	@NotNull
	@Setter
	@Column(name = "exchange_rate")
	private BigDecimal exchangeRate;

	@NotNull
	@Setter
	@Column(name = "exchange_min")
	private BigDecimal exchangeMin;

	@NotNull
	@Setter
	@Column(name = "created")
	private String created;

}
