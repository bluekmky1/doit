import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/use_case/use_case_result.dart';
import '../../../../core/loading_status.dart';
import '../../domain/todo/model/todo_model.dart';
import '../../domain/todo/use_case/get_todo_list_use_case.dart';
import 'home_state.dart';

final AutoDisposeStateNotifierProvider<HomeViewModel, HomeState>
    homeViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => HomeViewModel(
    state: HomeState.init(),
    getTodoListUseCase: ref.watch(getTodoListUseCaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final GetTodoListUseCase _getTodoListUseCase;
  HomeViewModel({
    required HomeState state,
    required GetTodoListUseCase getTodoListUseCase,
  })  : _getTodoListUseCase = getTodoListUseCase,
        super(state);

  void init() {
    getTodoList();
  }

  Future<void> getTodoList() async {
    state = state.copyWith(
      getTodoListLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<List<TodoModel>> result = await _getTodoListUseCase();

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

  // ref.read(homeViewModelProvider.notifier).toggleDone(id);

  Future<void> toggleTodoDone({required String id}) async {
    // await _toggleDoneUseCase(id);
    state = state.copyWith(
      todoList: state.todoList
          .map((TodoModel e) => e.id == id ? e.copyWith(isDone: !e.isDone) : e)
          .toList(),
    );
  }

  Future<void> addTodo({required String todo}) async {
    // await _addTodoUseCase(todo);

    final TodoModel todoModel = TodoModel(
      id: todo,
      title: todo,
      isDone: false,
      createdAt: DateTime.now(),
    );
    state = state.copyWith(
      todoList: <TodoModel>[...state.todoList, todoModel],
    );
  }

  Future<void> deleteTodo({required String id}) async {
    // await _deleteTodoUseCase(id);
    state = state.copyWith(
      todoList: state.todoList.where((TodoModel e) => e.id != id).toList(),
    );
  }

  Future<void> updateTodo({required String id, required String title}) async {
    // await _updateTodoUseCase(id, title);
    state = state.copyWith(
      todoList: state.todoList
          .map((TodoModel e) => e.id == id ? e.copyWith(title: title) : e)
          .toList(),
    );
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
    state = state.copyWith(
      selectedDate: date,
    );
  }

  void setCurrentWeekStart({required DateTime date}) {
    state = state.copyWith(
      currentWeekStart: date,
    );
  }
}
