import 'package:dio/dio.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/models/driving_response.dart';

class TrafficService {
  TrafficService._privateConstructor();
  static final TrafficService _instance = TrafficService._privateConstructor();

  factory TrafficService() {
    return _instance;
  }

  final Dio _dio = new Dio();
  final String _baseUrl = "https://api.mapbox.com/directions/v5";
  final String _apiKey =
      "pk.eyJ1IjoiZ3ZpbGxlZ2FzYyIsImEiOiJja2d2aHFuZnIwMGlnMzFxemt0YWVqOWhyIn0.X1RmdWulsJ0uKshI6dhnSA";

  Future<DrivingResponse> getCoordsStartDestination(
      LatLng start, LatLng destination) async {
    print(start);
    print(destination);
    final coordString =
        "${start.longitude},${start.latitude};${destination.longitude},${destination.latitude}";
    final url = "${this._baseUrl}/mapbox/driving/$coordString";
    final resp = await this._dio.get(url, queryParameters: {
      "alternatives": "true",
      "geometries": "polyline6",
      "steps": "false",
      "access_token": this._apiKey,
      "language": "es"
    });
    final data = DrivingResponse.fromJson(resp.data);
    return data;
  }
}
