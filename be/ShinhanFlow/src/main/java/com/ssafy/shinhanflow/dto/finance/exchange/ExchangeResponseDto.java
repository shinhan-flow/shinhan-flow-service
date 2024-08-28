package com.ssafy.shinhanflow.dto.finance.exchange;

import java.math.BigDecimal;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;
import com.ssafy.shinhanflow.dto.finance.header.ResponseHeaderDto;

import lombok.EqualsAndHashCode;
import lombok.Value;

@EqualsAndHashCode(callSuper = true)
@Value
public class ExchangeResponseDto extends FinanceApiResponseDto {
	@JsonProperty("Header")
	ResponseHeaderDto header;
	@JsonProperty("REC")
	Rec rec;

	@Value
	public static class Rec {
		ExchangeCurrency exchangeCurrency;
		AccountInfo accountInfo;

		@Value
		public static class ExchangeCurrency {
			BigDecimal amount;
			BigDecimal exchangeRate;
			String currency;
			String currencyName;

			public ExchangeCurrency(String amount, String exchangeRate, String currency, String currencyName) {
				this.amount = new BigDecimal(amount.replace(",", ""));
				this.exchangeRate = new BigDecimal(exchangeRate.replace(",", ""));
				this.currency = currency;
				this.currencyName = currencyName;
			}
		}

		@Value
		public static class AccountInfo {
			String accountNo;
			BigDecimal amount;
			BigDecimal balance;

			public AccountInfo(String accountNo, String amount, String balance) {
				this.accountNo = accountNo;
				this.amount = new BigDecimal(amount.replace(",", ""));
				this.balance = new BigDecimal(balance.replace(",", ""));
			}
		}
	}
}
