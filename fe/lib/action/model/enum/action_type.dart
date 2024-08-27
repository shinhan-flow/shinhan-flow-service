enum ActionType {
  /// 액션 타입
  balanceNotification('잔액 알림'),
  exchangeRateNotification('환전 알림'),
  textNotification('사용자 알림'),
  exchange('환전'),
  transfer('송금');

  final String name;

  const ActionType(this.name);
}

extension ActionExtension on ActionType {
  bool isNotificationType() {
    return ActionType.balanceNotification == this ||
        ActionType.exchangeRateNotification == this ||
        ActionType.textNotification == this;
  }
}
