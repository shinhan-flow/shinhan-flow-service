package com.ssafy.shinhanflow.util;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Random;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

import com.ssafy.shinhanflow.dto.finance.header.RequestHeaderDto;

import lombok.extern.slf4j.Slf4j;

@Component
@Slf4j
public class FinanceApiHeaderGenerator {
	@Value("${finance-api.key}")
	private String apiKey;

	public RequestHeaderDto createHeader(String apiName, String userKey, String institutionCode) {
		LocalDateTime now = LocalDateTime.now();
		log.info("FinanceApiHeaderGenerator - createHeader 호출");
		log.info("now: {}", now);

		String datePart = now.format(DateTimeFormatter.ofPattern("yyyyMMdd"));
		String timePart = now.format(DateTimeFormatter.ofPattern("HHmmss"));
		Random random = new Random();
		int randomNumber = random.nextInt(1000000);
		String formattedNumber = String.format("%06d", randomNumber);

		log.info("institutionTransactionUniqueNo: {}", datePart + timePart + formattedNumber);
		log.info("datePart: {}", datePart);
		log.info("timePart: {}", timePart);
		log.info("formattedNumber: {}", formattedNumber);

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
