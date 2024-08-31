package com.ssafy.shinhanflow.domain.trigger.account;

import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.dto.finance.current.CurrentAccountBalanceResponseDto;
import com.ssafy.shinhanflow.service.finance.FinanceTriggerService;
import com.ssafy.shinhanflow.util.constants.Condition;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public record BalanceTrigger(
	@NotBlank
	String account,
	@NotNull
	@Positive
	Long balance,
	@NotNull
	Condition condition

) implements Trigger {

	@Override
	public boolean isTriggered(FinanceTriggerService financeTriggerService, Long userId) {

		log.info("memberId: {}, account: {}", userId, account);
		CurrentAccountBalanceResponseDto dto = financeTriggerService.currentAccountBalance(userId, account);

		Long accountBalance = dto.getRec().accountBalance();

		return switch (condition.name()) {
			case "LE" -> accountBalance.compareTo(balance) <= 0;
			case "GE" -> accountBalance.compareTo(balance) >= 0;
			default -> throw new BadRequestException(ErrorCode.INVALID_TRIGGER_CONDITION);
		};
	}

}
