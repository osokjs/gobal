class PositionData {
double latitude = 0.0;
double longitude = 0.0;
double accuracy = 0.0;
double bearing = 0.0;

PositionData({
  this.latitude = 0.0,
  this.longitude = 0.0,
  this.accuracy = 0.0,
  this.bearing = 0.0,
});

@override
  String toString() {
  return '정확도: $accuracy, 위도: $latitude, 경도: $longitude';
}
}