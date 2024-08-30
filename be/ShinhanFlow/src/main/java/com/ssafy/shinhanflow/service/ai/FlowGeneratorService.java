package com.ssafy.shinhanflow.service.ai;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.shinhanflow.dto.ai.FlowGeneratorLambdaFunctionRequestBodyDto;
import com.ssafy.shinhanflow.dto.ai.FlowGeneratorLambdaFunctionResponseBodyDto;
import com.ssafy.shinhanflow.dto.flow.CreateFlowRequestDto;
import com.ssafy.shinhanflow.util.LambdaFunctionInvoker;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
@RequiredArgsConstructor
public class FlowGeneratorService {
	@Value("${aws.lambda.function-name}")
	private String functionName;

	private final ObjectMapper objectMapper;
	private final LambdaFunctionInvoker lambdaFunctionInvoker;

	public CreateFlowRequestDto generateFlow(Long userId, String prompt) throws JsonProcessingException {
		log.info("FlowGeneratorService.generateFlow - userId: {}, prompt: {}", userId, prompt);
		FlowGeneratorLambdaFunctionRequestBodyDto flowGeneratorLambdaFunctionRequestBodyDto = FlowGeneratorLambdaFunctionRequestBodyDto.builder()
			.userId(userId)
			.prompt(prompt)
			.build();
		String payload = objectMapper.writeValueAsString(flowGeneratorLambdaFunctionRequestBodyDto);
		JsonNode responseBody = lambdaFunctionInvoker.invokeFunction(functionName, payload);
		log.info("====LambdaFunctionInvoker.generateFlow's responseBody====\n{}", responseBody.toString());

		FlowGeneratorLambdaFunctionResponseBodyDto flowGeneratorLambdaFunctionResponseBodyDto = objectMapper.treeToValue(
			responseBody, FlowGeneratorLambdaFunctionResponseBodyDto.class);

		log.info("flowGeneratorLambdaFunctionResponseBodyDto: {}",
			flowGeneratorLambdaFunctionResponseBodyDto.toString());
		return flowGeneratorLambdaFunctionResponseBodyDto.flow();
	}
}
