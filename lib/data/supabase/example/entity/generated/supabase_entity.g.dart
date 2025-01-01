// GENERATED CODE - DO NOT MODIFY BY HAND

part of '../supabase_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SupabaseEntity _$SupabaseEntityFromJson(Map<String, dynamic> json) =>
    SupabaseEntity(
      id: (json['id'] as num).toInt(),
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      isActive: json['is_active'] as bool? ?? false,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$SupabaseEntityToJson(SupabaseEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'created_at': instance.createdAt.toIso8601String(),
      'updated_at': instance.updatedAt?.toIso8601String(),
      'is_active': instance.isActive,
      'image_url': instance.imageUrl,
    };
