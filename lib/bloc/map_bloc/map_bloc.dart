import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';
import 'package:maps_app/themes/uber_map_theme.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'map_event.dart';
part 'map_state.dart';

class MapBloc extends Bloc<MapEvent, MapState> {
  MapBloc() : super(MapState());

  // Map Controller
  GoogleMapController _mapController;

  // Polyline
  Polyline _myRoute = new Polyline(
      polylineId: PolylineId('my_route'), width: 4, color: Colors.transparent);

  Polyline _myRouteDestination = new Polyline(
      polylineId: PolylineId('my_route_destination'),
      width: 4,
      color: Colors.black87);

  void initMap(GoogleMapController controller) {
    if (!state.mapReady) {
      this._mapController = controller;
      this._mapController.setMapStyle(jsonEncode(uberMapTheme));
      add(OnMapReady());
    }
  }

  void moveCamera(LatLng destiny) {
    final cameraUpdate = CameraUpdate.newLatLng(destiny);
    this._mapController?.animateCamera(cameraUpdate);
  }

  @override
  Stream<MapState> mapEventToState(
    MapEvent event,
  ) async* {
    if (event is OnMapReady) {
      yield state.copyWith(mapReady: true);
    } else if (event is OnLocationUpdate) {
      yield* this._mapOnLocationUpdate(event);
    } else if (event is OnMarkTour) {
      yield* this._mapOnMarkTour(event);
    } else if (event is OnFollowLocation) {
      yield* this._mapOnFollowLocation(event);
    } else if (event is OnMoveMap) {
      yield this.state.copyWith(locationCenter: event.centerMap);
    } else if (event is OnCreateRouteStartDestination) {
      yield* this._mapOnCreateRouteStartDestination(event);
    }
  }

  Stream<MapState> _mapOnLocationUpdate(OnLocationUpdate event) async* {
    if (this.state.followLocation) {
      this.moveCamera(event.location);
    }

    List<LatLng> points = [...this._myRoute.points, event.location];
    this._myRoute = this._myRoute.copyWith(pointsParam: points);

    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute;

    yield this.state.copyWith(polylines: currentPolylines);
  }

  Stream<MapState> _mapOnMarkTour(OnMarkTour event) async* {
    if (!this.state.drawTour) {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.black87);
    } else {
      this._myRoute = this._myRoute.copyWith(colorParam: Colors.transparent);
    }
    final currentPolylines = state.polylines;
    currentPolylines['my_route'] = this._myRoute;

    yield this
        .state
        .copyWith(drawTour: !state.drawTour, polylines: currentPolylines);
  }

  Stream<MapState> _mapOnFollowLocation(OnFollowLocation event) async* {
    if (!this.state.followLocation) {
      this.moveCamera(this._myRoute.points[this._myRoute.points.length - 1]);
    }
    yield this.state.copyWith(followLocation: !state.followLocation);
  }

  Stream<MapState> _mapOnCreateRouteStartDestination(
      OnCreateRouteStartDestination event) async* {
    this._myRouteDestination =
        this._myRouteDestination.copyWith(pointsParam: event.routeCoords);

    final currentPolylines = state.polylines;
    currentPolylines['my_route_destination'] = this._myRouteDestination;
    yield this.state.copyWith(polylines: currentPolylines);
  }
}
