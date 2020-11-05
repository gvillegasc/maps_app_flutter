import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:maps_app/bloc/map_bloc/map_bloc.dart';
import 'package:maps_app/pages/loading/loading_page.dart';
import 'package:maps_app/routes/routes.dart';

import 'bloc/my_location_bloc/my_location_bloc.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark));
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => MyLocationBloc(),
        ),
        BlocProvider(
          create: (_) => MapBloc(),
        )
      ],
      child: MaterialApp(
          title: 'Material App',
          debugShowCheckedModeBanner: false,
          home: LoadingPage(),
          routes: appRoutes),
    );
  }
}
