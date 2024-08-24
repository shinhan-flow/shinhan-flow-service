enum ForeignCurrencyCategory {
  USD('미국(달러)'),
  EUR('유럽연합(유로)'),
  JPY('일본(엔화)'),
  CNY('중국(위안화)'),
  GBP('영국(파운드)'),
  CHF('스위스(프랑)'),
  CAD('캐나다(달러)');

  final String displayName;

  const ForeignCurrencyCategory(this.displayName);


  static ForeignCurrencyCategory stringToEnum({required String value}) {
    return ForeignCurrencyCategory.values.firstWhere((e) => e.displayName == value);
  }
}
