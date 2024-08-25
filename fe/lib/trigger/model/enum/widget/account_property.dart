enum AccountProperty {
  deposit('입금'),
  withdrawal('출금'),
  balance('잔액');

  final String name;

  const AccountProperty(this.name);
}
