// Flutter
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import 'package:maps_app/helpers/helpers.dart'; // helpers
// Pages
import 'package:maps_app/pages/access_gps/access_gps_page.dart';
import 'package:maps_app/pages/map/map_page.dart';
import 'package:permission_handler/permission_handler.dart';

class LoadingPage extends StatefulWidget {
  static final String routeName = "loading";

  @override
  _LoadingPageState createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> with WidgetsBindingObserver {
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    super.initState();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      if (await Geolocator.isLocationServiceEnabled()) {
        Navigator.pushReplacement(
            context, navigateMapFadeIn(context, MapPage()));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: this.checkGpsAndLocation(context),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Center(
              child: Text(snapshot.data),
            );
          } else {
            return Center(
              child: (Platform.isIOS)
                  ? CupertinoActivityIndicator()
                  : CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Future checkGpsAndLocation(BuildContext context) async {
    // permission gps
    final permissionGPS = await Permission.location.isGranted;
    // gps active
    final gpsActive = await Geolocator.isLocationServiceEnabled();

    if (permissionGPS && gpsActive) {
      Navigator.pushReplacement(context, navigateMapFadeIn(context, MapPage()));
      return '';
    } else if (!permissionGPS) {
      Navigator.pushReplacement(
          context, navigateMapFadeIn(context, AccessGpsPage()));
      return 'Is necessary GPS permission';
    } else {
      return 'Active GPS';
    }
  }
}
