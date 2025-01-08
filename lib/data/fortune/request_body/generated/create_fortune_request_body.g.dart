// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../create_fortune_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateFortuneRequestBody _$CreateFortuneRequestBodyFromJson(
        Map<String, dynamic> json) =>
    CreateFortuneRequestBody(
      userId: json['user_id'] as String,
      birthDate: json['birth_date'] as String,
      birthTime: json['birth_time'] as String,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$CreateFortuneRequestBodyToJson(
        CreateFortuneRequestBody instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'birth_date': instance.birthDate,
      'birth_time': instance.birthTime,
      'gender': instance.gender,
    };
