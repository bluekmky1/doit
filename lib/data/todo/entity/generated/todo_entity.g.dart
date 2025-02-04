// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../todo_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TodoEntity _$TodoEntityFromJson(Map<String, dynamic> json) => TodoEntity(
      todoId: json['todo_id'] as String,
      userId: json['user_id'] as String,
      animalId: json['animal_id'] as String,
      routineId: json['routine_id'] as String?,
      animal: TodoAnimalEntity.fromJson(json['animal'] as Map<String, dynamic>),
      title: json['title'] as String,
      isCompleted: json['is_completed'] as bool,
      dueDate: DateTime.parse(json['due_date'] as String),
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
    );

Map<String, dynamic> _$TodoEntityToJson(TodoEntity instance) =>
    <String, dynamic>{
      'todo_id': instance.todoId,
      'user_id': instance.userId,
      'animal_id': instance.animalId,
      'routine_id': instance.routineId,
      'animal': instance.animal,
      'title': instance.title,
      'is_completed': instance.isCompleted,
      'due_date': instance.dueDate.toIso8601String(),
      'completed_at': instance.completedAt?.toIso8601String(),
    };

TodoAnimalEntity _$TodoAnimalEntityFromJson(Map<String, dynamic> json) =>
    TodoAnimalEntity(
      name: json['name'] as String,
    );

Map<String, dynamic> _$TodoAnimalEntityToJson(TodoAnimalEntity instance) =>
    <String, dynamic>{
      'name': instance.name,
    };
