enum FlowType {
  /// 트리거 타입
  /// 계좌
  balance,
  deposit,
  transfer,
  withdraw,

  /// 날짜
  /// 특정 날짜임을 확인하는 트리거 생성
  /// ex) "2024-08-11"
  specificDate,

  /// 특정 기간을 확인하는 트리거 생성
  /// ex) "2024-08-11"
  periodDate,

  /// 요일을 설정하는 트리거 생성
  /// ex) ["MON", "TUE", "WEN", "THU", "FRI", "SAT", "SUN"]
  dayOfWeek,

  /// 달마다 반복할 날짜 지정
  /// ex) [5, 10, 20]
  dayOfMonth,

  /// 특정 여러 날짜를 설정하는 트리거 생성
  /// ex) ["2024-08-11", "2024-08-15", "2024-08-17"]
  multiDate,

  /// 환율 트리거 생성
  /// ex) USD, EUR, JPY, CNY, GBP, CHF, CAD
  exchangeRate,

  /// 예금, 적금, 대출 금융상품의 이자율 트리거
  /// DEPOSIT, SAVING, LOAN
  interestRate,

  /// 특정 시간 트리거
  specificTime;
}
// specificDate,
//
// /// 특정 기간을 확인하는 트리거 생성
// /// ex) "2024-08-11"
// periodDate,
//
// /// 요일을 설정하는 트리거 생성
// /// ex) ["MON", "TUE", "WEN", "THU", "FRI", "SAT", "SUN"]
// dayOfWeek,
//
// dayOfMonth,

extension FlowExtension on FlowType {
  bool isTimeType() {
    return FlowType.periodDate == this ||
        FlowType.specificDate == this ||
        FlowType.dayOfMonth == this ||
        FlowType.dayOfWeek == this;
  }

  bool isProductType() {
    return FlowType.interestRate == this;
  }

  bool isExchangeType() {
    return FlowType.exchangeRate == this;
  }
}
