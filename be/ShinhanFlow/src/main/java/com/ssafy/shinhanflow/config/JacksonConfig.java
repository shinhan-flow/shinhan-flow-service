package com.ssafy.shinhanflow.config;

import java.math.BigDecimal;

import org.springframework.boot.autoconfigure.jackson.Jackson2ObjectMapperBuilderCustomizer;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

import com.fasterxml.jackson.databind.module.SimpleModule;
import com.ssafy.shinhanflow.util.CustomBigDecimalDeserializer;

// @Configuration
// public class JacksonConfig {
//
// 	@Bean
// 	public Jackson2ObjectMapperBuilderCustomizer customizer() {
// 		return new Jackson2ObjectMapperBuilderCustomizer() {
// 			@Override
// 			public void customize(Jackson2ObjectMapperBuilder jacksonObjectMapperBuilder) {
// 				SimpleModule module = new SimpleModule();
// 				module.addDeserializer(BigDecimal.class, new CustomBigDecimalComponent.Deserializer());
// 				jacksonObjectMapperBuilder.modules(module);
// 			}
// 		};
// 	}
// }

@Configuration
public class JacksonConfig {

	@Bean
	public Jackson2ObjectMapperBuilderCustomizer customizer() {
		return jacksonObjectMapperBuilder -> {
			SimpleModule module = new SimpleModule();
			module.addDeserializer(BigDecimal.class, new CustomBigDecimalDeserializer());
			jacksonObjectMapperBuilder.modules(module);
		};
	}
}
