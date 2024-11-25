import 'package:equatable/equatable.dart';

class TodoModel extends Equatable {
  final String id;
  final String title;
  final bool isDone;
  final DateTime createdAt;

  const TodoModel({
    required this.id,
    required this.title,
    required this.isDone,
    required this.createdAt,
  });

  // factory TodoModel.fromEntity({
  //   required TodoEntity entity,
  // }) =>
  //     TodoModel(
  //       id: entity.id,
  //       title: entity.title,
  //     );

  TodoModel copyWith({
    String? id,
    String? title,
    bool? isDone,
    DateTime? createdAt,
  }) =>
      TodoModel(
        id: id ?? this.id,
        title: title ?? this.title,
        isDone: isDone ?? this.isDone,
        createdAt: createdAt ?? this.createdAt,
      );

  @override
  List<Object?> get props => <Object?>[
        id,
        title,
        isDone,
        createdAt,
      ];
}
