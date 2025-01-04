import 'package:json_annotation/json_annotation.dart';

part 'generated/add_todo_request_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class AddTodoRequestBody {
  final String userId;
  final String title;
  final DateTime dueDate;

  AddTodoRequestBody({
    required this.userId,
    required this.title,
    required this.dueDate,
  });

  factory AddTodoRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddTodoRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddTodoRequestBodyToJson(this);
}
