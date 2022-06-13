import '../../models/models.dart';

abstract class BaseVoucherRepository {
  Future<bool> searchVoucher(String code);
  Stream<List<Voucher>> getVouchers();
}
