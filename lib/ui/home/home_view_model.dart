import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/use_case/use_case_result.dart';
import '../../../../core/loading_status.dart';
import '../../domain/todo/model/recommended_todo_model.dart';
import '../../domain/todo/model/todo_model.dart';
import '../../domain/todo/use_case/get_recommended_todo_list_use_case.dart';
import '../../domain/todo/use_case/get_todo_list_use_case.dart';
import 'home_state.dart';

final AutoDisposeStateNotifierProvider<HomeViewModel, HomeState>
    homeViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => HomeViewModel(
    state: const HomeState.init(),
    getTodoListUseCase: ref.watch(getTodoListUseCaseProvider),
    getRecommendedTodoListUseCase:
        ref.watch(getRecommendedTodoListUseCaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<HomeState> {
  final GetTodoListUseCase _getTodoListUseCase;
  final GetRecommendedTodoListUseCase _getRecommendedTodoListUseCase;
  HomeViewModel({
    required HomeState state,
    required GetTodoListUseCase getTodoListUseCase,
    required GetRecommendedTodoListUseCase getRecommendedTodoListUseCase,
  })  : _getTodoListUseCase = getTodoListUseCase,
        _getRecommendedTodoListUseCase = getRecommendedTodoListUseCase,
        super(state);

  void init() {
    getTodoList();
    getRecommendedTodoList();
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

  Future<void> getRecommendedTodoList() async {
    state = state.copyWith(
      getRecommendedTodoListLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<List<RecommendedTodoModel>> result =
        await _getRecommendedTodoListUseCase();

    switch (result) {
      case SuccessUseCaseResult<List<RecommendedTodoModel>>():
        state = state.copyWith(
          recommendedTodoList: result.data,
          getRecommendedTodoListLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<List<RecommendedTodoModel>>():
        state = state.copyWith(
          getRecommendedTodoListLoadingStatus: LoadingStatus.error,
        );
    }
  }

  // ref.read(homeViewModelProvider.notifier).toggleDone(id);

  Future<void> toggleRecommendedTodoDone({required String id}) async {
    // await _toggleDoneUseCase(id);
    state = state.copyWith(
      recommendedTodoList: state.recommendedTodoList
          .map((RecommendedTodoModel e) =>
              e.id == id ? e.copyWith(isDone: !e.isDone) : e)
          .toList(),
    );
  }

  Future<void> toggleTodoDone({required String id}) async {
    // await _toggleDoneUseCase(id);
    state = state.copyWith(
      todoList: state.todoList
          .map((TodoModel e) => e.id == id ? e.copyWith(isDone: !e.isDone) : e)
          .toList(),
    );
  }

  Future<void> addTodo({required TodoModel todo}) async {
    // await _addTodoUseCase(todo);
    state = state.copyWith(
      todoList: <TodoModel>[...state.todoList, todo],
    );
  }
}
