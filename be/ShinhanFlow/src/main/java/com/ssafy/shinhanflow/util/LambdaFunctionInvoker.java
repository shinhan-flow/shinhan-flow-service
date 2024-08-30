package com.ssafy.shinhanflow.util;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import software.amazon.awssdk.core.SdkBytes;
import software.amazon.awssdk.services.lambda.LambdaClient;
import software.amazon.awssdk.services.lambda.model.InvokeRequest;
import software.amazon.awssdk.services.lambda.model.InvokeResponse;

@Slf4j
@Component
@RequiredArgsConstructor
public class LambdaFunctionInvoker {
	private final LambdaClient lambdaClient;
	private final ObjectMapper objectMapper;

	public String invokeFunction(String functionName, String payload) {
		log.info("LambdaFunctionInvoker.invokeFunction - functionName: {}, payload: {}", functionName, payload);
		InvokeRequest invokeRequest = InvokeRequest.builder()
			.functionName(functionName)
			.payload(SdkBytes.fromUtf8String(payload))
			.build();

		InvokeResponse invokeResponse = lambdaClient.invoke(invokeRequest);
		return getInvokeResponseBody(invokeResponse.payload().asUtf8String());
	}

	private String getInvokeResponseBody(String invokeResponseString) {
		try {
			return objectMapper.readTree(invokeResponseString).get("body").asText();
		} catch (Exception e) {
			throw new RuntimeException("LambdaFunctionInvoker.getInvokeResponseBody - Failed to parse response body",
				e);
		}
	}
}
