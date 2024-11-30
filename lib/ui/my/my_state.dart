import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../domain/todo/model/recommended_todo_model.dart';
import '../../domain/todo/model/todo_model.dart';

class MyState extends Equatable {
  final LoadingStatus getTodoListLoadingStatus;
  final LoadingStatus getRecommendedTodoListLoadingStatus;
  final List<TodoModel> todoList;
  final List<RecommendedTodoModel> recommendedTodoList;

  const MyState({
    required this.getTodoListLoadingStatus,
    required this.getRecommendedTodoListLoadingStatus,
    required this.todoList,
    required this.recommendedTodoList,
  });

  const MyState.init()
      : getTodoListLoadingStatus = LoadingStatus.none,
        getRecommendedTodoListLoadingStatus = LoadingStatus.none,
        todoList = const <TodoModel>[],
        recommendedTodoList = const <RecommendedTodoModel>[];

  MyState copyWith({
    LoadingStatus? getTodoListLoadingStatus,
    LoadingStatus? getRecommendedTodoListLoadingStatus,
    List<TodoModel>? todoList,
    List<RecommendedTodoModel>? recommendedTodoList,
  }) =>
      MyState(
        getTodoListLoadingStatus:
            getTodoListLoadingStatus ?? this.getTodoListLoadingStatus,
        getRecommendedTodoListLoadingStatus:
            getRecommendedTodoListLoadingStatus ??
                this.getRecommendedTodoListLoadingStatus,
        todoList: todoList ?? this.todoList,
        recommendedTodoList: recommendedTodoList ?? this.recommendedTodoList,
      );

  @override
  List<Object> get props => <Object>[
        getTodoListLoadingStatus,
        getRecommendedTodoListLoadingStatus,
        todoList,
        recommendedTodoList,
      ];
}
