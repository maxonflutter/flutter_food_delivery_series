import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../blocs/blocs.dart';
import '../../blocs/voucher/voucher_bloc.dart';
import '../../models/models.dart';
import '../../repositories/voucher/voucher_repository.dart';

class VoucherScreen extends StatelessWidget {
  static const String routeName = '/vouchers';

  static Route route() {
    return MaterialPageRoute(
      builder: (_) => VoucherScreen(),
      settings: RouteSettings(name: routeName),
    );
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController voucherController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: Text('Voucher'),
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
            Text(
              'Enter a Voucher Code',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            Container(
              width: double.infinity,
              margin: const EdgeInsets.only(top: 10, bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: voucherController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(10),
                        hintText: 'Voucher Code',
                      ),
                      onChanged: (value) async {
                        print(await VoucherRepository().searchVoucher(value));
                      },
                    ),
                  ),
                ],
              ),
            ),
            Text(
              'Your Vouchers',
              style: Theme.of(context).textTheme.headline4!.copyWith(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
            ),
            BlocBuilder<VoucherBloc, VoucherState>(
              builder: (context, state) {
                if (state is VoucherLoading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is VoucherLoaded) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: state.vouchers.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.only(top: 5),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 30,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '3x',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                      color: Theme.of(context)
                                          .colorScheme
                                          .secondary),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: Text(
                                state.vouchers[index].code,
                                textAlign: TextAlign.left,
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                            TextButton(
                              style: TextButton.styleFrom(
                                visualDensity: VisualDensity.compact,
                              ),
                              onPressed: () {
                                context.read<VoucherBloc>().add(
                                      SelectVoucher(
                                          voucher: state.vouchers[index]),
                                    );
                                Navigator.of(context).pop();
                              },
                              child: Text('Apply'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Text('Something went wrong');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
