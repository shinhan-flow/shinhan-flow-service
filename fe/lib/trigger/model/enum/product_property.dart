enum AccountProductType {
  // CURRENT_ACCOUNT('입출금'),
  DEPOSIT_ACCOUNT('예금'),
  SAVING_ACCOUNT('적금'),
  LOAN_ACCOUNT('대출');

  final String name;

  const AccountProductType(this.name);
}
