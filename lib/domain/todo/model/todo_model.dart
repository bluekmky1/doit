import 'package:equatable/equatable.dart';

import '../../../data/todo/entity/todo_entity.dart';

class TodoModel extends Equatable {
  final String todoId;
  final String animalId;
  final String animalName;
  final String title;
  final String routineId;
  final bool isCompleted;
  final DateTime dueDate;
  final DateTime? completedAt;

  const TodoModel({
    required this.todoId,
    required this.animalId,
    required this.animalName,
    required this.title,
    required this.routineId,
    required this.isCompleted,
    required this.dueDate,
    required this.completedAt,
  });

  factory TodoModel.fromEntity({
    required TodoEntity entity,
  }) =>
      TodoModel(
        todoId: entity.todoId,
        animalId: entity.animalId,
        animalName: entity.animal.name,
        title: entity.title,
        routineId: entity.routineId ?? '',
        isCompleted: entity.isCompleted,
        dueDate: entity.dueDate,
        completedAt: entity.completedAt,
      );

  TodoModel copyWith({
    String? todoId,
    String? animalId,
    String? animalName,
    String? title,
    String? routineId,
    bool? isCompleted,
    DateTime? dueDate,
    DateTime? completedAt,
  }) =>
      TodoModel(
        todoId: todoId ?? this.todoId,
        animalId: animalId ?? this.animalId,
        animalName: animalName ?? this.animalName,
        title: title ?? this.title,
        routineId: routineId ?? this.routineId,
        isCompleted: isCompleted ?? this.isCompleted,
        dueDate: dueDate ?? this.dueDate,
        completedAt: completedAt ?? this.completedAt,
      );

  @override
  List<Object?> get props => <Object?>[
        todoId,
        animalId,
        animalName,
        title,
        routineId,
        isCompleted,
        dueDate,
        completedAt,
      ];
}
