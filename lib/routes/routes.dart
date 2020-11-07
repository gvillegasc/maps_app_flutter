import 'package:flutter/material.dart';

// Pages
import 'package:maps_app/pages/access_gps/access_gps_page.dart';
import 'package:maps_app/pages/loading/loading_page.dart';
import 'package:maps_app/pages/map/map_page.dart';

final Map<String, Widget Function(BuildContext)> appRoutes = {
  LoadingPage.routeName: (_) => LoadingPage(),
  AccessGpsPage.routeName: (_) => AccessGpsPage(),
  MapPage.routeName: (_) => MapPage(),
};

final LoadingPage homeRoute = LoadingPage();
