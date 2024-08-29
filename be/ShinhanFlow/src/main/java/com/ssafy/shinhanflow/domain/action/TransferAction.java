package com.ssafy.shinhanflow.domain.action;

import com.ssafy.shinhanflow.service.flow.FlowActionService;

import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.constraints.Positive;
import lombok.Builder;

@Builder
public record TransferAction(
	@NotBlank
	String fromAccount,
	@NotBlank
	String toAccount,
	@NotNull
	@Positive
	Long amount

) implements Action {

	@Override
	public boolean execute(FlowActionService flowActionService) {
		return false;
	}
}
