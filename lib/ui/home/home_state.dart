import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../domain/todo/model/todo_model.dart';

class HomeState extends Equatable {
  final LoadingStatus getGoalLoadingStatus;
  final LoadingStatus getTodoListLoadingStatus;
  final LoadingStatus getRecommendedTodoListLoadingStatus;
  final LoadingStatus addTodoLoadingStatus;
  final LoadingStatus deleteTodoLoadingStatus;
  final LoadingStatus toggleTodoDoneLoadingStatus;
  final LoadingStatus updateTodoLoadingStatus;
  final DateTime currentWeekStart;
  final DateTime selectedDate;

  final List<TodoModel> todoList;
  final List<TodoModel> todayCompletedTodoList;

  final bool isAddingTodo;

  const HomeState({
    required this.getGoalLoadingStatus,
    required this.getTodoListLoadingStatus,
    required this.getRecommendedTodoListLoadingStatus,
    required this.addTodoLoadingStatus,
    required this.deleteTodoLoadingStatus,
    required this.toggleTodoDoneLoadingStatus,
    required this.updateTodoLoadingStatus,
    required this.currentWeekStart,
    required this.selectedDate,
    required this.todoList,
    required this.todayCompletedTodoList,
    required this.isAddingTodo,
  });

  HomeState.init()
      : getGoalLoadingStatus = LoadingStatus.none,
        getTodoListLoadingStatus = LoadingStatus.none,
        getRecommendedTodoListLoadingStatus = LoadingStatus.none,
        addTodoLoadingStatus = LoadingStatus.none,
        deleteTodoLoadingStatus = LoadingStatus.none,
        toggleTodoDoneLoadingStatus = LoadingStatus.none,
        updateTodoLoadingStatus = LoadingStatus.none,
        currentWeekStart =
            DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
        selectedDate = DateTime.now(),
        todoList = const <TodoModel>[],
        todayCompletedTodoList = const <TodoModel>[],
        isAddingTodo = false;

  HomeState copyWith({
    LoadingStatus? getGoalLoadingStatus,
    LoadingStatus? getTodoListLoadingStatus,
    LoadingStatus? getRecommendedTodoListLoadingStatus,
    LoadingStatus? addTodoLoadingStatus,
    LoadingStatus? deleteTodoLoadingStatus,
    LoadingStatus? toggleTodoDoneLoadingStatus,
    LoadingStatus? updateTodoLoadingStatus,
    DateTime? currentWeekStart,
    DateTime? selectedDate,
    List<TodoModel>? todoList,
    List<TodoModel>? todayCompletedTodoList,
    bool? isAddingTodo,
  }) =>
      HomeState(
        getGoalLoadingStatus: getGoalLoadingStatus ?? this.getGoalLoadingStatus,
        getTodoListLoadingStatus:
            getTodoListLoadingStatus ?? this.getTodoListLoadingStatus,
        getRecommendedTodoListLoadingStatus:
            getRecommendedTodoListLoadingStatus ??
                this.getRecommendedTodoListLoadingStatus,
        addTodoLoadingStatus: addTodoLoadingStatus ?? this.addTodoLoadingStatus,
        deleteTodoLoadingStatus:
            deleteTodoLoadingStatus ?? this.deleteTodoLoadingStatus,
        toggleTodoDoneLoadingStatus:
            toggleTodoDoneLoadingStatus ?? this.toggleTodoDoneLoadingStatus,
        updateTodoLoadingStatus:
            updateTodoLoadingStatus ?? this.updateTodoLoadingStatus,
        currentWeekStart: currentWeekStart ?? this.currentWeekStart,
        selectedDate: selectedDate ?? this.selectedDate,
        todoList: todoList ?? this.todoList,
        todayCompletedTodoList:
            todayCompletedTodoList ?? this.todayCompletedTodoList,
        isAddingTodo: isAddingTodo ?? this.isAddingTodo,
      );

  @override
  List<Object> get props => <Object>[
        getGoalLoadingStatus,
        getTodoListLoadingStatus,
        getRecommendedTodoListLoadingStatus,
        addTodoLoadingStatus,
        deleteTodoLoadingStatus,
        toggleTodoDoneLoadingStatus,
        updateTodoLoadingStatus,
        currentWeekStart,
        selectedDate,
        todoList,
        todayCompletedTodoList,
        isAddingTodo,
      ];

  bool get isNotTodoLoading =>
      getTodoListLoadingStatus != LoadingStatus.loading;
}
