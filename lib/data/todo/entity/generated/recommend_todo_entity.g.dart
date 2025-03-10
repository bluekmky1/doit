// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../recommend_todo_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RecommendTodoEntity _$RecommendTodoEntityFromJson(Map<String, dynamic> json) =>
    RecommendTodoEntity(
      id: json['id'] as String,
      content: json['content'] as String,
      category: json['category'] as String,
      isAdded: json['is_added'] as bool,
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$RecommendTodoEntityToJson(
        RecommendTodoEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'category': instance.category,
      'is_added': instance.isAdded,
      'created_at': instance.createdAt.toIso8601String(),
    };
