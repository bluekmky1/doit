import 'package:json_annotation/json_annotation.dart';

part 'generated/routine_entity.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class RoutineEntity {
  final String routineId;
  final String routineTitle;
  final String userId;
  final bool isActive;
  final DateTime createdAt;

  RoutineEntity({
    required this.routineId,
    required this.routineTitle,
    required this.userId,
    required this.createdAt,
    required this.isActive,
  });

  factory RoutineEntity.fromJson(Map<String, dynamic> json) =>
      _$RoutineEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RoutineEntityToJson(this);
}
