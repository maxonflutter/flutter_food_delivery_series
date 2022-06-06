// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'basket_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BasketAdapter extends TypeAdapter<Basket> {
  @override
  final int typeId = 1;

  @override
  Basket read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Basket(
      products: (fields[0] as List).cast<Product>(),
      isCutlerySelected: fields[1] as bool,
      voucher: fields[2] as Voucher?,
      deliveryTime: fields[3] as DeliveryTime?,
    );
  }

  @override
  void write(BinaryWriter writer, Basket obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.products)
      ..writeByte(1)
      ..write(obj.isCutlerySelected)
      ..writeByte(2)
      ..write(obj.voucher)
      ..writeByte(3)
      ..write(obj.deliveryTime);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BasketAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
