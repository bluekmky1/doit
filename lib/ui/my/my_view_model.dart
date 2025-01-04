import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/common/use_case/use_case_result.dart';
import '../../../../core/loading_status.dart';
import '../../domain/animal/model/animal_marker_model.dart';
import '../../domain/todo/model/todo_model.dart';
import '../../domain/todo/use_case/get_todo_list_with_period_use_case copy.dart';
import '../../domain/user/model/user_data_model.dart';
import '../../domain/user/use_case/get_user_data.dart';
import '../../service/supabase/supabase_service.dart';
import '../common/consts/animal_type.dart';
import 'my_state.dart';

final AutoDisposeStateNotifierProvider<MyViewModel, MyState>
    myViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => MyViewModel(
    state: MyState.init(),
    getTodoListWithPeriodUseCase:
        ref.watch(getTodoListWithPeriodUseCaseProvider),
    supabaseClient: ref.watch(supabaseServiceProvider),
    getUserDataUseCase: ref.watch(getUserDataUseCaseProvider),
  ),
);

class MyViewModel extends StateNotifier<MyState> {
  final GetTodoListWithPeriodUseCase _getTodoListWithPeriodUseCase;
  final SupabaseClient _supabaseClient;
  final GetUserDataUseCase _getUserDataUseCase;
  MyViewModel({
    required MyState state,
    required GetTodoListWithPeriodUseCase getTodoListWithPeriodUseCase,
    required SupabaseClient supabaseClient,
    required GetUserDataUseCase getUserDataUseCase,
  })  : _getTodoListWithPeriodUseCase = getTodoListWithPeriodUseCase,
        _supabaseClient = supabaseClient,
        _getUserDataUseCase = getUserDataUseCase,
        super(state);

  void init() {
    getUserData();
    getThisMonthTodoList();
  }

  Future<void> getUserData() async {
    state = state.copyWith(
      getUserDataLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<UserDataModel> result = await _getUserDataUseCase(
      userId: _supabaseClient.auth.currentUser!.id,
    );

    switch (result) {
      case SuccessUseCaseResult<UserDataModel>():
        state = state.copyWith(
          userName: result.data.nickname,
          birthDate: result.data.birthDate,
          unknownBirthTime: result.data.unknownBirthTime,
          gender: result.data.gender,
          lunarSolar: result.data.lunarSolar,
          getUserDataLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<UserDataModel>():
        state = state.copyWith(
          getUserDataLoadingStatus: LoadingStatus.error,
        );
    }
  }

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

        final List<AnimalMarkerModel> newAnimalMarkerList =
            state.animalMarkerList;

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
          animalMarkerList: newAnimalMarkerList,
          completedTodoCount: completedCount,
          getTodoListLoadingStatus: LoadingStatus.success,
        );

      case FailureUseCaseResult<List<TodoModel>>():
        state = state.copyWith(
          getTodoListLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> signOut() async {
    final Session? session = _supabaseClient.auth.currentSession;
    if (session != null) {
      await _supabaseClient.auth.signOut();
    }
  }
}
