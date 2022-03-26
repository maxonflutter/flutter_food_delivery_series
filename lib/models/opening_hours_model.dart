import 'package:equatable/equatable.dart';

class OpeningHours extends Equatable {
  final String id;
  final String day;
  final num openAt;
  final num closeAt;
  final bool isOpen;

  const OpeningHours({
    required this.id,
    required this.day,
    required this.openAt,
    required this.closeAt,
    required this.isOpen,
  });

  OpeningHours copyWith({
    String? id,
    String? day,
    double? openAt,
    double? closeAt,
    bool? isOpen,
  }) {
    return OpeningHours(
      id: id ?? this.id,
      day: day ?? this.day,
      openAt: openAt ?? this.openAt,
      closeAt: closeAt ?? this.closeAt,
      isOpen: isOpen ?? this.isOpen,
    );
  }

  Map<String, dynamic> toDocument() {
    return {
      'id': id,
      'day': day,
      'openAt': openAt,
      'closeAt': closeAt,
      'isOpen': isOpen,
    };
  }

  factory OpeningHours.fromSnapshot(Map<String, dynamic> snap) {
    return OpeningHours(
      id: snap['id'].toString(),
      day: snap['day'],
      openAt: snap['openAt'],
      closeAt: snap['closeAt'],
      isOpen: snap['isOpen'],
    );
  }

  @override
  List<Object?> get props => [id, day, openAt, closeAt, isOpen];
}
