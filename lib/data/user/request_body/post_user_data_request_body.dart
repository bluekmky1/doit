import 'package:json_annotation/json_annotation.dart';

part 'generated/post_user_data_request_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class PostUserDataRequestBody {
  final String userId;
  final String nickname;
  final String gender;
  final String lunarSolar;
  final DateTime birthDate;
  final bool consent;
  final bool unknownBirthTime;

  PostUserDataRequestBody({
    required this.userId,
    required this.nickname,
    required this.gender,
    required this.lunarSolar,
    required this.birthDate,
    required this.consent,
    required this.unknownBirthTime,
  });

  factory PostUserDataRequestBody.fromJson(Map<String, dynamic> json) =>
      _$PostUserDataRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$PostUserDataRequestBodyToJson(this);
}
