import 'package:json_annotation/json_annotation.dart';

part 'generated/update_routine_active_request_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UpdateRoutineActiveRequestBody {
  final bool isActive;

  UpdateRoutineActiveRequestBody({
    required this.isActive,
  });

  factory UpdateRoutineActiveRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateRoutineActiveRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateRoutineActiveRequestBodyToJson(this);
}
