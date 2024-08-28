package com.ssafy.shinhanflow.config.error;

import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.Value;

@Value
public class FinanceApiErrorBody {
	// Header API가 아닌 경우
	String responseCode;
	String responseMessage;

	// Header API인 경우
	@JsonProperty("Header")
	Header header;

	public record Header(String responseCode, String responseMessage) {
	}

	@Override
	public String toString() {
		if (this.header != null) {
			return "FinanceApiErrorBody{" +
				"header={" +
				"responseCode=" + header.responseCode() + '\'' +
				"responseMessage=" + header.responseMessage() + '\'' +
				'}';
		} else {
			return "FinanceApiErrorBody{" +
				"responseCode='" + responseCode + '\'' +
				", responseMessage='" + responseMessage + '\'' +
				'}';
		}
	}
}