

class FavoriteData {
  FavoriteData({
    required this.id,
    required this.gId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    this.updated,
  });

  final int id;
  final int gId;
  final String name;
  final double latitude;
  final double longitude;
  final double accuracy;
  final String? updated;

  factory FavoriteData.fromJson(Map<String, dynamic> json) => FavoriteData(
    id: json["id"],
    gId: json["gId"],
    name: json["name"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    accuracy: json["accuracy"].toDouble(),
    updated: json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "gId": gId,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
    "accuracy": accuracy,
    "updated": updated,
  };
}
