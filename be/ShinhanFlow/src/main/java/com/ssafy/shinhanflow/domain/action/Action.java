package com.ssafy.shinhanflow.domain.action;

import com.fasterxml.jackson.annotation.JsonSubTypes;
import com.fasterxml.jackson.annotation.JsonTypeInfo;
import com.ssafy.shinhanflow.service.flow.FinanceActionService;

/**
 * Action interface
 * 모든 Action 클래스는 이 인터페이스를 구현해야 한다.
 * Action 클래스는 execute 메소드를 구현해야 한다.
 */
@JsonTypeInfo(
	use = JsonTypeInfo.Id.NAME,
	include = JsonTypeInfo.As.PROPERTY,
	property = "type",
	visible = true
)
@JsonSubTypes({
	@JsonSubTypes.Type(value = TextNotificationAction.class),
	@JsonSubTypes.Type(value = BalanceNotificationAction.class),
	@JsonSubTypes.Type(value = ExchangeRateNotificationAction.class),
	@JsonSubTypes.Type(value = TransferAction.class),
	@JsonSubTypes.Type(value = ExchangeAction.class)
})
public interface Action {
	/**
	 * Action을 실행하는 메소드
	 * @return Action이 성공적으로 실행되었는지 여부
	 */
	boolean execute(FinanceActionService financeActionService, Long memberId);

}
