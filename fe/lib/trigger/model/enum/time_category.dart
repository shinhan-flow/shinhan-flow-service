enum TimeCategory {
  normal('일반'),
  period('기간'),
  iterate('반복'),
  // multi('다중')
  ;

  final String name;

  const TimeCategory(this.name);
}

enum DayOfWeek {
  MON('월'),
  TUE('화'),
  WEN('수'),
  THU('목'),
  FRI('금'),
  SAT('토'),
  SUN('일');

  final String name;
  const DayOfWeek(this.name);
}
