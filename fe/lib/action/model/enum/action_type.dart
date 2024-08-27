enum ActionType {
  /// 액션 타입
  BalanceNotificationAction('잔액 알림'),
  ExchangeRateNotificationAction('환전 알림'),
  TextNotificationAction('사용자 알림'),
  ExchangeAction('환전'),
  TransferAction('송금');

  final String name;

  const ActionType(this.name);
}

extension ActionExtension on ActionType {
  bool isNotificationType() {
    return ActionType.BalanceNotificationAction == this ||
        ActionType.ExchangeRateNotificationAction == this ||
        ActionType.TextNotificationAction == this;
  }

  bool isTransferType() {
    return ActionType.TransferAction == this;
  }

  bool isExchangeType() {
    return ActionType.ExchangeAction == this;
  }
}
