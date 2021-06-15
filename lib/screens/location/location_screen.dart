import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_food_delivery_app/blocs/autocomplete/autocomplete_bloc.dart';
import 'package:flutter_food_delivery_app/blocs/geolocation/geolocation_bloc.dart';
import 'package:flutter_food_delivery_app/blocs/place/place_bloc.dart';
import 'package:flutter_food_delivery_app/widgets/widgets.dart';
import 'package:flutter_svg/svg.dart';

class LocationScreen extends StatelessWidget {
  static const String routeName = '/location';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => LocationScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<PlaceBloc, PlaceState>(
        builder: (context, state) {
          if (state is PlaceLoading) {
            return Stack(
              children: [
                BlocBuilder<GeolocationBloc, GeolocationState>(
                  builder: (context, state) {
                    if (state is GeolocationLoading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is GeolocationLoaded) {
                      return Stack(
                        children: [
                          Gmap(
                            lat: state.position.latitude,
                            lng: state.position.longitude,
                          ),
                        ],
                      );
                    } else {
                      return Text('Something went wrong!');
                    }
                  },
                ),
                SaveButton(),
                Location(),
              ],
            );
          } else if (state is PlaceLoaded) {
            return Stack(
              children: [
                Gmap(
                  lat: state.place.lat,
                  lng: state.place.lon,
                ),
                SaveButton(),
                Location(),
              ],
            );
          } else {
            return Text('Something went wrong!');
          }
        },
      ),
    );
  }
}

class Location extends StatelessWidget {
  const Location({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 40,
      left: 20,
      right: 20,
      child: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset(
              'assets/logo.svg',
              height: 50,
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              child: Column(
                children: [
                  LocationSearchBox(),
                  BlocBuilder<AutocompleteBloc, AutocompleteState>(
                    builder: (context, state) {
                      if (state is AutocompleteLoading) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (state is AutocompleteLoaded) {
                        return Container(
                          margin: const EdgeInsets.all(8),
                          height: 300,
                          color: state.autocomplete.length > 0
                              ? Colors.black.withOpacity(0.6)
                              : Colors.transparent,
                          child: ListView.builder(
                            itemCount: state.autocomplete.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(
                                  state.autocomplete[index].description,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                        color: Colors.white,
                                      ),
                                ),
                                onTap: () {
                                  context.read<PlaceBloc>().add(
                                        LoadPlace(
                                          placeId:
                                              state.autocomplete[index].placeId,
                                        ),
                                      );
                                },
                              );
                            },
                          ),
                        );
                      } else {
                        return Text('Something went wrong!');
                      }
                    },
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SaveButton extends StatelessWidget {
  const SaveButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 50,
      left: 20,
      right: 20,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 70.0),
        child: ElevatedButton(
          style:
              ElevatedButton.styleFrom(primary: Theme.of(context).primaryColor),
          child: Text('Save'),
          onPressed: () {
            Navigator.pushNamed(context, '/');
          },
        ),
      ),
    );
  }
}
