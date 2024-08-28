enum BankType {
  bankOfKorea('001', '한국은행'),
  koreaDevelopmentBank('002', '산업은행'),
  industrialBankOfKorea('003', '기업은행'),
  kookminBank('004', '국민은행'),
  nonghyupBank('011', '농협은행'),
  wooriBank('020', '우리은행'),
  scFirstBank('023', 'SC제일은행'),
  cityBank('027', '시티은행'),
  daeguBank('032', '대구은행'),
  gwangjuBank('034', '광주은행'),
  bankOfJeju('035', '제주은행'),
  jeonbukBank('037', '전북은행'),
  bankOfGyeongsang('039', '경남은행'),
  saemaulGeumgo('045', '새마을금고'),
  kebHanaBank('081', 'KEB하나은행'),
  shinhanBank('088', '신한은행'),
  kakaoBank('090', '카카오뱅크'),
  saffyBank('999', '싸피은행'),
  ;

  final String bankCode;
  final String bankName;

  const BankType(this.bankCode, this.bankName);
}
