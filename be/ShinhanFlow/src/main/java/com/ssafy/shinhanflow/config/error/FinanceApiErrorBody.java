package com.ssafy.shinhanflow.config.error;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class FinanceApiErrorBody {
	// Header API가 아닌 경우
	private String responseCode;
	private String responseMessage;

	// Header API인 경우
	@JsonProperty("Header")
	private Header header;

	@Getter
	@NoArgsConstructor
	public static class Header {
		private String responseCode;
		private String responseMessage;
	}
}