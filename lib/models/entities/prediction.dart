import 'package:google_maps_flutter/google_maps_flutter.dart';

class Prediction {
  String? description;
  String? placeId;
  String? lat;
  String? long;
  Prediction.fromJson(json) {
    description = json['description'];
    placeId = json['place_id'];
  }
  Prediction();

  LatLng get latLng => LatLng(
        double.tryParse(lat ?? '') ?? 0,
        double.tryParse(long ?? '') ?? 0,
      );
}
