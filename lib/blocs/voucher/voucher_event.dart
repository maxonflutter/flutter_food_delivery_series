part of 'voucher_bloc.dart';

abstract class VoucherEvent extends Equatable {
  const VoucherEvent();

  @override
  List<Object> get props => [];
}

class LoadVouchers extends VoucherEvent {}

class UpdateVouchers extends VoucherEvent {
  final List<Voucher> vouchers;

  UpdateVouchers({this.vouchers = const <Voucher>[]});

  @override
  List<Object> get props => [vouchers];
}

class SelectVoucher extends VoucherEvent {
  final Voucher voucher;

  SelectVoucher({required this.voucher});

  @override
  List<Object> get props => [voucher];
}
