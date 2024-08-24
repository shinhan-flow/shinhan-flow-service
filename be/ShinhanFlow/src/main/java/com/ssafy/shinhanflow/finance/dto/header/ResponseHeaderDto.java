package com.ssafy.shinhanflow.finance.dto.header;

import lombok.Data;

@Data
public class ResponseHeaderDto {
	private String responseCode;
	private String responseMessage;
	private String apiName;
	private String transmissionDate;
	private String transmissionTime;
	private String institutionCode;
	private String apiKey;
	private String apiServiceCode;
	private String institutionTransactionUniqueNo;
}
