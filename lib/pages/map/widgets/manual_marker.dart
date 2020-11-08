import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/map_bloc/map_bloc.dart';
import 'package:maps_app/bloc/my_location_bloc/my_location_bloc.dart';
import 'package:maps_app/bloc/search_bloc/search_bloc.dart';
import 'package:maps_app/services/traffic_service.dart';
import 'package:polyline/polyline.dart' as Poly;

class ManualMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchBloc, SearchState>(builder: (context, state) {
      if (state.manualSelection) {
        return _BuildManualMarkers();
      } else {
        return Container();
      }
    });
  }
}

class _BuildManualMarkers extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Positioned(
            top: screenSize.height * 0.05,
            left: screenSize.height * 0.03,
            child: FadeIn(
              duration: Duration(milliseconds: 150),
              child: CircleAvatar(
                maxRadius: 25,
                backgroundColor: Colors.white,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    context.read<SearchBloc>().add(OnInactiveManualMarker());
                  },
                ),
              ),
            )),
        Center(
          child: Transform.translate(
            offset: Offset(0, -20),
            child: BounceInDown(
              from: 200,
              child: Icon(
                Icons.location_on,
                size: 50,
              ),
            ),
          ),
        ),
        Positioned(
            bottom: 70,
            left: screenSize.width * 0.2,
            child: FadeIn(
              duration: Duration(milliseconds: 150),
              child: MaterialButton(
                onPressed: () => this.calculateDestination(context),
                color: Colors.black,
                elevation: 0,
                shape: StadiumBorder(),
                minWidth: screenSize.width * 0.6,
                child: Text(
                  "Confirmar destino",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ))
      ],
    );
  }

  void calculateDestination(BuildContext context) async {
    final trafficService = new TrafficService();
    final start = context.read<MyLocationBloc>().state.location;
    // ignore: close_sinks
    final mapBloc = context.read<MapBloc>();

    final trafficResponse = await trafficService.getCoordsStartDestination(
        start, mapBloc.state.locationCenter);

    final geometry = trafficResponse.routes[0].geometry;
    final duration = trafficResponse.routes[0].duration;
    final distance = trafficResponse.routes[0].distance;

    final points = Poly.Polyline.Decode(
      encodedString: geometry,
      precision: 6,
    ).decodedCoords;

    final List<LatLng> routeCoords =
        points.map((point) => LatLng(point[0], point[1])).toList();

    mapBloc.add(OnCreateRouteStartDestination(routeCoords, distance, duration));
  }
}
