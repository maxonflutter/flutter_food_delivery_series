import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_delivery_app/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:flutter_food_delivery_app/blocs/filter/filter_bloc.dart';
import 'package:flutter_food_delivery_app/blocs/geolocation/geolocation_bloc.dart';
import 'package:flutter_food_delivery_app/repositories/geolocation/geolocation_repository.dart';
import 'package:flutter_food_delivery_app/repositories/places/places_repository.dart';
import 'package:flutter_food_delivery_app/screens/screens.dart';

import 'blocs/place/place_bloc.dart';
import 'config/theme.dart';
import 'config/app_router.dart';
import 'screens/home/home_screen.dart';
import 'screens/screens.dart';
import 'simple_bloc_observer.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<GeolocationRepository>(
          create: (_) => GeolocationRepository(),
        ),
        RepositoryProvider<PlacesRepository>(
          create: (_) => PlacesRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
              create: (context) => GeolocationBloc(
                  geolocationRepository: context.read<GeolocationRepository>())
                ..add(LoadGeolocation())),
          BlocProvider(
              create: (context) => AutocompleteBloc(
                  placesRepository: context.read<PlacesRepository>())
                ..add(LoadAutocomplete())),
          BlocProvider(
              create: (context) => PlaceBloc(
                  placesRepository: context.read<PlacesRepository>())),
          BlocProvider(create: (context) => FilterBloc()..add(FilterLoad())),
        ],
        child: MaterialApp(
          title: 'FoodDelivery',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: HomeScreen.routeName,
        ),
      ),
    );
  }
}
