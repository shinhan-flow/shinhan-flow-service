package com.ssafy.shinhanflow.service.flow;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.dto.FcmMessageRequestDto;
import com.ssafy.shinhanflow.util.FirebaseCloudMessageService;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class FinanceActionService {
	private final FirebaseCloudMessageService fcmService;

	public void sendTextNotification(Long memberId, String text) {

		fcmService.sendMessage(FcmMessageRequestDto.builder()
			.memberId(memberId)
			.title("플로우 알림")
			.content(text)
			.build());
	}

}
