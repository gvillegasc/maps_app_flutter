import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:maps_app/bloc/map_bloc/map_bloc.dart';
import 'package:maps_app/bloc/my_location_bloc/my_location_bloc.dart';

import 'widgets/widgets.dart';

class MapPage extends StatefulWidget {
  static final String routeName = "map";

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  @override
  void initState() {
    context.read<MyLocationBloc>().initTracing();
    super.initState();
  }

  @override
  void dispose() {
    context.read<MyLocationBloc>().cancelTracing();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            BtnLocation(),
            BtnMyRoute(),
            BtnFollowLocation(),
          ],
        ),
        body: Stack(
          children: [
            BlocBuilder<MyLocationBloc, MyLocationState>(
              builder: (_, state) => createMap(state),
            ),
            ManualMarker(),
            SearchBar()
          ],
        ));
  }

  Widget createMap(MyLocationState state) {
    if (!state.existsLocation) return Center(child: Text("Location..."));

    // ignore: close_sinks
    final mapBloc = BlocProvider.of<MapBloc>(context);

    mapBloc.add(OnLocationUpdate(state.location));

    final cameraPosition = new CameraPosition(target: state.location, zoom: 15);
    return GoogleMap(
      myLocationButtonEnabled: false,
      initialCameraPosition: cameraPosition,
      myLocationEnabled: true,
      mapType: MapType.normal,
      zoomControlsEnabled: false,
      onMapCreated: mapBloc.initMap,
      polylines: mapBloc.state.polylines.values.toSet(),
      onCameraMove: (cameraPosition) {
        mapBloc.add(OnMoveMap(cameraPosition.target));
      },
    );
  }
}
