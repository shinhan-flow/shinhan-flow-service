package com.ssafy.shinhanflow.util;

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
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositBalanceRequestDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositBalanceResponseDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositHolderRequestDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositHolderResponseDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositRequestDto;
import com.ssafy.shinhanflow.finance.dto.account.DemandDepositResponseDto;
import com.ssafy.shinhanflow.financeapi.dto.FinanceApiErrorBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import reactor.core.publisher.Mono;

@RequiredArgsConstructor
@Service
@Slf4j
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

	public MemberResponseDto createMember(MemberRequestDto memberRequestDto) {
		return fetch("/member", memberRequestDto, MemberResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 등록
	 */
	public DemandDepositResponseDto createDemandDepositAccount(
		DemandDepositRequestDto dto) {
		return fetch("/edu/demandDeposit/createDemandDepositAccount", dto,
			DemandDepositResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 예금주 확인
	 */
	public DemandDepositHolderResponseDto inquireDemandDepositAccountHolderName(
		DemandDepositHolderRequestDto dto) {
		return fetch("/edu/demandDeposit/inquireDemandDepositAccountHolderName", dto,
			DemandDepositHolderResponseDto.class);
	}

	/**
	 * 수시 입출금 계좌 잔액 조회
	 */
	public DemandDepositBalanceResponseDto inquireDemandDepositAccountBalance(DemandDepositBalanceRequestDto dto) {
		return fetch("/edu/demandDeposit/inquireDemandDepositAccountBalance", dto,
			DemandDepositBalanceResponseDto.class);
	}
}
