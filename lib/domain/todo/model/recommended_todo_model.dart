import 'package:equatable/equatable.dart';

import '../../../data/todo/entity/recommend_todo_entity.dart';

class RecommendedTodoModel extends Equatable {
  final String id;
  final String content;
  final String category;
  final bool isAdded;
  final DateTime createdAt;

  const RecommendedTodoModel({
    required this.id,
    required this.content,
    required this.category,
    required this.isAdded,
    required this.createdAt,
  });

  factory RecommendedTodoModel.fromEntity({
    required RecommendTodoEntity entity,
  }) =>
      RecommendedTodoModel(
        id: entity.id,
        content: entity.content,
        category: entity.category,
        isAdded: entity.isAdded,
        createdAt: entity.createdAt,
      );

  RecommendedTodoModel copyWith({
    String? id,
    String? content,
    String? category,
    bool? isAdded,
    DateTime? createdAt,
  }) =>
      RecommendedTodoModel(
        id: id ?? this.id,
        content: content ?? this.content,
        category: category ?? this.category,
        isAdded: isAdded ?? this.isAdded,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        content,
        category,
        isAdded,
        createdAt,
      ];
}
