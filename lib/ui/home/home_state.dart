import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../domain/todo/model/recommended_todo_model.dart';
import '../../domain/todo/model/todo_model.dart';

class HomeState extends Equatable {
  final LoadingStatus getGoalLoadingStatus;
  final LoadingStatus getTodoListLoadingStatus;
  final LoadingStatus getRecommendedTodoListLoadingStatus;

  final DateTime currentWeekStart;
  final DateTime selectedDate;

  final String goalName;
  final List<TodoModel> todoList;
  final List<RecommendedTodoModel> recommendedTodoList;
  final bool isAddingTodo;

  const HomeState({
    required this.getGoalLoadingStatus,
    required this.getTodoListLoadingStatus,
    required this.getRecommendedTodoListLoadingStatus,
    required this.currentWeekStart,
    required this.selectedDate,
    required this.goalName,
    required this.todoList,
    required this.recommendedTodoList,
    required this.isAddingTodo,
  });

  HomeState.init()
      : getGoalLoadingStatus = LoadingStatus.none,
        getTodoListLoadingStatus = LoadingStatus.none,
        getRecommendedTodoListLoadingStatus = LoadingStatus.none,
        currentWeekStart =
            DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
        selectedDate = DateTime.now(),
        goalName = 'AAA',
        todoList = const <TodoModel>[],
        recommendedTodoList = const <RecommendedTodoModel>[],
        isAddingTodo = false;

  HomeState copyWith({
    LoadingStatus? getGoalLoadingStatus,
    LoadingStatus? getTodoListLoadingStatus,
    LoadingStatus? getRecommendedTodoListLoadingStatus,
    DateTime? currentWeekStart,
    DateTime? selectedDate,
    String? goalName,
    List<TodoModel>? todoList,
    List<RecommendedTodoModel>? recommendedTodoList,
    bool? isAddingTodo,
  }) =>
      HomeState(
        getGoalLoadingStatus: getGoalLoadingStatus ?? this.getGoalLoadingStatus,
        getTodoListLoadingStatus:
            getTodoListLoadingStatus ?? this.getTodoListLoadingStatus,
        getRecommendedTodoListLoadingStatus:
            getRecommendedTodoListLoadingStatus ??
                this.getRecommendedTodoListLoadingStatus,
        currentWeekStart: currentWeekStart ?? this.currentWeekStart,
        selectedDate: selectedDate ?? this.selectedDate,
        goalName: goalName ?? this.goalName,
        todoList: todoList ?? this.todoList,
        recommendedTodoList: recommendedTodoList ?? this.recommendedTodoList,
        isAddingTodo: isAddingTodo ?? this.isAddingTodo,
      );

  @override
  List<Object> get props => <Object>[
        getGoalLoadingStatus,
        getTodoListLoadingStatus,
        getRecommendedTodoListLoadingStatus,
        currentWeekStart,
        selectedDate,
        goalName,
        todoList,
        recommendedTodoList,
        isAddingTodo,
      ];
}
