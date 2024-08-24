const String assetPathIcon = 'assets/images';

class AssetUtil {
  static String getAssetPath({required String name, String extension = 'svg'}) {
    return '$assetPathIcon/$name.$extension';
  }
}
