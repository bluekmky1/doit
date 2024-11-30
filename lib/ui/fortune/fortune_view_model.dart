import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../common/consts/fortune_category.dart';
import 'fortune_state.dart';

final AutoDisposeStateNotifierProvider<FortuneViewModel, FortuneState>
    fortuneViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => FortuneViewModel(
    state: const FortuneState.init(),
  ),
);

class FortuneViewModel extends StateNotifier<FortuneState> {
  FortuneViewModel({
    required FortuneState state,
  }) : super(state);

  void selectFortuneCategory({required FortuneCategory fortuneCategory}) {
    state = state.copyWith(
      selectedFortuneCategory: fortuneCategory,
    );
  }
}
