import 'package:equatable/equatable.dart';

import '../../../data/routine/entity/routine_entity.dart';

class RoutineModel extends Equatable {
  final String id;
  final String title;
  final bool isActive;

  const RoutineModel({
    required this.id,
    required this.title,
    this.isActive = true,
  });

  RoutineModel copyWith({
    String? id,
    String? title,
    bool? isActive,
  }) =>
      RoutineModel(
        id: id ?? this.id,
        title: title ?? this.title,
        isActive: isActive ?? this.isActive,
      );

  factory RoutineModel.fromEntity({
    required RoutineEntity entity,
  }) =>
      RoutineModel(
        id: entity.routineId,
        title: entity.routineTitle,
        isActive: entity.isActive,
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        isActive,
      ];
}
