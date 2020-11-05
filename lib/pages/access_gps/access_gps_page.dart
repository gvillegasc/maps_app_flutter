import 'package:flutter/material.dart';
import 'package:maps_app/pages/loading/loading_page.dart';
import 'package:maps_app/pages/map/map_page.dart';
import 'package:permission_handler/permission_handler.dart';

class AccessGpsPage extends StatefulWidget {
  static final String routeName = "access_gps";

  @override
  _AccessGpsPageState createState() => _AccessGpsPageState();
}

class _AccessGpsPageState extends State<AccessGpsPage>
    with WidgetsBindingObserver {
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
      if (await Permission.location.isGranted) {
        Navigator.pushReplacementNamed(context, LoadingPage.routeName);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Is necessary GPS permission"),
          MaterialButton(
            color: Colors.black,
            child: Text(
              "Request Access",
              style: TextStyle(color: Colors.white),
            ),
            shape: StadiumBorder(),
            elevation: 0,
            // splashColor: Colors.transparent,
            onPressed: () async {
              final status = await Permission.location.request();
              this.accessGPS(status);
            },
          )
        ],
      )),
    );
  }

  void accessGPS(PermissionStatus status) {
    switch (status) {
      case PermissionStatus.granted:
        Navigator.pushReplacementNamed(context, MapPage.routeName);
        break;
      case PermissionStatus.undetermined:
      case PermissionStatus.denied:
      case PermissionStatus.restricted:
      case PermissionStatus.permanentlyDenied:
        openAppSettings();
    }
  }
}
