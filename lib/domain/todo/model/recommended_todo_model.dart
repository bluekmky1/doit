import 'package:equatable/equatable.dart';

class RecommendedTodoModel extends Equatable {
  final String id;
  final String title;
  final String fortune;
  final bool isDone;
  final DateTime createdAt;

  const RecommendedTodoModel({
    required this.id,
    required this.title,
    required this.fortune,
    required this.isDone,
    required this.createdAt,
  });

  // factory RecommendedTodoModel.fromEntity({
  //   required TodoEntity entity,
  // }) =>
  //     RecommendedTodoModel(
  //       id: entity.id,
  //       title: entity.title,
  //     );

  RecommendedTodoModel copyWith({
    String? id,
    String? title,
    String? fortune,
    bool? isDone,
    DateTime? createdAt,
  }) =>
      RecommendedTodoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        fortune: fortune ?? this.fortune,
        isDone: isDone ?? this.isDone,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        fortune,
        isDone,
        createdAt,
      ];
}
