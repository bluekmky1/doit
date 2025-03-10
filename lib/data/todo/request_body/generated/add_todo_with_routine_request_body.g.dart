// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../add_todo_with_routine_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTodoWithRoutineRequestBody _$AddTodoWithRoutineRequestBodyFromJson(
        Map<String, dynamic> json) =>
    AddTodoWithRoutineRequestBody(
      routineId: json['routine_id'] as String,
      userId: json['user_id'] as String,
      title: json['title'] as String,
      dueDate: DateTime.parse(json['due_date'] as String),
    );

Map<String, dynamic> _$AddTodoWithRoutineRequestBodyToJson(
        AddTodoWithRoutineRequestBody instance) =>
    <String, dynamic>{
      'routine_id': instance.routineId,
      'user_id': instance.userId,
      'title': instance.title,
      'due_date': instance.dueDate.toIso8601String(),
    };
