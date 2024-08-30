import 'package:intl/intl.dart';

const String assetPathIcon = 'assets/images';

class AssetUtil {
  static String getAssetPath({required String name, String extension = 'svg'}) {
    return '$assetPathIcon/$name.$extension';
  }
}


class FormatUtil{
  static String formatNumber(int num){
    return NumberFormat('#,###').format(num);
  }
  static String formatDouble(double num){
    return NumberFormat('#,###').format(num);
  }
  static String formatTime(String time) {
    // "010539"을 "01:05:39"로 포맷팅
    return '${time.substring(0, 2)}:${time.substring(2, 4)}:${time.substring(4, 6)}';
  }
  static String formatDate(String date) {
    // "20240829"을 "2024-08-29"로 포맷팅
    return '${date.substring(0, 4)}-${date.substring(4, 6)}-${date.substring(6, 8)}';
  }
}
