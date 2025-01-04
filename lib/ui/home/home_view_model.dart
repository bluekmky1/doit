import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/common/use_case/use_case_result.dart';
import '../../../../core/loading_status.dart';
import '../../domain/todo/model/todo_model.dart';
import '../../domain/todo/use_case/add_todo_use_case.dart';
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
    deleteTodoUseCase: ref.watch(deleteTodoUseCaseProvider),
    updateTodoUseCase: ref.watch(updateTodoUseCaseProvider),
    updateTodoCompletedUseCase: ref.watch(updateTodoCompletedUseCaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final GetTodoListWithDateUseCase _getTodoListWithDateUseCase;
  final AddTodoUseCase _addTodoUseCase;
  final DeleteTodoUseCase _deleteTodoUseCase;
  final UpdateTodoUseCase _updateTodoUseCase;
  final UpdateTodoCompletedUseCase _updateTodoCompletedUseCase;
  final SupabaseClient _supabaseClient;
  HomeViewModel({
    required HomeState state,
    required GetTodoListWithDateUseCase getTodoListWithDateUseCase,
    required SupabaseClient supabaseClient,
    required AddTodoUseCase addTodoUseCase,
    required DeleteTodoUseCase deleteTodoUseCase,
    required UpdateTodoUseCase updateTodoUseCase,
    required UpdateTodoCompletedUseCase updateTodoCompletedUseCase,
  })  : _getTodoListWithDateUseCase = getTodoListWithDateUseCase,
        _supabaseClient = supabaseClient,
        _addTodoUseCase = addTodoUseCase,
        _deleteTodoUseCase = deleteTodoUseCase,
        _updateTodoUseCase = updateTodoUseCase,
        _updateTodoCompletedUseCase = updateTodoCompletedUseCase,
        super(state);

  void init() {
    getTodoListWithDate(targetDate: state.selectedDate);
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
