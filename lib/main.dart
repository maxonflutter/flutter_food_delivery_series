import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/models.dart';
import 'blocs/blocs.dart';
import 'config/app_router.dart';
import 'config/theme.dart';
import 'datasources/datasources.dart';
import 'repositories/repositories.dart';
import 'screens/screens.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await Hive.initFlutter();
  Hive
    ..registerAdapter(PlaceAdapter())
    ..registerAdapter(ProductAdapter())
    ..registerAdapter(VoucherAdapter())
    ..registerAdapter(DeliveryTimeAdapter())
    ..registerAdapter(BasketAdapter());

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
        RepositoryProvider<LocationRepository>(
          create: (_) => LocationRepository(
            placesAPI: PlacesAPIImpl(),
            localDatasource: LocalDatasourceImpl(),
          ),
        ),
        RepositoryProvider<BasketRepository>(
          create: (_) => BasketRepository(
            localDatasource: LocalDatasourceImpl(),
          ),
        ),
        RepositoryProvider<RestaurantRepository>(
          create: (_) => RestaurantRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => LocationBloc(
              geolocationRepository: context.read<GeolocationRepository>(),
              locationRepository: context.read<LocationRepository>(),
              restaurantRepository: context.read<RestaurantRepository>(),
            )..add(LoadMap()),
          ),
          BlocProvider(
            create: (context) => RestaurantsBloc(
              restaurantRepository: context.read<RestaurantRepository>(),
              locationBloc: context.read<LocationBloc>(),
            ),
          ),
          BlocProvider(
            create: (context) => AutocompleteBloc(
              locationRepository: context.read<LocationRepository>(),
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
              basketRepository: context.read<BasketRepository>(),
              voucherBloc: context.read<VoucherBloc>(),
            )..add(StartBasket()),
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
