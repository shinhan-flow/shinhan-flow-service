package com.ssafy.shinhanflow.jwt;

import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class JWTTestController {
	private final JWTUtil jwtUtil;

	@PostMapping("/api/v1/test")
	public String checkToken() {
		return "good";
	}
}
