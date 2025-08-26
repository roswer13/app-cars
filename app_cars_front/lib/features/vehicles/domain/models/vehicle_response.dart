import 'dart:convert';

VehicleResponse vehicleResponseFromJson(String str) =>
    VehicleResponse.fromJson(json.decode(str));

String vehicleResponseToJson(VehicleResponse data) =>
    json.encode(data.toJson());

class VehicleResponse {
  int count;
  String? next;
  String? previous;
  List<Result> results;

  VehicleResponse({
    required this.count,
    this.next,
    this.previous,
    required this.results,
  });

  factory VehicleResponse.fromJson(Map<String, dynamic> json) =>
      VehicleResponse(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<Result>.from(
          json["results"].map((x) => Result.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  int id;
  String plate;
  String label;
  String statusColor;
  String latitude;
  String longitude;

  Result({
    required this.id,
    required this.plate,
    required this.label,
    required this.statusColor,
    required this.latitude,
    required this.longitude,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    plate: json["plate"],
    label: json["label"],
    statusColor: json["status_color"],
    latitude: json["latitude"],
    longitude: json["longitude"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plate": plate,
    "label": label,
    "status_color": statusColor,
    "latitude": latitude,
    "longitude": longitude,
  };
}
