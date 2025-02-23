import 'package:json_annotation/json_annotation.dart';

part 'generated/add_todo_by_recommend_reqest_body.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class AddTodoByRecommendRequestBody {
  final String userId;
  final String title;
  final String recommendId;
  final DateTime dueDate;

  AddTodoByRecommendRequestBody({
    required this.userId,
    required this.title,
    required this.recommendId,
    required this.dueDate,
  });

  factory AddTodoByRecommendRequestBody.fromJson(Map<String, dynamic> json) =>
      _$AddTodoByRecommendRequestBodyFromJson(json);

  Map<String, dynamic> toJson() => _$AddTodoByRecommendRequestBodyToJson(this);
}
