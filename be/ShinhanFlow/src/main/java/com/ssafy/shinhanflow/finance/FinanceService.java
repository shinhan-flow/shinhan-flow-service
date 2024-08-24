package com.ssafy.shinhanflow.finance;

import org.springframework.stereotype.Service;

import com.ssafy.shinhanflow.financeapi.FinanceApiFetcher;

import lombok.RequiredArgsConstructor;

@RequiredArgsConstructor
@Service
public class FinanceService {
	private final FinanceApiFetcher financeApiFetcher;
}
