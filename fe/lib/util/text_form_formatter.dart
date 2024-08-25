import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NumberFormatter extends TextInputFormatter {
  NumberFormatter();

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // 아무 값이 없을 경우 (값을 지운경우) 지운 값을 그대로 설정
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    // 새로 입력된 값을 포멧
    final int parsedValue = int.parse(
        newValue.text); // NumberFormat은 숫자 값만 받을 수 있기 때문에 문자를 숫자로 먼저 변환
    final formatter =
        NumberFormat.decimalPattern(); // 천단위로 콤마를 표시하고 숫자 앞에 화폐 기호 표시하는 패턴 설정
    String newText = formatter.format(parsedValue); // 입력된 값을 지정한 패턴으로 포멧

    return newValue.copyWith(
        text: newText,
        selection:
            TextSelection.collapsed(offset: newText.length)); // 커서를 마지막으로 이동
  }
}
