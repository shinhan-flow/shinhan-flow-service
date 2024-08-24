package com.ssafy.shinhanflow.financeapi.dto;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Getter;
import lombok.NoArgsConstructor;

@Getter
@NoArgsConstructor
public class FinanceApiErrorBody {
	@JsonProperty("Header")
	private Header header;

	@Getter
	@NoArgsConstructor
	public static class Header {
		private String responseCode;
		private String responseMessage;
	}
}