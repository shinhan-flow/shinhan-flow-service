package com.ssafy.shinhanflow.finance;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import reactor.core.publisher.Mono;

@RequiredArgsConstructor
@Service
public class FinanceService {
	@Value("${finance-api.key}")
	private String apiKey;

	@Value("${finance-api.base-url}")
	private String baseUrl;

	private final WebClient webClient;
	private final ObjectMapper objectMapper;

	private Mono<Map<String, Object>> get(String url) {
		return webClient.get().uri(url).retrieve().bodyToMono(String.class).map(response -> {
			try {
				return objectMapper.readValue(response, new TypeReference<Map<String, Object>>() {
				});
			} catch (JsonProcessingException e) {
				throw new RuntimeException(e);
			}
		});
	}

	private Mono<Map<String, Object>> post(String url, Map<String, Object> body) throws JsonProcessingException {
		body.put("apiKey", apiKey);
		return webClient.post()
			.uri(url)
			.contentType(MediaType.APPLICATION_JSON)
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
		String url = UriComponentsBuilder.fromHttpUrl(baseUrl).path("/member").toUriString();
		Map<String, Object> body = new HashMap<>();
		body.put("userId", userEmail);
		return post(url, body);
	}
}
