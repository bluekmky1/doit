// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../add_todo_by_recommend_reqest_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddTodoByRecommendRequestBody _$AddTodoByRecommendRequestBodyFromJson(
        Map<String, dynamic> json) =>
    AddTodoByRecommendRequestBody(
      userId: json['user_id'] as String,
      title: json['title'] as String,
      recommendId: json['recommend_id'] as String,
      dueDate: DateTime.parse(json['due_date'] as String),
    );

Map<String, dynamic> _$AddTodoByRecommendRequestBodyToJson(
        AddTodoByRecommendRequestBody instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'title': instance.title,
      'recommend_id': instance.recommendId,
      'due_date': instance.dueDate.toIso8601String(),
    };
