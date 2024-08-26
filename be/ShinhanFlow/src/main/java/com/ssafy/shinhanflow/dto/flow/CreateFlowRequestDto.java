package com.ssafy.shinhanflow.dto.flow;

import java.util.List;

import com.ssafy.shinhanflow.domain.action.Action;
import com.ssafy.shinhanflow.domain.trigger.Trigger;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotBlank;
import jakarta.validation.constraints.NotEmpty;

public record CreateFlowRequestDto(
	@NotBlank
	String title,
	@NotBlank
	String description,

	@NotEmpty
	@Valid
	List<Trigger> triggers,

	@NotEmpty
	@Valid
	List<Action> actions
) {

}
