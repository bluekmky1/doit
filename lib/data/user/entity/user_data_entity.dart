import 'package:json_annotation/json_annotation.dart';

part 'generated/user_data_entity.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UserDataEntity {
  final String userId;
  final String nickname;
  final String gender;
  final String lunarSolar;
  final DateTime birthDate;
  final bool consent;
  final bool unknownBirthTime;

  UserDataEntity({
    required this.userId,
    required this.nickname,
    required this.gender,
    required this.lunarSolar,
    required this.birthDate,
    required this.consent,
    required this.unknownBirthTime,
  });

  factory UserDataEntity.fromJson(Map<String, dynamic> json) =>
      _$UserDataEntityFromJson(json);

  Map<String, dynamic> toJson() => _$UserDataEntityToJson(this);
}
