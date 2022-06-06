import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'voucher_model.g.dart';

@HiveType(typeId: 3)
class Voucher extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String code;
  @HiveField(2)
  final double value;

  const Voucher({
    required this.id,
    required this.code,
    required this.value,
  });

  Voucher copyWith({
    String? id,
    String? code,
    double? value,
  }) {
    return Voucher(
      id: id ?? this.id,
      code: code ?? this.code,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'code': code,
      'value': value,
    };
  }

  factory Voucher.fromSnapshot(DocumentSnapshot snap) {
    return Voucher(
      id: snap.id,
      code: snap['code'],
      value: snap['value'].toDouble(),
    );
  }

  String toJson() => json.encode(toMap());

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, code, value];

  static List<Voucher> vouchers = [
    Voucher(id: '1', code: 'SAVE5', value: 5.0),
    Voucher(id: '2', code: 'SAVE10', value: 10.0),
    Voucher(id: '3', code: 'SAVE15', value: 15.0),
  ];
}
