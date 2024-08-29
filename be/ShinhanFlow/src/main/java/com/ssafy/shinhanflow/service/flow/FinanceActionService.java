package com.ssafy.shinhanflow.service.flow;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.util.FirebaseCloudMessageService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FinanceActionService {
	private final FirebaseCloudMessageService fcmService;

}
