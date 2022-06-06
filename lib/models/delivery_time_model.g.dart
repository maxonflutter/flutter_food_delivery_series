// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'delivery_time_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class DeliveryTimeAdapter extends TypeAdapter<DeliveryTime> {
  @override
  final int typeId = 4;

  @override
  DeliveryTime read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DeliveryTime(
      id: fields[0] as String,
      value: fields[1] as String,
      time: fields[2] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, DeliveryTime obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.value)
      ..writeByte(2)
      ..write(obj.time);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DeliveryTimeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
