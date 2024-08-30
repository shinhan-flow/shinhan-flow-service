enum BankType {
  bankOfKorea('001', '한국은행', 'korea'),
  koreaDevelopmentBank('002', '산업은행', 'kdb'),
  industrialBankOfKorea('003', '기업은행', 'ibk'),
  kookminBank('004', '국민은행', 'kb'),
  nonghyupBank('011', '농협은행', 'NH농협'),
  wooriBank('020', '우리은행', 'woori'),
  scFirstBank('023', 'SC제일은행', 'scjeil'),
  cityBank('027', '시티은행', 'citi'),
  daeguBank('032', '대구은행', 'dgb'),
  gwangjuBank('034', '광주은행', 'junbook'),
  bankOfJeju('035', '제주은행', 'shinhan'),
  jeonbukBank('037', '전북은행', 'junbook'),
  bankOfGyeongsang('039', '경남은행', 'bnk'),
  saemaulGeumgo('045', '새마을금고', 'saemaulGeumgo'),
  kebHanaBank('081', 'KEB하나은행', 'hana'),
  shinhanBank('088', '신한은행', 'shinhan'),
  kakaoBank('090', '카카오뱅크', 'kakao'),
  saffyBank('999', '싸피은행', 'ssafy'),
  ;

  final String bankCode;
  final String bankName;
  final String img;

  const BankType(this.bankCode, this.bankName, this.img);
}
