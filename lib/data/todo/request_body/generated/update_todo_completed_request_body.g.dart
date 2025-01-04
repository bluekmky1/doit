// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../update_todo_completed_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTodoCompletedRequestBody _$UpdateTodoCompletedRequestBodyFromJson(
        Map<String, dynamic> json) =>
    UpdateTodoCompletedRequestBody(
      isCompleted: json['is_completed'] as bool,
      completedAt: DateTime.parse(json['completed_at'] as String),
    );

Map<String, dynamic> _$UpdateTodoCompletedRequestBodyToJson(
        UpdateTodoCompletedRequestBody instance) =>
    <String, dynamic>{
      'is_completed': instance.isCompleted,
      'completed_at': instance.completedAt.toIso8601String(),
    };
