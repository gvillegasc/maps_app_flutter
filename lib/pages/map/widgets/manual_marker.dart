import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/search_bloc/search_bloc.dart';

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
                onPressed: () {},
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
}
