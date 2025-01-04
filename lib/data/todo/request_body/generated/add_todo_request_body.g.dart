// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../add_todo_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTodoRequestBody _$AddTodoRequestBodyFromJson(Map<String, dynamic> json) =>
    AddTodoRequestBody(
      userId: json['user_id'] as String,
      title: json['title'] as String,
      dueDate: DateTime.parse(json['due_date'] as String),
    );

Map<String, dynamic> _$AddTodoRequestBodyToJson(AddTodoRequestBody instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'title': instance.title,
      'due_date': instance.dueDate.toIso8601String(),
    };
