import 'package:equatable/equatable.dart';

class RoutineModel extends Equatable {
  final String id;
  final String title;

  const RoutineModel({
    required this.id,
    required this.title,
  });

  RoutineModel copyWith({
    String? id,
    String? title,
  }) =>
      RoutineModel(
        id: id ?? this.id,
        title: title ?? this.title,
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
      ];
}
