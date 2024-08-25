package com.ssafy.shinhanflow.util;

import static com.ssafy.shinhanflow.config.error.ErrorCode.*;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.MediaType;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.shinhanflow.config.error.FinanceApiErrorBody;
import com.ssafy.shinhanflow.config.error.exception.BusinessBaseException;
import com.ssafy.shinhanflow.config.error.exception.FinanceApiException;
import com.ssafy.shinhanflow.dto.finance.FinanceApiRequestDto;
import com.ssafy.shinhanflow.dto.finance.FinanceApiResponseDto;

import lombok.RequiredArgsConstructor;
import reactor.core.publisher.Mono;

@RequiredArgsConstructor
public class FinanceApiFetcher {
	@Value("${finance-api.key}")
	private String apiKey;

	@Value("${finance-api.base-url}")
	private String baseUrl;

	private final WebClient webClient;
	private final ObjectMapper objectMapper;

	public <T extends FinanceApiResponseDto> T fetch(String urlPath, FinanceApiRequestDto financeApiRequestDto,
		Class<T> responseType) {
		WebClient.ResponseSpec response;

		try {
			response = webClient.post()
				.uri(UriComponentsBuilder.fromHttpUrl(baseUrl).path(urlPath).toUriString())
				.contentType(MediaType.APPLICATION_JSON)
				.bodyValue(objectMapper.writeValueAsString(financeApiRequestDto))
				.retrieve()
				.onStatus(HttpStatusCode::is4xxClientError, clientResponse -> {
					if (clientResponse.statusCode() == HttpStatus.BAD_REQUEST) {
						return clientResponse.bodyToMono(FinanceApiErrorBody.class)
							.flatMap(errorBody -> {

								FinanceApiErrorBody.Header header = errorBody.getHeader();
								if (header == null) {
									throw new FinanceApiException(errorBody.getResponseCode(),
										errorBody.getResponseMessage());
								}
								throw new FinanceApiException(header.getResponseCode(), header.getResponseMessage());
							});
					}
					return clientResponse.createException().flatMap(Mono::error);
				});
			return response.bodyToMono(responseType).block();
		} catch (JsonProcessingException e) {
			throw new BusinessBaseException("Failed to serialize request", INTERNAL_SERVER_ERROR);
		}
	}
}
