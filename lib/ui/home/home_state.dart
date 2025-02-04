import 'package:equatable/equatable.dart';
import '../../../../core/loading_status.dart';
import '../../domain/routine/model/routine_model.dart';
import '../../domain/todo/model/todo_model.dart';

class HomeState extends Equatable {
  final LoadingStatus getGoalLoadingStatus;
  final LoadingStatus getTodoListLoadingStatus;
  final LoadingStatus addTodoLoadingStatus;
  final LoadingStatus deleteTodoLoadingStatus;
  final LoadingStatus toggleTodoDoneLoadingStatus;
  final LoadingStatus updateTodoLoadingStatus;
  final LoadingStatus getRoutineListLoadingStatus;
  final DateTime currentWeekStart;
  final DateTime selectedDate;

  final List<TodoModel> todoList;
  final List<RoutineModel> routineList;

  final bool isAddingTodo;

  final String lastToggledTodoId;
  final String lastDeletedTodoId;
  final String lastAddedTodoId;

  const HomeState({
    required this.getGoalLoadingStatus,
    required this.getTodoListLoadingStatus,
    required this.getRoutineListLoadingStatus,
    required this.addTodoLoadingStatus,
    required this.deleteTodoLoadingStatus,
    required this.toggleTodoDoneLoadingStatus,
    required this.updateTodoLoadingStatus,
    required this.currentWeekStart,
    required this.selectedDate,
    required this.todoList,
    required this.routineList,
    required this.isAddingTodo,
    required this.lastToggledTodoId,
    required this.lastDeletedTodoId,
    required this.lastAddedTodoId,
  });

  HomeState.init()
      : getGoalLoadingStatus = LoadingStatus.none,
        getTodoListLoadingStatus = LoadingStatus.none,
        getRoutineListLoadingStatus = LoadingStatus.none,
        addTodoLoadingStatus = LoadingStatus.none,
        deleteTodoLoadingStatus = LoadingStatus.none,
        toggleTodoDoneLoadingStatus = LoadingStatus.none,
        updateTodoLoadingStatus = LoadingStatus.none,
        currentWeekStart =
            DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1)),
        selectedDate = DateTime(
            DateTime.now().year, DateTime.now().month, DateTime.now().day),
        todoList = const <TodoModel>[],
        routineList = const <RoutineModel>[
          RoutineModel(
            id: '1',
            title: '루틴 1',
          ),
          RoutineModel(
            id: '2',
            title: '루틴 2',
          ),
          RoutineModel(
            id: '3',
            title: '루틴 3',
          ),
        ],
        isAddingTodo = false,
        lastToggledTodoId = '',
        lastDeletedTodoId = '',
        lastAddedTodoId = '';

  HomeState copyWith({
    LoadingStatus? getGoalLoadingStatus,
    LoadingStatus? getTodoListLoadingStatus,
    LoadingStatus? getRoutineListLoadingStatus,
    LoadingStatus? addTodoLoadingStatus,
    LoadingStatus? deleteTodoLoadingStatus,
    LoadingStatus? toggleTodoDoneLoadingStatus,
    LoadingStatus? updateTodoLoadingStatus,
    DateTime? currentWeekStart,
    DateTime? selectedDate,
    List<TodoModel>? todoList,
    List<RoutineModel>? routineList,
    bool? isAddingTodo,
    String? lastToggledTodoId,
    String? lastDeletedTodoId,
    String? lastAddedTodoId,
  }) =>
      HomeState(
        getGoalLoadingStatus: getGoalLoadingStatus ?? this.getGoalLoadingStatus,
        getTodoListLoadingStatus:
            getTodoListLoadingStatus ?? this.getTodoListLoadingStatus,
        getRoutineListLoadingStatus:
            getRoutineListLoadingStatus ?? this.getRoutineListLoadingStatus,
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
        routineList: routineList ?? this.routineList,
        isAddingTodo: isAddingTodo ?? this.isAddingTodo,
        lastToggledTodoId: lastToggledTodoId ?? this.lastToggledTodoId,
        lastDeletedTodoId: lastDeletedTodoId ?? this.lastDeletedTodoId,
        lastAddedTodoId: lastAddedTodoId ?? this.lastAddedTodoId,
      );

  @override
  List<Object> get props => <Object>[
        getGoalLoadingStatus,
        getTodoListLoadingStatus,
        getRoutineListLoadingStatus,
        addTodoLoadingStatus,
        deleteTodoLoadingStatus,
        toggleTodoDoneLoadingStatus,
        updateTodoLoadingStatus,
        currentWeekStart,
        selectedDate,
        todoList,
        routineList,
        isAddingTodo,
        lastToggledTodoId,
        lastDeletedTodoId,
        lastAddedTodoId,
      ];

  bool get isNotTodoLoading =>
      getTodoListLoadingStatus != LoadingStatus.loading;
}
