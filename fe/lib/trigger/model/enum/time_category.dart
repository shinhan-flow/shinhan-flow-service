enum TimeCategory {
  normal('하루'),
  period('기간'),
  iterate('반복'),
  // multi('다중')
  ;

  final String name;

  const TimeCategory(this.name);
}

enum DayOfWeek {
  MONDAY('월'),
  TUESDAY('화'),
  WEDNESDAY('수'),
  THURSDAY('목'),
  FRIDAY('금'),
  SATURDAY('토'),
  SUNDAY('일');

  final String name;

  const DayOfWeek(this.name);
}
