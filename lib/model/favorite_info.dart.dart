// To parse this JSON data, do
//
//     final favoriteInfo = favoriteInfoFromJson(jsonString);


class FavoriteInfo {
  FavoriteInfo({
    required this.id,
    required this.name,
    required this.distance,
    required this.category,
    required this.info,
  });

  final int id;
  final String name;
  final double distance;
  final String category;
  final String info; // 출력용 메시지 문자열
}
