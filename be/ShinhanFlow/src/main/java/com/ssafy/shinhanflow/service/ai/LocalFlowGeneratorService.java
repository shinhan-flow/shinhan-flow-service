package com.ssafy.shinhanflow.service.ai;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.shinhanflow.dto.flow.CreateFlowRequestDto;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class LocalFlowGeneratorService {
	// @Value("${openai.api-key}")
	// private String apiKey;
	@Value("${server-url}")
	private String serverUrl;

	private final WebClient webClient;
	private final ObjectMapper objectMapper;

	public CreateFlowRequestDto generateFlow(Long userId, String prompt) {
		return webClient.post()
			.uri(serverUrl)
			.contentType(MediaType.APPLICATION_JSON)
			.bodyValue("{\"input_string\": \"%s\"}".formatted(prompt))
			.retrieve()
			.bodyToMono(CreateFlowRequestDto.class)
			.block();
	}
}
