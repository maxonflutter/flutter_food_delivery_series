import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';


import 'blocs/blocs.dart';
import '/models/models.dart';
import 'repositories/repositories.dart';
import 'config/theme.dart';
import 'config/app_router.dart';

import 'screens/screens.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive.registerAdapter(PlaceAdapter());

  BlocOverrides.runZoned(
    () {
      runApp(MyApp());
    },
    blocObserver: SimpleBlocObserver(),
  );
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
        RepositoryProvider<RestaurantRepository>(
          create: (_) => RestaurantRepository(),
        ),
        RepositoryProvider<LocalStorageRepository>(
          create: (_) => LocalStorageRepository(),
        )
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => RestaurantsBloc(
              restaurantRepository: context.read<RestaurantRepository>(),
            ),
          ),
          BlocProvider(
            create: (context) => AutocompleteBloc(
              placesRepository: context.read<PlacesRepository>(),
            )..add(LoadAutocomplete()),
          ),
          BlocProvider(
            create: (context) => FilterBloc(
              restaurantsBloc: context.read<RestaurantsBloc>(),
            )..add(LoadFilter()),
          ),
          BlocProvider(
            create: (context) => VoucherBloc(
              voucherRepository: VoucherRepository(),
            )..add(LoadVouchers()),
          ),
          BlocProvider(
            create: (context) => BasketBloc(
              voucherBloc: BlocProvider.of<VoucherBloc>(context),
            )..add(StartBasket()),
          ),
          BlocProvider(
            create: (context) => LocationBloc(
              geolocationRepository: context.read<GeolocationRepository>(),
              placesRepository: context.read<PlacesRepository>(),
              localStorageRepository: context.read<LocalStorageRepository>(),
              restaurantRepository: context.read<RestaurantRepository>(),
            )..add(LoadMap()),
          ),
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
