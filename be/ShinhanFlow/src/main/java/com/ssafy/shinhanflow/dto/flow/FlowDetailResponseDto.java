package com.ssafy.shinhanflow.dto.flow;

import java.util.List;

import com.ssafy.shinhanflow.domain.action.Action;
import com.ssafy.shinhanflow.domain.trigger.Trigger;

import jakarta.validation.Valid;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import lombok.Builder;

@Builder
public record FlowDetailResponseDto(
	@NotNull
	Long id,
	@NotNull
	String title,
	@NotNull
	String description,
	@NotEmpty
	@Valid
	List<Trigger> triggers,
	@NotEmpty
	@Valid
	List<Action> actions

) {

}
