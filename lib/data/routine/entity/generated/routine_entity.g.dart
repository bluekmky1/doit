// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../routine_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoutineEntity _$RoutineEntityFromJson(Map<String, dynamic> json) =>
    RoutineEntity(
      routineId: json['routine_id'] as String,
      routineTitle: json['routine_title'] as String,
      userId: json['user_id'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      isActive: json['is_active'] as bool,
    );

Map<String, dynamic> _$RoutineEntityToJson(RoutineEntity instance) =>
    <String, dynamic>{
      'routine_id': instance.routineId,
      'routine_title': instance.routineTitle,
      'user_id': instance.userId,
      'is_active': instance.isActive,
      'created_at': instance.createdAt.toIso8601String(),
    };
