package com.ssafy.shinhanflow.flow.action;

import lombok.Builder;

@Builder
public record TransferAction(

	Long memberId,
	Long flowId,
	String fromAccount,
	String toAccount,
	Long amount

) implements Action {

	@Override
	public boolean execute() {
		return false;
	}
}
