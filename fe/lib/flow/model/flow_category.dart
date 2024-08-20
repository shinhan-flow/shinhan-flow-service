enum FlowCategoryType {
  time('시간'),
  price('금액'),
  exRate('환율'),
  product('상품');
  final String name;
  const FlowCategoryType(this.name);

}
