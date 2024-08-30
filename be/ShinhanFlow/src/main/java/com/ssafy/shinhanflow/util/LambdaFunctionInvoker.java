package com.ssafy.shinhanflow.util;

import org.springframework.stereotype.Component;

import com.fasterxml.jackson.databind.JsonNode;
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

	public JsonNode invokeFunction(String functionName, String payload) {
		log.info("LambdaFunctionInvoker.invokeFunction - functionName: {}, payload: {}", functionName, payload);
		InvokeRequest invokeRequest = InvokeRequest.builder()
			.functionName(functionName)
			.payload(SdkBytes.fromUtf8String(payload))
			.build();

		InvokeResponse invokeResponse = lambdaClient.invoke(invokeRequest);
		log.info(invokeResponse.payload().asUtf8String());
		try {
			JsonNode jsonNode = objectMapper.readTree(
				invokeResponse.payload().asUtf8String());
			log.info(jsonNode.toString());
			// {"statusCode":200,"body":"{\"userId\":1,\"prompt\":\"test\"}"}
			return jsonNode.get("body");
		} catch (Exception e) {
			throw new RuntimeException("LambdaFunctionInvoker.invokeFunction - Failed to parse response body", e);
		}
	}
}
