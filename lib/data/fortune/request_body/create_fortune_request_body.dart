import 'package:json_annotation/json_annotation.dart';

part 'generated/create_fortune_request_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class CreateFortuneRequestBody {
  final String userId;
  final String birthDate;
  final String birthTime;
  final String gender;
  final DateTime? createdAt;

  CreateFortuneRequestBody({
    required this.userId,
    required this.birthDate,
    required this.birthTime,
    required this.gender,
    this.createdAt,
  });

  factory CreateFortuneRequestBody.fromJson(Map<String, dynamic> json) =>
      _$CreateFortuneRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$CreateFortuneRequestBodyToJson(this);
}
