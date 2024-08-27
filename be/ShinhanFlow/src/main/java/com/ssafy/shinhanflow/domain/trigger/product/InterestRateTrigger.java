package com.ssafy.shinhanflow.domain.trigger.product;

import java.math.BigDecimal;
import java.util.List;
import java.util.stream.Collectors;

import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.service.finance.FinanceProductService;
import com.ssafy.shinhanflow.util.constants.AccountProduct;

import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;

public record InterestRateTrigger(
	FinanceProductService financeProductService,
	@NotNull
	AccountProduct accountProduct,
	@NotNull
	@Positive
	BigDecimal rate

) implements Trigger {

	@Override
	public boolean isTriggered() {

		List<BigDecimal> rates = getProductRates(accountProduct);

		return rates.stream().anyMatch(rate -> this.rate.compareTo(rate) >= 0);
	}

	private List<BigDecimal> getProductRates(AccountProduct accountProduct) {
		return switch (accountProduct) {
			case DEPOSIT_ACCOUNT -> financeProductService.depositProductsInfo()
				.getRec()
				.stream()
				.map(rec -> BigDecimal.valueOf(rec.interestRate()))
				.collect(Collectors.toList());
			case SAVING_ACCOUNT -> financeProductService.savingProductsInfo()
				.getRec()
				.stream()
				.map(rec -> BigDecimal.valueOf(rec.interestRate()))
				.collect(Collectors.toList());
			case LOAN_ACCOUNT -> financeProductService.loanProductsInfo()
				.getRec()
				.stream()
				.map(rec -> BigDecimal.valueOf(rec.interestRate()).negate()) // 대출 금리는 음수로 변환
				.collect(Collectors.toList());
			// CURRENT_ACCOUNT type 은 interestRate 이 없음
			default -> throw new BadRequestException(ErrorCode.INVALID_ACCOUNT_TYPE);
		};
	}
}