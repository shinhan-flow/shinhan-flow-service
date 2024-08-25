package com.ssafy.shinhanflow.dto.flow;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.ssafy.shinhanflow.domain.action.Action;
import com.ssafy.shinhanflow.domain.action.BalanceNotificationAction;
import com.ssafy.shinhanflow.domain.action.ExchangeAction;
import com.ssafy.shinhanflow.domain.action.ExchangeRateNotificationAction;
import com.ssafy.shinhanflow.domain.action.TextNotificationAction;
import com.ssafy.shinhanflow.domain.action.TransferAction;
import com.ssafy.shinhanflow.domain.trigger.Trigger;
import com.ssafy.shinhanflow.domain.trigger.account.BalanceTrigger;
import com.ssafy.shinhanflow.domain.trigger.account.DepositTrigger;
import com.ssafy.shinhanflow.domain.trigger.account.TransferTrigger;
import com.ssafy.shinhanflow.domain.trigger.account.WithDrawTrigger;
import com.ssafy.shinhanflow.domain.trigger.date.DayOfMonthTrigger;
import com.ssafy.shinhanflow.domain.trigger.date.DayOfWeekTrigger;
import com.ssafy.shinhanflow.domain.trigger.date.MultiDateTrigger;
import com.ssafy.shinhanflow.domain.trigger.date.PeriodDateTrigger;
import com.ssafy.shinhanflow.domain.trigger.date.SpecificDateTrigger;
import com.ssafy.shinhanflow.domain.trigger.exchange.ExchangeRateTrigger;
import com.ssafy.shinhanflow.domain.trigger.product.InterestRateTrigger;
import com.ssafy.shinhanflow.domain.trigger.time.SpecificTimeTrigger;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;

public record CreateFlowRequestDto(
	String title,
	String description,
	@JsonTypeInfo(
		use = JsonTypeInfo.Id.NAME,
		include = JsonTypeInfo.As.PROPERTY,
		property = "type"
	)
	@JsonSubTypes({
		@JsonSubTypes.Type(value = BalanceTrigger.class, name = "balance"),
		@JsonSubTypes.Type(value = DepositTrigger.class, name = "deposit"),
		@JsonSubTypes.Type(value = TransferTrigger.class, name = "transfer"),
		@JsonSubTypes.Type(value = WithDrawTrigger.class, name = "withDraw"),
		@JsonSubTypes.Type(value = DayOfWeekTrigger.class, name = "dayOfWeek"),
		@JsonSubTypes.Type(value = DayOfMonthTrigger.class, name = "dayOfMonth"),
		@JsonSubTypes.Type(value = MultiDateTrigger.class, name = "multiDate"),
		@JsonSubTypes.Type(value = PeriodDateTrigger.class, name = "periodDate"),
		@JsonSubTypes.Type(value = SpecificDateTrigger.class, name = "specificDate"),
		@JsonSubTypes.Type(value = ExchangeRateTrigger.class, name = "exchangeRate"),
		@JsonSubTypes.Type(value = InterestRateTrigger.class, name = "interestRate"),
		@JsonSubTypes.Type(value = SpecificTimeTrigger.class, name = "specificTime")
	})
	@NotEmpty
	@Valid
	Trigger[] triggers,

	@JsonTypeInfo(
		use = JsonTypeInfo.Id.NAME,
		include = JsonTypeInfo.As.PROPERTY,
		property = "type"
	)
	@JsonSubTypes({
		@JsonSubTypes.Type(value = TextNotificationAction.class, name = "textNotification"),
		@JsonSubTypes.Type(value = BalanceNotificationAction.class, name = "balanceNotification"),
		@JsonSubTypes.Type(value = ExchangeRateNotificationAction.class, name = "exchangeRateNotification"),
		@JsonSubTypes.Type(value = TransferAction.class, name = "transfer"),
		@JsonSubTypes.Type(value = ExchangeAction.class, name = "exchange")
	})
	@NotEmpty
	@Valid
	Action[] actions
) {
}
