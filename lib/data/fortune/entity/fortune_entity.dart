import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'generated/fortune_entity.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
  explicitToJson: true,
)
class FortuneResponseEntity {
  final String userId;
  @JsonKey(fromJson: _fortuneFromJson)
  final FortuneEntity fortune;
  final DateTime createdAt;

  FortuneResponseEntity({
    required this.userId,
    required this.fortune,
    required this.createdAt,
  });

  // fortune 필드를 위한 커스텀 변환 메서드
  static FortuneEntity _fortuneFromJson(String fortuneStr) {
    final Map<String, dynamic> fortuneMap = json.decode(fortuneStr);
    return FortuneEntity.fromJson(fortuneMap);
  }

  factory FortuneResponseEntity.fromJson(Map<String, dynamic> json) =>
      _$FortuneResponseEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FortuneResponseEntityToJson(this);
}

@JsonSerializable()
class FortuneEntity {
  final String summary;
  final List<FortuneDetailEntity> details;

  FortuneEntity({
    required this.summary,
    required this.details,
  });

  factory FortuneEntity.fromJson(Map<String, dynamic> json) =>
      _$FortuneEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FortuneEntityToJson(this);
}

@JsonSerializable()
class FortuneDetailEntity {
  final String category;
  final String content;
  final int score;

  FortuneDetailEntity({
    required this.category,
    required this.content,
    required this.score,
  });

  factory FortuneDetailEntity.fromJson(Map<String, dynamic> json) =>
      _$FortuneDetailEntityFromJson(json);

  Map<String, dynamic> toJson() => _$FortuneDetailEntityToJson(this);
}
