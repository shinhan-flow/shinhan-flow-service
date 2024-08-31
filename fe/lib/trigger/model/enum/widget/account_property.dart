enum AccountProperty {
  deposit('입금'),
  withdrawal('출금'),
  // transfer('이체'),
  balance('잔액');

  final String name;

  const AccountProperty(this.name);
}
