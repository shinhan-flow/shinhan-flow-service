enum TriggerType {
  /// 트리거 타입
  /// 계좌
  BalanceTrigger, // 잔액
  DepositTrigger, // 입금
  TransferTrigger, // 이체
  WithDrawTrigger, // 출금

  /// 날짜
  /// 특정 날짜임을 확인하는 트리거 생성
  /// ex) "2024-08-11"
  SpecificDateTrigger,

  /// 특정 기간을 확인하는 트리거 생성
  /// ex) "2024-08-11"
  PeriodDateTrigger,

  /// 요일을 설정하는 트리거 생성
  /// ex) ["MON", "TUE", "WEN", "THU", "FRI", "SAT", "SUN"]
  DayOfWeekTrigger,

  /// 달마다 반복할 날짜 지정
  /// ex) [5, 10, 20]
  DayOfMonthTrigger,

  /// 특정 여러 날짜를 설정하는 트리거 생성
  /// ex) ["2024-08-11", "2024-08-15", "2024-08-17"]
  multiDate,

  /// 환율 트리거 생성
  /// ex) USD, EUR, JPY, CNY, GBP, CHF, CAD
  ExchangeRateTrigger,

  /// 예금, 적금, 대출 금융상품의 이자율 트리거
  /// DEPOSIT, SAVING, LOAN
  InterestRateTrigger,

  /// 특정 시간 트리거
  SpecificTimeTrigger,
}

extension TriggerExtension on TriggerType {
  bool isTimeType() {
    return TriggerType.PeriodDateTrigger == this ||
        TriggerType.SpecificDateTrigger == this ||
        TriggerType.DayOfMonthTrigger == this ||
        TriggerType.DayOfWeekTrigger == this;
  }

  bool isProductType() {
    return TriggerType.InterestRateTrigger == this;
  }

  bool isExchangeType() {
    return TriggerType.ExchangeRateTrigger == this;
  }

  bool isAccountType() {
    return TriggerType.BalanceTrigger == this ||
        TriggerType.DepositTrigger == this ||
        TriggerType.TransferTrigger == this ||
        TriggerType.WithDrawTrigger == this;
  }
}
