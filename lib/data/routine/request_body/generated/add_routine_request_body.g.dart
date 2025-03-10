// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../add_routine_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddRoutineRequestBody _$AddRoutineRequestBodyFromJson(
        Map<String, dynamic> json) =>
    AddRoutineRequestBody(
      userId: json['user_id'] as String,
      routineTitle: json['routine_title'] as String,
    );

Map<String, dynamic> _$AddRoutineRequestBodyToJson(
        AddRoutineRequestBody instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'routine_title': instance.routineTitle,
    };
