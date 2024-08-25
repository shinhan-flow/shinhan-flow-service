package com.ssafy.shinhanflow.flow.action;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.BadRequestException;
import com.ssafy.shinhanflow.flow.action.notification.BalanceNotificationAction;
import com.ssafy.shinhanflow.flow.action.notification.ExchangeRateNotificationAction;
import com.ssafy.shinhanflow.flow.action.notification.TextNotificationAction;
import com.ssafy.shinhanflow.flow.trigger.exchange.ExchangeRateTrigger;

public class ActionFactory {

	private final ObjectMapper objectMapper = new ObjectMapper();

	public Action getTrigger(Long memberId, String code, String jsonData) throws JsonProcessingException {

		JsonNode dataNode = objectMapper.readTree(jsonData);

		return switch (code) {
			case ("balanceNotification") -> BalanceNotificationAction.builder()
				.flowId(memberId)
				.memberId(memberId)
				.account(dataNode.get("account").asText())
				.build();

			case ("exchangeRateNotification") -> ExchangeRateNotificationAction.builder()
				.currency(ExchangeRateTrigger.Currency.valueOf(dataNode.get("currency").asText()))
				.memberId(memberId)
				.flowId(memberId)
				.build();

			case ("textNotification") -> TextNotificationAction.builder()
				.text(dataNode.get("text").asText())
				.memberId(memberId)
				.flowId(memberId)
				.build();

			case ("exchange") -> ExchangeAction.builder()
				.memberId(memberId)
				.flowId(memberId)
				.currency(ExchangeRateTrigger.Currency.valueOf(dataNode.get("currency").asText()))
				.fromAccount(dataNode.get("from_account").asText())
				.amount(dataNode.get("amount").asLong())
				.build();

			case ("transfer") -> TransferAction.builder()
				.memberId(memberId)
				.flowId(memberId)
				.fromAccount(dataNode.get("from_account").asText())
				.toAccount(dataNode.get("to_account").asText())
				.amount(dataNode.get("amount").asLong())
				.build();

			default -> throw new BadRequestException(ErrorCode.INVALID_INPUT_VALUE);
		};
	}
}
