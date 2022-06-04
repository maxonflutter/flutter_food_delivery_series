import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../blocs/blocs.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';

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
      body: BlocBuilder<LocationBloc, LocationState>(
        builder: (context, state) {
          if (state is LocationLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is LocationLoaded) {
            List<Restaurant> restaurants =
                (context.read<RestaurantsBloc>().state as RestaurantsLoaded)
                    .restaurants;
            return Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  buildingsEnabled: false,
                  onMapCreated: (GoogleMapController controller) {
                    context.read<LocationBloc>().add(
                          LoadMap(controller: controller),
                        );
                  },
                  markers: {
                    Marker(
                      markerId: MarkerId('marker_1'),
                      infoWindow: InfoWindow(
                        title: restaurants[0].name,
                        snippet: restaurants[0].description,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/restaurant-details',
                            arguments: restaurants[0],
                          );
                        },
                      ),
                      position: LatLng(
                        restaurants[0].address.lat,
                        restaurants[0].address.lon,
                      ),
                    ),
                    Marker(
                      markerId: MarkerId('marker_2'),
                      infoWindow: InfoWindow(
                        title: restaurants[1].name,
                        snippet: restaurants[1].description,
                        onTap: () {
                          Navigator.pushNamed(
                            context,
                            '/restaurant-details',
                            arguments: restaurants[1],
                          );
                        },
                      ),
                      position: LatLng(
                        restaurants[1].address.lat,
                        restaurants[1].address.lon,
                      ),
                      onTap: () {},
                    ),
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      state.place.lat,
                      state.place.lon,
                    ),
                    zoom: 15,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 40,
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset('assets/logo.svg', height: 50),
                          SizedBox(width: 10),
                          Expanded(child: LocationSearchBox()),
                        ],
                      ),
                      _SearchBoxSuggestions(),
                      Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).colorScheme.primary,
                          fixedSize: Size(200, 40),
                        ),
                        child: Text('Save'),
                        onPressed: () {
                          print(state.place);
                          Navigator.pushNamed(context, '/');
                        },
                      ),
                    ],
                  ),
                ),
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

class _SearchBoxSuggestions extends StatelessWidget {
  const _SearchBoxSuggestions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AutocompleteBloc, AutocompleteState>(
      builder: (context, state) {
        if (state is AutocompleteLoading) {
          return SizedBox();
        }
        if (state is AutocompleteLoaded) {
          return ListView.builder(
            padding: EdgeInsets.zero,
            shrinkWrap: true,
            itemCount: state.autocomplete.length,
            itemBuilder: (context, index) {
              return Container(
                color: Colors.black.withOpacity(0.6),
                child: ListTile(
                  title: Text(
                    state.autocomplete[index].description,
                    style: Theme.of(context)
                        .textTheme
                        .headline6!
                        .copyWith(color: Colors.white),
                  ),
                  onTap: () {
                    context.read<LocationBloc>().add(
                          SearchLocation(
                            placeId: state.autocomplete[index].placeId,
                          ),
                        );
                    context.read<AutocompleteBloc>().add(ClearAutocomplete());
                  },
                ),
              );
            },
          );
        } else {
          return Text('Something went wrong!');
        }
      },
    );
  }
}
