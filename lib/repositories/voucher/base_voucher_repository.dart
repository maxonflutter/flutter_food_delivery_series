import 'package:flutter_food_delivery_app/models/models.dart';

abstract class BaseVoucherRepository {
  Future<bool> searchVoucher(String code);
  Stream<List<Voucher>> getVouchers();
}
