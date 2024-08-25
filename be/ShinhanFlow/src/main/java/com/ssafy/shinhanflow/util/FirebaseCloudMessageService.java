package com.ssafy.shinhanflow.util;

import java.util.Optional;

import org.springframework.stereotype.Service;

import com.google.firebase.messaging.FirebaseMessaging;
import com.google.firebase.messaging.FirebaseMessagingException;
import com.google.firebase.messaging.Message;
import com.google.firebase.messaging.Notification;
import com.ssafy.shinhanflow.auth.repository.MemberRepository;
import com.ssafy.shinhanflow.config.error.ErrorCode;
import com.ssafy.shinhanflow.config.error.exception.NotFoundException;
import com.ssafy.shinhanflow.entity.MemberEntity;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class FirebaseCloudMessageService {
	private final MemberRepository memberRepository;

	public String sendMessage(FcmMessageRequestDto requestDto) {

		Optional<MemberEntity> member = memberRepository.findById(requestDto.memberId());
		if (member.isEmpty()) {
			throw new NotFoundException(ErrorCode.NOT_FOUND);
		}

		String userFirebaseToken = member.get().getFcmToken();
		if (userFirebaseToken == null) {
			throw new NotFoundException((ErrorCode.NOT_FOUND));
		}

		Message message = Message.builder()
			.setNotification(Notification.builder()
				.setTitle(requestDto.title())
				.setBody(requestDto.content())
				.build())
			.setToken(userFirebaseToken).
			build();

		try {
			String response = FirebaseMessaging.getInstance().send(message);
			return "Message sent successfully: " + response;
		} catch (FirebaseMessagingException e) {
			e.printStackTrace();
			return e.getMessage();
		}
	}
}
