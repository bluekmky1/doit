import 'package:json_annotation/json_annotation.dart';

part 'generated/supabase_entity.g.dart';

@JsonSerializable()
class SupabaseEntity {
  final int id;
  final String title;
  final String description;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'updated_at')
  final DateTime? updatedAt;
  @JsonKey(name: 'is_active', defaultValue: false)
  final bool isActive;
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  SupabaseEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
    this.updatedAt,
    this.isActive = false,
    this.imageUrl,
  });

  factory SupabaseEntity.fromJson(Map<String, dynamic> json) =>
      _$SupabaseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$SupabaseEntityToJson(this);
}
