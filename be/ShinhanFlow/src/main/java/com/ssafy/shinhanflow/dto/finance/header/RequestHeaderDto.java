package com.ssafy.shinhanflow.dto.finance.header;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class RequestHeaderDto {
	private String apiName;
	private String transmissionDate;
	private String transmissionTime;
	private String institutionCode;
	private String fintechAppNo;
	private String apiServiceCode;
	private String institutionTransactionUniqueNo;
	private String apiKey;
	private String userKey;
}
