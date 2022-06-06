import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import '/blocs/blocs.dart';
import '/screens/screens.dart';

class BasketScreen extends StatelessWidget {
  static const String routeName = '/basket';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => BasketScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Basket'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                EditBasketScreen.routeName,
              );
            },
            icon: Icon(Icons.edit),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(),
                  primary: Theme.of(context).colorScheme.secondary,
                ),
                child: Text('Apply'),
                onPressed: () {},
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _BasketCutlery(),
            _BasketItems(),
            _BasketDeliveryTime(),
            _BasketVoucher(),
            _BasketSummary(),
          ],
        ),
      ),
    );
  }
}

class _BasketCutlery extends StatelessWidget {
  const _BasketCutlery({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        if (state is BasketLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BasketLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Cutlery',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              _BasketContainer(
                height: null,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Do you need cutlery?',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                    ),
                    SizedBox(
                      width: 100,
                      child: SwitchListTile(
                        dense: false,
                        value: state.basket.isCutlerySelected,
                        activeColor: Theme.of(context).colorScheme.primary,
                        onChanged: (bool? newValue) {
                          context.read<BasketBloc>().add(ToggleSwitch());
                        },
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
            ],
          );
        } else {
          return Text('Something went wrong.');
        }
      },
    );
  }
}

class _BasketItems extends StatelessWidget {
  const _BasketItems({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        if (state is BasketLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is BasketLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Items',
                style: Theme.of(context)
                    .textTheme
                    .headline4!
                    .copyWith(color: Theme.of(context).colorScheme.secondary),
              ),
              state.basket.products.length == 0
                  ? _BasketContainer(
                      height: null,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'No Items in the Basket',
                            textAlign: TextAlign.left,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.basket
                          .itemQuantity(state.basket.products)
                          .keys
                          .length,
                      itemBuilder: (context, index) {
                        var itemQuantity = state.basket
                            .itemQuantity(state.basket.products)
                            .entries
                            .elementAt(index)
                            .value;
                        var itemName = state.basket
                            .itemQuantity(state.basket.products)
                            .keys
                            .elementAt(index)
                            .name;
                        var itemPrice = state.basket
                            .itemQuantity(state.basket.products)
                            .keys
                            .elementAt(index)
                            .price;

                        return _BasketContainer(
                          height: null,
                          verticalPadding: 10,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '$itemQuantity x',
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary,
                                    ),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Text(
                                  '$itemName',
                                  textAlign: TextAlign.left,
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Text(
                                '\$$itemPrice',
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ],
          );
        } else {
          return Text('Something went wrong.');
        }
      },
    );
  }
}

class _BasketDeliveryTime extends StatelessWidget {
  const _BasketDeliveryTime({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        if (state is BasketLoaded) {
          return _BasketContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SvgPicture.asset('assets/delivery_time.svg'),
                (state.basket.deliveryTime == null)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Delivery in 20 minutes',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                DeliveryTimeScreen.routeName,
                              );
                            },
                            child: Text(
                              'Change',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Delivery at ${state.basket.deliveryTime!.value}',
                        style: Theme.of(context).textTheme.headline6,
                      ),
              ],
            ),
          );
        } else {
          return Text('Something went wrong');
        }
      },
    );
  }
}

class _BasketVoucher extends StatelessWidget {
  const _BasketVoucher({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        if (state is BasketLoaded) {
          return _BasketContainer(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                (state.basket.voucher == null)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 20),
                          Text(
                            'Do you have a voucher?',
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(
                                context,
                                VoucherScreen.routeName,
                              );
                            },
                            child: Text(
                              'Apply',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline6!
                                  .copyWith(
                                    color:
                                        Theme.of(context).colorScheme.primary,
                                  ),
                            ),
                          ),
                        ],
                      )
                    : Text(
                        'Your voucher is applied!',
                        style: Theme.of(context).textTheme.headline6,
                      ),
                SvgPicture.asset('assets/delivery_time.svg'),
              ],
            ),
          );
        } else {
          return Text('Something went wrong');
        }
      },
    );
  }
}

class _BasketSummary extends StatelessWidget {
  const _BasketSummary({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BasketBloc, BasketState>(
      builder: (context, state) {
        if (state is BasketLoading) {
          return Center(child: CircularProgressIndicator());
        }
        if (state is BasketLoaded) {
          return _BasketContainer(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Subtotal',
                        style: Theme.of(context).textTheme.headline6),
                    Text(
                      '\$${state.basket.subtotalString}',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Delivery Fee',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    Text(
                      '\$5.00',
                      style: Theme.of(context).textTheme.headline6,
                    ),
                  ],
                ),
                SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                    Text(
                      '\$${state.basket.totalString}',
                      style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ],
            ),
          );
        } else {
          return Text('Something went wrong.');
        }
      },
    );
  }
}

class _BasketContainer extends StatelessWidget {
  final Widget child;
  final double? height;
  final double? verticalPadding;

  const _BasketContainer({
    Key? key,
    required this.child,
    this.height = 100,
    this.verticalPadding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      margin: const EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(
        horizontal: 30,
        vertical: verticalPadding ?? 0,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: child,
    );
  }
}
