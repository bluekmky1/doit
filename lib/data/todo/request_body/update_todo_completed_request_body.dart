import 'package:json_annotation/json_annotation.dart';

part 'generated/update_todo_completed_request_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UpdateTodoCompletedRequestBody {
  final bool isCompleted;
  final DateTime completedAt;

  UpdateTodoCompletedRequestBody({
    required this.isCompleted,
    required this.completedAt,
  });

  factory UpdateTodoCompletedRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateTodoCompletedRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTodoCompletedRequestBodyToJson(this);
}
