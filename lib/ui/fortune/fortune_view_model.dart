import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/fortune/create_fortune_use_case.dart';
import '../../domain/fortune/get_fortune_use_case.dart';
import '../../domain/fortune/model/fortune_model.dart';
import '../../domain/todo/model/recommended_todo_model.dart';
import '../../domain/todo/model/todo_model.dart';
import '../../domain/todo/use_case/add_todo_by_recommend_use_case.dart';
import '../../domain/todo/use_case/get_recommended_todo_list_use_case.dart';
import '../../domain/user/model/user_data_model.dart';
import '../../domain/user/use_case/get_user_data.dart';
import '../../service/supabase/supabase_service.dart';
import '../../util/date_time_format_helper.dart';
import '../common/consts/fortune_category.dart';
import 'fortune_state.dart';

final AutoDisposeStateNotifierProvider<FortuneViewModel, FortuneState>
    fortuneViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => FortuneViewModel(
    state: FortuneState.init(),
    supabaseClient: ref.read(supabaseServiceProvider),
    createFortuneUseCase: ref.read(createFortuneUseCaseProvider),
    getFortuneUseCase: ref.read(getFortuneUseCaseProvider),
    getUserDataUseCase: ref.read(getUserDataUseCaseProvider),
    getRecommendedTodoListUseCase:
        ref.read(getRecommendedTodoListUseCaseProvider),
    addTodoByRecommendUseCase: ref.read(addTodoByRecommendUseCaseProvider),
  ),
);

class FortuneViewModel extends StateNotifier<FortuneState> {
  FortuneViewModel({
    required FortuneState state,
    required CreateFortuneUseCase createFortuneUseCase,
    required GetFortuneUseCase getFortuneUseCase,
    required GetUserDataUseCase getUserDataUseCase,
    required GetRecommendedTodoListUseCase getRecommendedTodoListUseCase,
    required SupabaseClient supabaseClient,
    required AddTodoByRecommendUseCase addTodoByRecommendUseCase,
  })  : _supabaseClient = supabaseClient,
        _createFortuneUseCase = createFortuneUseCase,
        _getFortuneUseCase = getFortuneUseCase,
        _getUserDataUseCase = getUserDataUseCase,
        _getRecommendedTodoListUseCase = getRecommendedTodoListUseCase,
        _addTodoByRecommendUseCase = addTodoByRecommendUseCase,
        super(state);

  final SupabaseClient _supabaseClient;
  final CreateFortuneUseCase _createFortuneUseCase;
  final GetFortuneUseCase _getFortuneUseCase;
  final GetUserDataUseCase _getUserDataUseCase;
  final GetRecommendedTodoListUseCase _getRecommendedTodoListUseCase;
  final AddTodoByRecommendUseCase _addTodoByRecommendUseCase;
  Future<void> getUserData() async {
    state = state.copyWith(
      getUserDataLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<UserDataModel> result = await _getUserDataUseCase(
      userId: _supabaseClient.auth.currentUser!.id,
    );

    switch (result) {
      case SuccessUseCaseResult<UserDataModel>():
        final String formattedBirthDate = '${result.data.lunarSolar} '
            '${DateTimeFormatter.getFullDate(result.data.birthDate)}';
        final String formattedBirthTime =
            DateTimeFormatter.getTimeString(result.data.birthDate);

        state = state.copyWith(
          userId: result.data.id,
          birthDate: formattedBirthDate,
          birthTime: formattedBirthTime,
          gender: result.data.gender,
          getUserDataLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<UserDataModel>():
        state = state.copyWith(
          getUserDataLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> createFortune() async {
    state = state.copyWith(
      createFortuneLoadingStatus: LoadingStatus.loading,
      getFortuneLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<FortuneModel> result = await _createFortuneUseCase(
      userId: state.userId,
      birthDate: state.birthDate,
      birthTime: state.birthTime,
      gender: state.gender,
      createdAt: DateTime.now(),
    );

    switch (result) {
      case SuccessUseCaseResult<FortuneModel>():
        state = state.copyWith(
          createFortuneLoadingStatus: LoadingStatus.success,
          getFortuneLoadingStatus: LoadingStatus.success,
          fortuneSummary: result.data.summary,
          fortuneDetails: result.data.details,
          fortuneCreatedAt: result.data.createdAt,
        );
      case FailureUseCaseResult<FortuneModel>():
        state = state.copyWith(
          createFortuneLoadingStatus: LoadingStatus.error,
          getFortuneLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> getFortune() async {
    state = state.copyWith(
      getFortuneLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<FortuneModel> result = await _getFortuneUseCase(
      userId: _supabaseClient.auth.currentUser!.id,
    );

    switch (result) {
      case SuccessUseCaseResult<FortuneModel>():
        state = state.copyWith(
          getFortuneLoadingStatus: LoadingStatus.success,
          fortuneSummary: result.data.summary,
          fortuneDetails: result.data.details,
          fortuneCreatedAt: result.data.createdAt,
        );
      case FailureUseCaseResult<FortuneModel>():
        state = state.copyWith(
          getFortuneLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> getRecommendedTodoList() async {
    state = state.copyWith(
      getRecommendedTodoListLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<List<RecommendedTodoModel>> result =
        await _getRecommendedTodoListUseCase(
      userId: _supabaseClient.auth.currentUser!.id,
    );

    switch (result) {
      case SuccessUseCaseResult<List<RecommendedTodoModel>>():
        state = state.copyWith(
          getRecommendedTodoListLoadingStatus: LoadingStatus.success,
          recommendedTodoList: result.data
            ..sort(
              (RecommendedTodoModel a, RecommendedTodoModel b) =>
                  a.id.compareTo(b.id),
            ),
        );
      case FailureUseCaseResult<List<RecommendedTodoModel>>():
        state = state.copyWith(
          getRecommendedTodoListLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> addTodoByRecommend({
    required String recommendId,
    required String title,
  }) async {
    state = state.copyWith(
      addTodoByRecommendLoadingStatus: LoadingStatus.loading,
    );
    final DateTime now = DateTime.now();

    final DateTime dueDate = DateTime(
      now.year,
      now.month,
      now.day,
    );

    final UseCaseResult<TodoModel> result = await _addTodoByRecommendUseCase(
      userId: state.userId,
      title: title,
      dueDate: dueDate,
      recommendId: recommendId,
    );

    switch (result) {
      case SuccessUseCaseResult<TodoModel>():
        state = state.copyWith(
          addTodoByRecommendLoadingStatus: LoadingStatus.success,
          recommendedTodoList:
              state.recommendedTodoList.map((RecommendedTodoModel todo) {
            if (todo.id == recommendId) {
              return todo.copyWith(isAdded: true);
            }
            return todo;
          }).toList(),
        );
      case FailureUseCaseResult<TodoModel>():
        state = state.copyWith(
          addTodoByRecommendLoadingStatus: LoadingStatus.error,
        );
    }
  }

  void selectFortuneCategory({required FortuneCategory fortuneCategory}) {
    state = state.copyWith(
      selectedFortuneCategory: fortuneCategory,
    );
  }
}
