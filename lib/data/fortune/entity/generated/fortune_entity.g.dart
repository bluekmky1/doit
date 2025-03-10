// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../fortune_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FortuneResponseEntity _$FortuneResponseEntityFromJson(
        Map<String, dynamic> json) =>
    FortuneResponseEntity(
      userId: json['user_id'] as String,
      fortune:
          FortuneResponseEntity._fortuneFromJson(json['fortune'] as String),
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$FortuneResponseEntityToJson(
        FortuneResponseEntity instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'fortune': instance.fortune.toJson(),
      'created_at': instance.createdAt.toIso8601String(),
    };

FortuneEntity _$FortuneEntityFromJson(Map<String, dynamic> json) =>
    FortuneEntity(
      summary: json['summary'] as String,
      details: (json['details'] as List<dynamic>)
          .map((e) => FortuneDetailEntity.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FortuneEntityToJson(FortuneEntity instance) =>
    <String, dynamic>{
      'summary': instance.summary,
      'details': instance.details,
    };

FortuneDetailEntity _$FortuneDetailEntityFromJson(Map<String, dynamic> json) =>
    FortuneDetailEntity(
      category: json['category'] as String,
      content: json['content'] as String,
      score: (json['score'] as num).toInt(),
    );

Map<String, dynamic> _$FortuneDetailEntityToJson(
        FortuneDetailEntity instance) =>
    <String, dynamic>{
      'category': instance.category,
      'content': instance.content,
      'score': instance.score,
    };
