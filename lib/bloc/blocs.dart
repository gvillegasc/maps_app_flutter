import 'package:flutter_bloc/flutter_bloc.dart';

import 'map_bloc/map_bloc.dart';
import 'my_location_bloc/my_location_bloc.dart';
import 'search_bloc/search_bloc.dart';

final blocsProvider = [
  BlocProvider(
    create: (_) => MyLocationBloc(),
  ),
  BlocProvider(
    create: (_) => MapBloc(),
  ),
  BlocProvider(
    create: (_) => SearchBloc(),
  )
];
