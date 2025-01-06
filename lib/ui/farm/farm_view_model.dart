import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/animal/model/animal_marker_model.dart';
import '../../domain/todo/model/todo_model.dart';
import '../../domain/todo/use_case/get_todo_list_with_period_use_case.dart';
import '../../service/supabase/supabase_service.dart';
import '../common/consts/animal_type.dart';
import 'farm_state.dart';

final AutoDisposeStateNotifierProvider<FarmViewModel, FarmState>
    farmViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => FarmViewModel(
    state: FarmState.init(),
    getTodoListWithPeriodUseCase:
        ref.read(getTodoListWithPeriodUseCaseProvider),
    supabaseClient: ref.read(supabaseServiceProvider),
  ),
);

class FarmViewModel extends StateNotifier<FarmState> {
  FarmViewModel({
    required FarmState state,
    required GetTodoListWithPeriodUseCase getTodoListWithPeriodUseCase,
    required SupabaseClient supabaseClient,
  })  : _getTodoListWithPeriodUseCase = getTodoListWithPeriodUseCase,
        _supabaseClient = supabaseClient,
        super(state);

  final GetTodoListWithPeriodUseCase _getTodoListWithPeriodUseCase;
  final SupabaseClient _supabaseClient;

  Future<void> getThisMonthTodoList() async {
    state = state.copyWith(
      getTodoListLoadingStatus: LoadingStatus.loading,
    );

    // 이번달 초부터 오늘까지 한 일 조회
    final DateTime now = DateTime.now();
    final DateTime startDate = DateTime(now.year, now.month);
    final DateTime endDate = now.copyWith(
      day: now.day,
    );

    final UseCaseResult<List<TodoModel>> result =
        await _getTodoListWithPeriodUseCase(
      userId: _supabaseClient.auth.currentUser!.id,
      startDate: startDate,
      endDate: endDate,
    );

    switch (result) {
      case SuccessUseCaseResult<List<TodoModel>>():
        int completedCount = 0;
        final List<TodoModel> todoList = result.data;

        final List<AnimalMarkerModel> newAnimalMarkerList = state.animalList;

        for (final TodoModel todo in todoList) {
          final AnimalType animalType = AnimalType.values.firstWhere(
            (AnimalType animal) => animal.name == todo.animalName,
          );
          if (todo.isCompleted) {
            completedCount++;
            newAnimalMarkerList[animalType.index] =
                newAnimalMarkerList[animalType.index].copyWith(
              count: newAnimalMarkerList[animalType.index].count + 1,
            );
          }
        }

        state = state.copyWith(
          animalList: newAnimalMarkerList,
          animalCount: completedCount,
          getTodoListLoadingStatus: LoadingStatus.success,
        );

      case FailureUseCaseResult<List<TodoModel>>():
        state = state.copyWith(
          getTodoListLoadingStatus: LoadingStatus.error,
        );
    }
  }

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
