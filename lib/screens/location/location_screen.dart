import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../blocs/blocs.dart';
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
            return Stack(
              children: [
                GoogleMap(
                  myLocationEnabled: true,
                  onMapCreated: (GoogleMapController controller) {
                    context.read<LocationBloc>().add(
                          LoadMap(controller: controller),
                        );
                  },
                  initialCameraPosition: CameraPosition(
                    target: LatLng(state.lat, state.lng),
                    zoom: 13,
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
                      BlocBuilder<AutocompleteBloc, AutocompleteState>(
                        builder: (context, state) {
                          if (state is AutocompleteLoading) {
                            return SizedBox();
                          }
                          if (state is AutocompleteLoaded) {
                            return ListView.builder(
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
                                              placeId: state
                                                  .autocomplete[index].placeId,
                                            ),
                                          );
                                      context
                                          .read<AutocompleteBloc>()
                                          .add(ClearAutocomplete());
                                    },
                                  ),
                                );
                              },
                            );
                          } else {
                            return Text('Something went wrong!');
                          }
                        },
                      ),
                      Expanded(child: SizedBox()),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Theme.of(context).primaryColor,
                          fixedSize: Size(200, 40),
                        ),
                        child: Text('Save'),
                        onPressed: () {
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

class _GoogleMap extends StatelessWidget {
  const _GoogleMap({
    Key? key,
    required this.lat,
    required this.lng,
  }) : super(key: key);

  final double lat;
  final double lng;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      myLocationEnabled: true,
      onMapCreated: (GoogleMapController controller) {
        context.read<LocationBloc>().add(
              LoadMap(controller: controller),
            );
      },
      initialCameraPosition: CameraPosition(
        target: LatLng(lat, lng),
        zoom: 13,
      ),
    );
  }
}



// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// import '../../blocs/blocs.dart';
// import '../../repositories/repositories.dart';
// import '../../widgets/widgets.dart';

// class LocationScreen extends StatelessWidget {
//   static const String routeName = '/location';

//   static Route route() {
//     return MaterialPageRoute(
//       builder: (_) => BlocProvider(
//         create: (context) => LocationBloc(
//           geolocationRepository: context.read<GeolocationRepository>(),
//           placesRepository: context.read<PlacesRepository>(),
//         ),
//         child: LocationScreen(),
//       ),
//       settings: RouteSettings(name: routeName),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: BlocBuilder<LocationBloc, LocationState>(
//         builder: (context, state) {
//           if (state is LocationLoading) {
//             return Center(
//               child: _GoogleMap(
//                 lat: 0,
//                 lng: 0,
//               ),
//             );
//           }
//           if (state is LocationLoaded) {
//             return Stack(
//               children: [
//                 _GoogleMap(
//                   lat: state.lat,
//                   lng: state.lng,
//                 ),
//                 Padding(
//                   padding: const EdgeInsets.symmetric(
//                     horizontal: 20,
//                     vertical: 40,
//                   ),
//                   child: Column(
//                     children: [
//                       Row(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SvgPicture.asset('assets/logo.svg', height: 50),
//                           SizedBox(width: 10),
//                           Expanded(child: LocationSearchBox()),
//                         ],
//                       ),
//                       BlocBuilder<AutocompleteBloc, AutocompleteState>(
//                         builder: (context, state) {
//                           if (state is AutocompleteLoading) {
//                             return SizedBox();
//                           }
//                           if (state is AutocompleteLoaded) {
//                             return ListView.builder(
//                               shrinkWrap: true,
//                               itemCount: state.autocomplete.length,
//                               itemBuilder: (context, index) {
//                                 return Container(
//                                   color: Colors.black.withOpacity(0.6),
//                                   child: ListTile(
//                                     title: Text(
//                                       state.autocomplete[index].description,
//                                       style: Theme.of(context)
//                                           .textTheme
//                                           .headline6!
//                                           .copyWith(color: Colors.white),
//                                     ),
//                                     onTap: () {
//                                       context.read<LocationBloc>().add(
//                                             SearchLocation(
//                                               placeId: state
//                                                   .autocomplete[index].placeId,
//                                             ),
//                                           );
//                                     },
//                                   ),
//                                 );
//                               },
//                             );
//                           } else {
//                             return Text('Something went wrong!');
//                           }
//                         },
//                       ),
//                       Expanded(child: SizedBox()),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           primary: Theme.of(context).primaryColor,
//                           fixedSize: Size(200, 40),
//                         ),
//                         child: Text('Save'),
//                         onPressed: () {
//                           Navigator.pushNamed(context, '/');
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             );
//           } else {
//             return Text('Something went wrong!');
//           }
//         },
//       ),
//     );
//   }
// }

// class _GoogleMap extends StatelessWidget {
//   const _GoogleMap({
//     Key? key,
//     required this.lat,
//     required this.lng,
//   }) : super(key: key);

//   final double lat;
//   final double lng;

//   @override
//   Widget build(BuildContext context) {
//     print('Stateless widget: $lat, $lng');
//     return GoogleMap(
//       myLocationEnabled: true,
//       onMapCreated: (GoogleMapController controller) {
//         context.read<LocationBloc>().add(
//               LoadMap(controller: controller),
//             );
//       },
//       initialCameraPosition: CameraPosition(
//         target: LatLng(lat, lng),
//         zoom: 12,
//       ),
//     );
//   }
// }
