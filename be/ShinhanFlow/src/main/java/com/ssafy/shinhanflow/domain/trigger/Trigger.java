package com.ssafy.shinhanflow.domain.trigger;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
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

/**
 * Trigger interface
 * 모든 Trigger 클래스는 이 인터페이스를 구현해야 한다.
 * Trigger 클래스는 isTriggered 메소드를 구현해야 한다.
 */
@JsonTypeInfo(
	use = JsonTypeInfo.Id.NAME,
	include = JsonTypeInfo.As.PROPERTY,
	property = "type"
)
@JsonSubTypes({
	@JsonSubTypes.Type(value = BalanceTrigger.class),
	@JsonSubTypes.Type(value = DepositTrigger.class),
	@JsonSubTypes.Type(value = TransferTrigger.class),
	@JsonSubTypes.Type(value = WithDrawTrigger.class),
	@JsonSubTypes.Type(value = DayOfWeekTrigger.class),
	@JsonSubTypes.Type(value = DayOfMonthTrigger.class),
	@JsonSubTypes.Type(value = MultiDateTrigger.class),
	@JsonSubTypes.Type(value = PeriodDateTrigger.class),
	@JsonSubTypes.Type(value = SpecificDateTrigger.class),
	@JsonSubTypes.Type(value = ExchangeRateTrigger.class),
	@JsonSubTypes.Type(value = InterestRateTrigger.class),
	@JsonSubTypes.Type(value = SpecificTimeTrigger.class)
})
public interface Trigger {
	/**
	 * Trigger가 발생했는지 확인하는 메소드
	 * @return Trigger가 발생했는지 여부
	 */
	@JsonIgnore
	boolean isTriggered();

}

