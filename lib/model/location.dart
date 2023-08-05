class LocationResponse {
  final String date;
  final String message;
  final int status;
  final List<LocationData> data;

  LocationResponse({
    required this.date,
    required this.message,
    required this.status,
    required this.data,
  });

  factory LocationResponse.fromJson(Map<String, dynamic> json) =>
      LocationResponse(
        date: json["date"],
        message: json["message"],
        status: json["status"],
        data: List<LocationData>.from(
            json["data"].map((x) => LocationData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "date": date,
        "message": message,
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class LocationData {
  final String? location;
  final double? latitude;
  final double? longitude;

  LocationData({
    required this.location,
    required this.latitude,
    required this.longitude,
  });

  factory LocationData.fromJson(Map<String, dynamic> json) => LocationData(
        location: json["location"],
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "location": location,
        "latitude": latitude,
        "longitude": longitude,
      };
}
