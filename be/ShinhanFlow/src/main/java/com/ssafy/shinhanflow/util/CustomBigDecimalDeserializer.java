package com.ssafy.shinhanflow.util;

import java.io.IOException;
import java.math.BigDecimal;

import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationContext;
import com.fasterxml.jackson.databind.JsonDeserializer;

public class CustomBigDecimalDeserializer extends JsonDeserializer<BigDecimal> {
	@Override
	public BigDecimal deserialize(JsonParser p, DeserializationContext ctxt) throws IOException {
		String str = p.getText();
		str = str.replaceAll(",", ""); // Remove commas
		return new BigDecimal(str);
	}
}
