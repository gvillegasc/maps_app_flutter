import 'package:meta/meta.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart' show LatLng;

class SearchResult {
  final bool cancel;
  final bool manual;
  final LatLng position;
  final String nameDestination;
  final String description;

  SearchResult(
      {@required this.cancel,
      this.manual,
      this.position,
      this.nameDestination,
      this.description});
}
