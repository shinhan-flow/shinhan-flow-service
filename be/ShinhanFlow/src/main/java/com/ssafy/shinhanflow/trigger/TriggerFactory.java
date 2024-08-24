package com.ssafy.shinhanflow.trigger;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ssafy.shinhanflow.trigger.account.BalanceTrigger;
import com.ssafy.shinhanflow.trigger.account.DepositTrigger;
import com.ssafy.shinhanflow.trigger.account.TransferTrigger;
import com.ssafy.shinhanflow.trigger.account.WithDrawTrigger;
import com.ssafy.shinhanflow.trigger.date.*;
import com.ssafy.shinhanflow.trigger.exchange.ExchangeRateTrigger;
import com.ssafy.shinhanflow.trigger.product.InterestRateTrigger;
import com.ssafy.shinhanflow.trigger.time.SpecificTimeTrigger;

import java.time.DayOfWeek;
import java.time.LocalDate;
import java.time.LocalTime;
import java.util.*;

public class TriggerFactory {

    private final ObjectMapper objectMapper = new ObjectMapper();

    public Trigger getTrigger(Long memberId, String code, String jsonData) throws JsonProcessingException {

        JsonNode dataNode = objectMapper.readTree(jsonData);

        return switch (code) {
            // todo: 계좌가 유효한지? 내 계좌가 맞는지?
            // 잔액을 확인하는 트리거 생성
            case ("balance") -> new BalanceTrigger(
                    dataNode.get("account").asText(),
                    dataNode.get("balance").asLong(),
                    BalanceTrigger.Condition.valueOf(dataNode.get("condition").asText())
            );

            // todo: 계좌가 유효한지? 내 계좌가 맞는지?
            // 입금을 확인하는 트리거 생성
            case ("deposit") -> new DepositTrigger(
                    dataNode.get("account").asText(),
                    dataNode.get("amount").asLong()
            );

            // todo: 계좌가 유효한지? 내 계좌가 맞는지? 받는 사람의 계좌도 확인
            // 이체를 확인하는 트리거 생성
            case ("transfer") -> new TransferTrigger(
                    dataNode.get("from_account").asText(),
                    dataNode.get("to_account").asText(),
                    dataNode.get("amount").asLong()
            );

            // todo: 계좌가 유효한지? 내 계좌가 맞는지?
            // 출금을 확인하는 트리거 생성
            case ("withdraw") -> new WithDrawTrigger(
                    dataNode.get("account").asText(),
                    dataNode.get("amount").asLong()
            );


            // 특정 날짜임을 확인하는 트리거 생성
            // ex) "2024-08-11"
            case ("specificDate") -> new SpecificDateTrigger(
                    LocalDate.parse(dataNode.get("date").asText())
            );

            // 특정 기간을 확인하는 트리거 생성
            // ex) "2024-08-11"
            case ("periodDate") -> new PeriodDateTrigger(
                    LocalDate.parse(dataNode.get("start_date").asText()),
                    LocalDate.parse(dataNode.get("end_date").asText())
            );

            // 요일을 설정하는 트리거 생성
            // ex) ["MON", "TUE", "WEN", "THU", "FRI", "SAT", "SUN"]
            case ("dayOfWeek") -> {
                Set<DayOfWeek> daysOfWeek = EnumSet.noneOf(DayOfWeek.class);
                Iterator<JsonNode> elements = dataNode.get("day_of_week").elements();
                while (elements.hasNext()) {
                    String day = elements.next().asText();
                    daysOfWeek.add(DayOfWeek.valueOf(day));
                }

                yield new DayOfWeekTrigger(daysOfWeek);
            }

            // 달마다 반복할 날짜 지정
            // ex) [5, 10, 20]
            case("dayOfMonth") -> {
                Set<Integer> days = new HashSet<>();
                Iterator<JsonNode> elements = dataNode.get("day_of_month").elements();
                while (elements.hasNext()) {
                    String day = elements.next().asText();
                    days.add(Integer.parseInt(day));
                }
                yield new DayOfMonthTrigger(days);
            }

            // 특정 여러 날짜를 설정하는 트리거 생성
            // ex) ["2024-08-11", "2024-08-15", "2024-08-17"]
            case ("multiDate") -> {
                Set<LocalDate> dates = new HashSet<>();
                Iterator<JsonNode> elements = dataNode.get("dates").elements();
                while (elements.hasNext()) {
                    String date = elements.next().asText();
                    dates.add(LocalDate.parse(date));
                }
                yield new MultiDateTrigger(dates);
            }

            // 환율 트리거 생성
            // ex) USD, EUR, JPY, CNY, GBP, CHF, CAD
            case ("exchangeRate") -> new ExchangeRateTrigger(
                    ExchangeRateTrigger.Currency.valueOf(dataNode.get("currency").asText()),
                    dataNode.get("ex_rate").decimalValue()
            );

            // 예금, 적금, 대출 금융상품의 이자율 트리거
            // ex) DEPOSIT, SAVING, LOAN
            case ("interestRate") -> new InterestRateTrigger(
                    InterestRateTrigger.Product.valueOf(dataNode.get("product").asText()),
                    dataNode.get("interest_rate").decimalValue()
            );

            // 특정 시간 트리거
            case ("specificTime") -> new SpecificTimeTrigger(
                    LocalTime.parse(dataNode.get("specific_time").asText())
            );

            default -> throw new IllegalStateException("Unexpected value: " + code);
        };

    }
}
