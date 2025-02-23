import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/common/use_case/use_case_result.dart';
import '../../../../core/loading_status.dart';
import '../../domain/routine/model/routine_model.dart';
import '../../domain/routine/use_case/get_active_routine_list_use_case.dart';
import '../../domain/todo/model/todo_model.dart';
import '../../domain/todo/use_case/add_todo_use_case.dart';
import '../../domain/todo/use_case/add_todo_with_routine_use_case.dart';
import '../../domain/todo/use_case/delete_recommend_todo_from_todo_list_use_case.dart';
import '../../domain/todo/use_case/delete_todo_use_case.dart';
import '../../domain/todo/use_case/get_todo_list_with_date_use_case.dart';
import '../../domain/todo/use_case/update_todo_completed_use_case.dart';
import '../../domain/todo/use_case/update_todo_use_case.dart';
import '../../service/supabase/supabase_service.dart';
import 'home_state.dart';

final AutoDisposeStateNotifierProvider<HomeViewModel, HomeState>
    homeViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => HomeViewModel(
    state: HomeState.init(),
    getTodoListWithDateUseCase: ref.watch(getTodoListWithDateUseCaseProvider),
    supabaseClient: ref.watch(supabaseServiceProvider),
    addTodoUseCase: ref.watch(addTodoUseCaseProvider),
    addTodoWithRoutineUseCase: ref.watch(addTodoWithRoutineUseCaseProvider),
    deleteTodoUseCase: ref.watch(deleteTodoUseCaseProvider),
    updateTodoUseCase: ref.watch(updateTodoUseCaseProvider),
    updateTodoCompletedUseCase: ref.watch(updateTodoCompletedUseCaseProvider),
    getActiveRoutineListUseCase: ref.watch(getActiveRoutineListUseCaseProvider),
    deleteRecommendTodoFromTodoListUseCase: ref.watch(
      deleteRecommendTodoFromTodoListUseCaseProvider,
    ),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final GetTodoListWithDateUseCase _getTodoListWithDateUseCase;
  final AddTodoUseCase _addTodoUseCase;
  final AddTodoWithRoutineUseCase _addTodoWithRoutineUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final UpdateTodoCompletedUseCase _updateTodoCompletedUseCase;
  final GetActiveRoutineListUseCase _getActiveRoutineListUseCase;
  final DeleteRecommendTodoFromTodoListUseCase
      _deleteRecommendTodoFromTodoListUseCase;

  final SupabaseClient _supabaseClient;
  HomeViewModel({
    required HomeState state,
    required GetTodoListWithDateUseCase getTodoListWithDateUseCase,
    required SupabaseClient supabaseClient,
    required AddTodoUseCase addTodoUseCase,
    required AddTodoWithRoutineUseCase addTodoWithRoutineUseCase,
    required DeleteTodoUseCase deleteTodoUseCase,
    required UpdateTodoUseCase updateTodoUseCase,
    required UpdateTodoCompletedUseCase updateTodoCompletedUseCase,
    required GetActiveRoutineListUseCase getActiveRoutineListUseCase,
    required DeleteRecommendTodoFromTodoListUseCase
        deleteRecommendTodoFromTodoListUseCase,
  })  : _getTodoListWithDateUseCase = getTodoListWithDateUseCase,
        _deleteRecommendTodoFromTodoListUseCase =
            deleteRecommendTodoFromTodoListUseCase,
        _supabaseClient = supabaseClient,
        _addTodoUseCase = addTodoUseCase,
        _addTodoWithRoutineUseCase = addTodoWithRoutineUseCase,
        _deleteTodoUseCase = deleteTodoUseCase,
        _updateTodoUseCase = updateTodoUseCase,
        _updateTodoCompletedUseCase = updateTodoCompletedUseCase,
        _getActiveRoutineListUseCase = getActiveRoutineListUseCase,
        super(state);

  void init() {
    getTodoListWithDate(targetDate: state.selectedDate);
    getActiveRoutineList();
  }

  // 할 일 목록 조회
  // TODO(jaehoon): 추후 할 일 목록 조회 시 일주일 단위로 조회하도록 변경
  Future<void> getTodoListWithDate({
    required DateTime targetDate,
  }) async {
    state = state.copyWith(
      getTodoListLoadingStatus: LoadingStatus.loading,
    );

    final DateTime dueDate = DateTime(
      targetDate.year,
      targetDate.month,
      targetDate.day,
    );

    final UseCaseResult<List<TodoModel>> result =
        await _getTodoListWithDateUseCase(
      userId: _supabaseClient.auth.currentUser!.id,
      dueDate: dueDate,
    );

    switch (result) {
      case SuccessUseCaseResult<List<TodoModel>>():
        state = state.copyWith(
          todoList: result.data,
          getTodoListLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<List<TodoModel>>():
        state = state.copyWith(
          getTodoListLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> addTodo({
    required String todo,
  }) async {
    state = state.copyWith(
      addTodoLoadingStatus: LoadingStatus.loading,
    );

    final DateTime dueDate = DateTime(
      state.selectedDate.year,
      state.selectedDate.month,
      state.selectedDate.day,
    );

    final UseCaseResult<TodoModel> result = await _addTodoUseCase(
      userId: _supabaseClient.auth.currentUser!.id,
      dueDate: dueDate,
      title: todo,
    );

    switch (result) {
      case SuccessUseCaseResult<TodoModel>():
        state = state.copyWith(
          todoList: <TodoModel>[...state.todoList, result.data],
          lastAddedTodoId: result.data.todoId,
          addTodoLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<TodoModel>():
        state = state.copyWith(
          addTodoLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> toggleTodoDone({required String id}) async {
    final TodoModel targetTodo = state.todoList.firstWhere(
      (TodoModel e) => e.todoId == id,
    );
    final bool newCompletedStatus = !targetTodo.isCompleted;

    state = state.copyWith(
      toggleTodoDoneLoadingStatus: LoadingStatus.loading,
      todoList: state.todoList
          .map((TodoModel e) =>
              e.todoId == id ? e.copyWith(isCompleted: newCompletedStatus) : e)
          .toList(),
      lastToggledTodoId: id,
    );
    final DateTime completedAt = DateTime.now();

    final UseCaseResult<void> result = await _updateTodoCompletedUseCase(
      todoId: id,
      completed: newCompletedStatus,
      completedAt: DateTime(
        completedAt.year,
        completedAt.month,
        completedAt.day,
      ),
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          toggleTodoDoneLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<void>():
        state = state.copyWith(
          toggleTodoDoneLoadingStatus: LoadingStatus.error,
          todoList: state.todoList
              .map((TodoModel e) => e.todoId == id
                  ? e.copyWith(isCompleted: targetTodo.isCompleted)
                  : e)
              .toList(),
        );
    }
  }

  Future<void> deleteTodo({required String id}) async {
    state = state.copyWith(
      deleteTodoLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<void> result = await _deleteTodoUseCase(todoId: id);
    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          deleteTodoLoadingStatus: LoadingStatus.success,
          todoList:
              state.todoList.where((TodoModel e) => e.todoId != id).toList(),
          lastDeletedTodoId: id,
        );
      case FailureUseCaseResult<void>():
        state = state.copyWith(
          deleteTodoLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> updateTodo({required String id, required String title}) async {
    state = state.copyWith(
      updateTodoLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<void> result = await _updateTodoUseCase(
      todoId: id,
      title: title,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          todoList: state.todoList
              .map(
                (TodoModel e) => e.todoId == id
                    ? e.copyWith(
                        title: title,
                      )
                    : e,
              )
              .toList(),
          updateTodoLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<void>():
        state = state.copyWith(
          updateTodoLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> getActiveRoutineList() async {
    state = state.copyWith(
      getRoutineListLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<List<RoutineModel>> result =
        await _getActiveRoutineListUseCase(
      userId: _supabaseClient.auth.currentUser!.id,
    );

    switch (result) {
      case SuccessUseCaseResult<List<RoutineModel>>():
        state = state.copyWith(
          routineList: result.data,
          getRoutineListLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<List<RoutineModel>>():
        state = state.copyWith(
          getRoutineListLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> addTodoWithRoutine({
    required String todo,
    required String routineId,
  }) async {
    state = state.copyWith(
      addTodoLoadingStatus: LoadingStatus.loading,
    );

    final DateTime dueDate = DateTime(
      state.selectedDate.year,
      state.selectedDate.month,
      state.selectedDate.day,
    );

    final UseCaseResult<TodoModel> result = await _addTodoWithRoutineUseCase(
      userId: _supabaseClient.auth.currentUser!.id,
      routineId: routineId,
      dueDate: dueDate,
      title: todo,
    );

    switch (result) {
      case SuccessUseCaseResult<TodoModel>():
        state = state.copyWith(
          todoList: <TodoModel>[...state.todoList, result.data],
          lastAddedTodoId: result.data.todoId,
          addTodoLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<TodoModel>():
        state = state.copyWith(
          addTodoLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> deleteRecommendTodoFromTodoList({
    required String todoId,
    required String recommendId,
  }) async {
    state = state.copyWith(
      deleteRecommendTodoFromTodoListLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<void> result =
        await _deleteRecommendTodoFromTodoListUseCase(
      recommendId: recommendId,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          deleteRecommendTodoFromTodoListLoadingStatus: LoadingStatus.success,
          todoList: state.todoList
              .where((TodoModel e) => e.todoId != todoId)
              .toList(),
          lastDeletedTodoId: todoId,
        );
      case FailureUseCaseResult<void>():
        state = state.copyWith(
          deleteRecommendTodoFromTodoListLoadingStatus: LoadingStatus.error,
        );
    }
  }

  void setIsAddingTodo({required bool value}) {
    state = state.copyWith(
      isAddingTodo: value,
    );
  }

  void moveToNextWeek() {
    state = state.copyWith(
      currentWeekStart: state.currentWeekStart.add(const Duration(days: 7)),
    );
  }

  void moveToToday() {
    final DateTime today = DateTime.now();
    final DateTime selectedDate = DateTime(today.year, today.month, today.day);

    setSelectedDate(date: selectedDate);

    final DateTime weekStart = state.currentWeekStart;
    final DateTime weekEnd = weekStart.add(const Duration(days: 6));

    if (selectedDate.isBefore(weekStart) || selectedDate.isAfter(weekEnd)) {
      final int diff = selectedDate.weekday - 1;
      final DateTime newWeekStart = selectedDate.subtract(Duration(days: diff));
      setCurrentWeekStart(date: newWeekStart);
    }
  }

  void moveToPreviousWeek() {
    state = state.copyWith(
      currentWeekStart:
          state.currentWeekStart.subtract(const Duration(days: 7)),
    );
  }

  void setSelectedDate({required DateTime date}) {
    final DateTime formattedDate = DateTime(
      date.year,
      date.month,
      date.day,
    );

    state = state.copyWith(
      selectedDate: formattedDate,
    );
  }

  void setCurrentWeekStart({required DateTime date}) {
    state = state.copyWith(
      currentWeekStart: date,
    );
  }
}
