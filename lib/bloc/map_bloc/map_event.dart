part of 'map_bloc.dart';

@immutable
abstract class MapEvent {}

class OnMapReady extends MapEvent {}

class OnMarkTour extends MapEvent {}

class OnFollowLocation extends MapEvent {}

class OnCreateRouteStartDestination extends MapEvent {
  final List<LatLng> routeCoords;
  final double distance;
  final double duration;

  OnCreateRouteStartDestination(this.routeCoords, this.distance, this.duration);
}

class OnMoveMap extends MapEvent {
  final LatLng centerMap;

  OnMoveMap(this.centerMap);
}

class OnLocationUpdate extends MapEvent {
  final LatLng location;
  OnLocationUpdate(this.location);
}
