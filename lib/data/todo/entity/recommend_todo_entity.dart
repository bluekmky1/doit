import 'package:json_annotation/json_annotation.dart';

part 'generated/recommend_todo_entity.g.dart';

@JsonSerializable(
  fieldRename: FieldRename.snake,
)
class RecommendTodoEntity {
  final String id;
  final String content;
  final String category;
  final bool isAdded;
  final DateTime createdAt;

  RecommendTodoEntity({
    required this.id,
    required this.content,
    required this.category,
    required this.isAdded,
    required this.createdAt,
  });

  factory RecommendTodoEntity.fromJson(Map<String, dynamic> json) =>
      _$RecommendTodoEntityFromJson(json);

  Map<String, dynamic> toJson() => _$RecommendTodoEntityToJson(this);
}
