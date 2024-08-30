package com.ssafy.shinhanflow.util;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Component;

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
	@Value("${aws.lambda.function-name}")
	private String functionName;

	private final LambdaClient lambdaClient;

	public String invokeFunction(String payload) {
		InvokeRequest invokeRequest = InvokeRequest.builder()
			.functionName(functionName)
			.payload(SdkBytes.fromUtf8String(payload))
			.build();

		InvokeResponse invokeResponse = lambdaClient.invoke(invokeRequest);
		return invokeResponse.payload().asUtf8String();
	}
}
