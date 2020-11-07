import 'package:flutter/material.dart';
import 'package:maps_app/bloc/map_bloc/map_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

class BtnFollowLocation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    final mapBloc = context.watch<MapBloc>();
    return BlocBuilder<MapBloc, MapState>(builder: (_, state) {
      return Container(
        margin: EdgeInsets.only(bottom: 10),
        child: CircleAvatar(
          backgroundColor: Colors.white,
          maxRadius: 25,
          child: IconButton(
            icon: Icon(
                mapBloc.state.followLocation
                    ? Icons.directions_run
                    : Icons.accessibility_new,
                color: Colors.black87),
            onPressed: () {
              mapBloc.add(OnFollowLocation());
            },
          ),
        ),
      );
    });
  }
}
