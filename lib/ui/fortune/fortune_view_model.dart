import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/common/use_case/use_case_result.dart';
import '../../domain/todo/model/recommended_todo_model.dart';
import '../../domain/todo/use_case/get_recommended_todo_list_use_case.dart';
import '../common/consts/fortune_category.dart';
import 'fortune_state.dart';

final AutoDisposeStateNotifierProvider<FortuneViewModel, FortuneState>
    fortuneViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => FortuneViewModel(
    state: const FortuneState.init(),
    getRecommendedTodoListUseCase:
        ref.read(getRecommendedTodoListUseCaseProvider),
  ),
);

class FortuneViewModel extends StateNotifier<FortuneState> {
  FortuneViewModel({
    required FortuneState state,
    required GetRecommendedTodoListUseCase getRecommendedTodoListUseCase,
  })  : _getRecommendedTodoListUseCase = getRecommendedTodoListUseCase,
        super(state);

  final GetRecommendedTodoListUseCase _getRecommendedTodoListUseCase;

  Future<void> getRecommendedTodoList() async {
    final UseCaseResult<List<RecommendedTodoModel>> result =
        await _getRecommendedTodoListUseCase();

    switch (result) {
      case SuccessUseCaseResult<List<RecommendedTodoModel>>():
        state = state.copyWith(
          recommendedTodoList: result.data,
        );
      case FailureUseCaseResult<List<RecommendedTodoModel>>():
        state = state.copyWith();
    }
  }

  void selectFortuneCategory({required FortuneCategory fortuneCategory}) {
    state = state.copyWith(
      selectedFortuneCategory: fortuneCategory,
    );
  }
}
