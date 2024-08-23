package com.ssafy.shinhanflow.finance;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.reactive.function.client.WebClient;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import reactor.core.publisher.Mono;

@RequiredArgsConstructor
public class FinanceService {
	@Value("${financeApi.key}")
	private String apiKey;

	private final WebClient webClient;
	private final ObjectMapper objectMapper;

	private Mono<Map<String, Object>> fetch(String url, Map<String, Object> body) throws JsonProcessingException {
		body.put("apiKey", apiKey);
		return webClient.post()
			.uri(url)
			.bodyValue(objectMapper.writeValueAsString(body))
			.retrieve()
			.bodyToMono(String.class)
			.map(response -> {
				try {
					return objectMapper.readValue(response, new TypeReference<Map<String, Object>>() {
					});
				} catch (Exception e) {
					throw new RuntimeException("Failed to parse JSON to Map", e);
				}
			});
	}

	public Mono<Map<String, Object>> createMember(String userEmail) throws JsonProcessingException {
		String url = "https://finopenapi.ssafy.io/ssafy/api/v1/member/";
		Map<String, Object> body = new HashMap<>();
		body.put("userId", userEmail);
		return fetch(url, body);
	}
}
