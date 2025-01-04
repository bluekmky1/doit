import 'package:json_annotation/json_annotation.dart';

part 'generated/update_user_data_request_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UpdateUserDataRequestBody {
  final String userId;
  final String nickname;
  final String gender;
  final String lunarSolar;
  final DateTime birthDate;
  final bool consent;
  final bool unknownBirthTime;

  UpdateUserDataRequestBody({
    required this.userId,
    required this.nickname,
    required this.gender,
    required this.lunarSolar,
    required this.birthDate,
    required this.consent,
    required this.unknownBirthTime,
  });

  factory UpdateUserDataRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateUserDataRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateUserDataRequestBodyToJson(this);
}
