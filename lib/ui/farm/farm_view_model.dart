import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'farm_state.dart';

final AutoDisposeStateNotifierProvider<FarmViewModel, FarmState>
    farmViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => FarmViewModel(
    state: const FarmState.init(),
  ),
);

class FarmViewModel extends StateNotifier<FarmState> {
  FarmViewModel({
    required FarmState state,
  }) : super(state);

  void setCurrentWeekStart() {
    state = state.copyWith();
  }

  void setIsAnimalButtonSelected() {
    state =
        state.copyWith(isAnimalButtonSelected: !state.isAnimalButtonSelected);
  }

  void setIsClockButtonSelected() {
    state = state.copyWith(isClockButtonSelected: !state.isClockButtonSelected);
  }
}
