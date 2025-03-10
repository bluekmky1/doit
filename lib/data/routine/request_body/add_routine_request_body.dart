import 'package:json_annotation/json_annotation.dart';

part 'generated/add_routine_request_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class AddRoutineRequestBody {
  final String userId;
  final String routineTitle;

  AddRoutineRequestBody({
    required this.userId,
    required this.routineTitle,
  });

  factory AddRoutineRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddRoutineRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddRoutineRequestBodyToJson(this);
}
