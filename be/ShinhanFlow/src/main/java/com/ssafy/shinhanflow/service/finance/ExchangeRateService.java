package com.ssafy.shinhanflow.service.finance;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.repository.MemberRepository;
import com.ssafy.shinhanflow.util.FinanceApiHeaderGenerator;
import com.ssafy.shinhanflow.util.FinanceApiService;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@RequiredArgsConstructor
@Service
@Slf4j
public class ExchangeRateService {
	private final FinanceApiService financeApiFetcher;
	private final MemberRepository memberRepository;
	private final FinanceApiHeaderGenerator financeApiHeaderGenerator;
}
