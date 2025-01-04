import 'package:json_annotation/json_annotation.dart';

part 'generated/update_todo_request_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class UpdateTodoRequestBody {
  final String title;

  UpdateTodoRequestBody({
    required this.title,
  });

  factory UpdateTodoRequestBody.fromJson(Map<String, dynamic> json) =>
      _$UpdateTodoRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTodoRequestBodyToJson(this);
}
