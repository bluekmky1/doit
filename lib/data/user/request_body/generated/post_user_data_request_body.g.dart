// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../post_user_data_request_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PostUserDataRequestBody _$PostUserDataRequestBodyFromJson(
        Map<String, dynamic> json) =>
    PostUserDataRequestBody(
      userId: json['user_id'] as String,
      nickname: json['nickname'] as String,
      gender: json['gender'] as String,
      lunarSolar: json['lunar_solar'] as String,
      birthDate: DateTime.parse(json['birth_date'] as String),
      consent: json['consent'] as bool,
      unknownBirthTime: json['unknown_birth_time'] as bool,
    );

Map<String, dynamic> _$PostUserDataRequestBodyToJson(
        PostUserDataRequestBody instance) =>
    <String, dynamic>{
      'user_id': instance.userId,
      'nickname': instance.nickname,
      'gender': instance.gender,
      'lunar_solar': instance.lunarSolar,
      'birth_date': instance.birthDate.toIso8601String(),
      'consent': instance.consent,
      'unknown_birth_time': instance.unknownBirthTime,
    };
