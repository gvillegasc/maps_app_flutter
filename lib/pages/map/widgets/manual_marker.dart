import 'package:flutter/material.dart';

class ManualMarker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return Stack(
      children: <Widget>[
        Positioned(
            top: screenSize.height * 0.05,
            left: screenSize.height * 0.03,
            child: CircleAvatar(
              maxRadius: 25,
              backgroundColor: Colors.white,
              child: IconButton(
                icon: Icon(
                  Icons.arrow_back,
                  color: Colors.black,
                ),
                onPressed: () {},
              ),
            )),
        Center(
          child: Transform.translate(
            offset: Offset(0, -20),
            child: Icon(
              Icons.location_on,
              size: 50,
            ),
          ),
        ),
        Positioned(
            bottom: 70,
            left: screenSize.width * 0.2,
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
            ))
      ],
    );
  }
}
