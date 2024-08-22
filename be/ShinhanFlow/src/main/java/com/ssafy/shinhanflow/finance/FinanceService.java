package com.ssafy.shinhanflow.finance;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.reactive.function.client.WebClient;

public class FinanceService {
	@Value("${financialApi.key}")
	private String apiKey;

	private final WebClient webClient;

	public FinanceService(WebClient webClient) {
		this.webClient = webClient;
	}

	private String fetch(String url, String body) {
		return webClient.post()
			.uri(url)
			.header("apiKey", apiKey)
			.bodyValue(body)
			.retrieve()
			.bodyToMono(String.class)
			.block();
	}

	public String createMember(String userEmail) {
		String url = "https://finopenapi.ssafy.io/ssafy/api/v1/member/";
		String body = "{\"email\":\"" + userEmail + "\"}";
		return fetch(url, body);
	}
}
