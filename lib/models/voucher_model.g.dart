// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voucher_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class VoucherAdapter extends TypeAdapter<Voucher> {
  @override
  final int typeId = 3;

  @override
  Voucher read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Voucher(
      id: fields[0] as String,
      code: fields[1] as String,
      value: fields[2] as double,
    );
  }

  @override
  void write(BinaryWriter writer, Voucher obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.value);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VoucherAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
