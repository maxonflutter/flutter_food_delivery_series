import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_delivery_app/blocs/restaurants/restaurants_bloc.dart';

import 'blocs/blocs.dart';
import 'repositories/repositories.dart';
import 'config/theme.dart';
import 'config/app_router.dart';
import 'screens/screens.dart';
import 'simple_bloc_observer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
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
          BlocProvider(
            create: (context) => FilterBloc()
              ..add(
                LoadFilter(),
              ),
          ),
          BlocProvider(
            create: (context) =>
                VoucherBloc(voucherRepository: VoucherRepository())
                  ..add(
                    LoadVouchers(),
                  ),
          ),
          BlocProvider(
            create: (context) =>
                BasketBloc(voucherBloc: BlocProvider.of<VoucherBloc>(context))
                  ..add(
                    StartBasket(),
                  ),
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
