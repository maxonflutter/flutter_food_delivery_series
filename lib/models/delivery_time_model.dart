import 'package:equatable/equatable.dart';

class DeliveryTime extends Equatable {
  final int id;
  final String value;
  final DateTime time;

  DeliveryTime({
    required this.id,
    required this.value,
    required this.time,
  });

  @override
  List<Object?> get props => [id, value, time];

  static List<DeliveryTime> deliveryTimes = [
    DeliveryTime(
      id: 1,
      value: '08:00pm',
      time: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        20,
        0,
      ),
    ),
    DeliveryTime(
      id: 2,
      value: '08:30pm',
      time: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        20,
        30,
      ),
    ),
    DeliveryTime(
      id: 3,
      value: '09:00pm',
      time: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        21,
        0,
      ),
    ),
    DeliveryTime(
      id: 4,
      value: '09:30pm',
      time: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        21,
        30,
      ),
    ),
    DeliveryTime(
      id: 5,
      value: '10:00pm',
      time: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        22,
        0,
      ),
    ),
    DeliveryTime(
      id: 6,
      value: '10:30pm',
      time: DateTime(
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        22,
        30,
      ),
    ),
  ];
}
