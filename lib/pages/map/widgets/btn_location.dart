import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/map_bloc/map_bloc.dart';
import 'package:maps_app/bloc/my_location_bloc/my_location_bloc.dart';

class BtnLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final mapBloc = context.bloc<MapBloc>();
    // ignore: close_sinks
    final myLocationBloc = context.bloc<MyLocationBloc>();
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: CircleAvatar(
        backgroundColor: Colors.white,
        maxRadius: 25,
        child: IconButton(
          icon: Icon(Icons.my_location, color: Colors.black87),
          onPressed: () {
            final destiny = myLocationBloc.state.location;
            mapBloc.moveCamera(destiny);
          },
        ),
      ),
    );
  }
}
