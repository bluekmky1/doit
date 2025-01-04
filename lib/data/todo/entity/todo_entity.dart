import 'package:json_annotation/json_annotation.dart';

part 'generated/todo_entity.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class TodoEntity {
  final String todoId;
  final String userId;
  final String animalId;
  final TodoAnimalEntity animal;
  final String title;
  final bool isCompleted;
  final DateTime dueDate;
  final DateTime? completedAt;

  TodoEntity({
    required this.todoId,
    required this.userId,
    required this.animalId,
    required this.animal,
    required this.title,
    required this.isCompleted,
    required this.dueDate,
    required this.completedAt,
  });

  factory TodoEntity.fromJson(Map<String, dynamic> json) =>
      _$TodoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TodoEntityToJson(this);
}

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class TodoAnimalEntity {
  final String name;

  TodoAnimalEntity({
    required this.name,
  });

  factory TodoAnimalEntity.fromJson(Map<String, dynamic> json) =>
      _$TodoAnimalEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TodoAnimalEntityToJson(this);
}
