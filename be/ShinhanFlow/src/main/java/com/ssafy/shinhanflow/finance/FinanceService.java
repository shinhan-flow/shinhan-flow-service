package com.ssafy.shinhanflow.finance;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.shinhanflow.finance.dto.FinanceApiRequestDto;
import com.ssafy.shinhanflow.finance.dto.FinanceApiResponseDto;
import com.ssafy.shinhanflow.finance.dto.MemberRequestDto;
import com.ssafy.shinhanflow.finance.dto.MemberResponseDto;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class FinanceService {
	@Value("${finance-api.key}")
	private String apiKey;

	@Value("${finance-api.base-url}")
	private String baseUrl;

	private final WebClient webClient;
	private final ObjectMapper objectMapper;

	private <T extends FinanceApiResponseDto> T fetch(String urlPath, FinanceApiRequestDto financeApiRequestDto,
		Class<T> responseType) throws JsonProcessingException {
		financeApiRequestDto.setApiKey(apiKey);
		return webClient.post()
			.uri(UriComponentsBuilder.fromHttpUrl(baseUrl).path(urlPath).toUriString())
			.contentType(MediaType.APPLICATION_JSON)
			.bodyValue(objectMapper.writeValueAsString(financeApiRequestDto))
			.retrieve()
			.bodyToMono(responseType)
			.block();
	}

	public MemberResponseDto createMember(MemberRequestDto memberRequestDto) throws JsonProcessingException {
		return fetch("member", memberRequestDto, MemberResponseDto.class);
	}
}
