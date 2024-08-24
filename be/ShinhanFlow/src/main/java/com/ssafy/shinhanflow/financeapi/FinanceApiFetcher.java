package com.ssafy.shinhanflow.financeapi;

import static com.ssafy.shinhanflow.config.error.ErrorCode.INTERNAL_SERVER_ERROR;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.HttpStatusCode;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Service;
import org.springframework.web.reactive.function.client.WebClient;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.shinhanflow.config.error.exception.BusinessBaseException;
import com.ssafy.shinhanflow.config.error.exception.FinanceApiException;
import com.ssafy.shinhanflow.finance.dto.FinanceApiRequestDto;
import com.ssafy.shinhanflow.finance.dto.FinanceApiResponseDto;
import com.ssafy.shinhanflow.finance.dto.MemberRequestDto;
import com.ssafy.shinhanflow.finance.dto.MemberResponseDto;
import com.ssafy.shinhanflow.financeapi.dto.FinanceApiErrorBody;

import lombok.RequiredArgsConstructor;
import reactor.core.publisher.Mono;

@RequiredArgsConstructor
@Service
public class FinanceApiFetcher {
	@Value("${finance-api.key}")
	private String apiKey;

	@Value("${finance-api.base-url}")
	private String baseUrl;

	private final WebClient webClient;
	private final ObjectMapper objectMapper;

	private <T extends FinanceApiResponseDto> T fetch(String urlPath, FinanceApiRequestDto financeApiRequestDto,
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

	public MemberResponseDto createMember(MemberRequestDto memberRequestDto) {
		return fetch("member", memberRequestDto, MemberResponseDto.class);
	}
}
