// ReadFavoriteData

class ReadFavoriteData {
  ReadFavoriteData({
    required this.id,
    required this.groupId,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.accuracy,
    required this.updated,
    required this.groupName,
  });

  final int id;
  final int groupId; // group code
  final String name;
  final double latitude;
  final double longitude;
  final double accuracy;
  final String updated;
  final String groupName;

  factory ReadFavoriteData.fromJson(Map<String, dynamic> json) => ReadFavoriteData(
    id: json["id"],
    groupId: json["groupId"],
    name: json["name"],
    latitude: json["latitude"].toDouble(),
    longitude: json["longitude"].toDouble(),
    accuracy: json["accuracy"].toDouble(),
    updated: json["updated"],
    groupName: json["groupName"],
  );

  Map<String, dynamic> toJson() => {
    // "id": id, // autoincrement field
    "groupId": groupId,
    "name": name,
    "latitude": latitude,
    "longitude": longitude,
    "accuracy": accuracy,
    "updated": updated,
    "groupName": groupName,
  };

  @override
  String toString() {
    return 'id: $id, group: ($groupId, $groupName), name: $name, latitude: $latitude, longitude: $longitude, accuracy: $accuracy, updated:$updated';
  }

} // class ReadFavoriteData

