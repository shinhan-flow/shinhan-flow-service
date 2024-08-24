package com.ssafy.shinhanflow.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.ssafy.shinhanflow.finance.dto.header.RequestHeaderDto;

@Component
public class FinanceApiHeaderGenerator {
	@Value("${finance-api.key}")
	private String apiKey;

	public RequestHeaderDto createHeader(String apiName, String userKey, String institutionCode) {
		LocalDateTime now = LocalDateTime.now();
		String datePart = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		String timePart = now.format(DateTimeFormatter.ofPattern("HHmmss"));
		Random random = new Random();
		int randomNumber = random.nextInt(1000000);
		String formattedNumber = String.format("%06d", randomNumber);

		return RequestHeaderDto.builder()
			.apiName(apiName)
			.transmissionDate(datePart)
			.transmissionTime(timePart)
			.institutionCode(institutionCode)
			.fintechAppNo("001")
			.apiServiceCode(apiName)
			.institutionTransactionUniqueNo(datePart + timePart + formattedNumber)
			.apiKey(apiKey)
			.userKey(userKey)
			.build();
	}
}
