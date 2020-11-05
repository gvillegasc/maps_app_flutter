part of 'map_bloc.dart';

@immutable
class MapState {
  final bool mapReady;
  final bool drawTour;
  final bool followLocation;
  final LatLng locationCenter;

  // Polylines
  final Map<String, Polyline> polylines;

  MapState(
      {this.mapReady = false,
      this.drawTour = false,
      this.followLocation = false,
      this.locationCenter,
      Map<String, Polyline> polylines})
      : this.polylines = polylines ?? new Map();

  MapState copyWith(
          {bool mapReady,
          bool drawTour,
          bool followLocation,
          LatLng locationCenter,
          Map<String, Polyline> polylines}) =>
      MapState(
          mapReady: mapReady ?? this.mapReady,
          drawTour: drawTour ?? this.drawTour,
          followLocation: followLocation ?? this.followLocation,
          locationCenter: locationCenter ?? this.locationCenter,
          polylines: polylines ?? this.polylines);
}
