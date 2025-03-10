import 'package:json_annotation/json_annotation.dart';
part 'generated/add_todo_with_routine_request_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class AddTodoWithRoutineRequestBody {
  final String routineId;
  final String userId;
  final String title;
  final DateTime dueDate;

  AddTodoWithRoutineRequestBody({
    required this.routineId,
    required this.userId,
    required this.title,
    required this.dueDate,
  });

  factory AddTodoWithRoutineRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddTodoWithRoutineRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddTodoWithRoutineRequestBodyToJson(this);
}
