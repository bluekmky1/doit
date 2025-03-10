import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../core/common/use_case/use_case_result.dart';
import '../../core/loading_status.dart';
import '../../domain/routine/model/routine_model.dart';
import '../../domain/routine/use_case/add_routine_use_case.dart';
import '../../domain/routine/use_case/delete_routine_use_case.dart';
import '../../domain/routine/use_case/get_all_routine_list_use_case.dart';
import '../../domain/routine/use_case/update_routine_active_use_case.dart';
import '../../service/supabase/supabase_service.dart';
import 'routine_state.dart';

final AutoDisposeStateNotifierProvider<RoutineViewModel, RoutineState>
    routineViewModelProvider = StateNotifierProvider.autoDispose(
  (Ref ref) => RoutineViewModel(
    state: RoutineState.init(),
    supabaseClient: ref.watch(supabaseServiceProvider),
    addRoutineUseCase: ref.watch(addRoutineUseCaseProvider),
    deleteRoutineUseCase: ref.watch(deleteRoutineUseCaseProvider),
    updateRoutineActiveUseCase: ref.watch(updateRoutineActiveUseCaseProvider),
    getAllRoutineListUseCase: ref.watch(getAllRoutineListUseCaseProvider),
  ),
);

class RoutineViewModel extends StateNotifier<RoutineState> {
  final SupabaseClient _supabaseClient;
  final AddRoutineUseCase _addRoutineUseCase;
  final DeleteRoutineUseCase _deleteRoutineUseCase;
  final UpdateRoutineActiveUseCase _updateRoutineActiveUseCase;
  final GetAllRoutineListUseCase _getAllRoutineListUseCase;

  RoutineViewModel({
    required RoutineState state,
    required SupabaseClient supabaseClient,
    required AddRoutineUseCase addRoutineUseCase,
    required DeleteRoutineUseCase deleteRoutineUseCase,
    required UpdateRoutineActiveUseCase updateRoutineActiveUseCase,
    required GetAllRoutineListUseCase getAllRoutineListUseCase,
  })  : _supabaseClient = supabaseClient,
        _addRoutineUseCase = addRoutineUseCase,
        _deleteRoutineUseCase = deleteRoutineUseCase,
        _updateRoutineActiveUseCase = updateRoutineActiveUseCase,
        _getAllRoutineListUseCase = getAllRoutineListUseCase,
        super(state);

  Future<void> getAllRoutineList() async {
    state = state.copyWith(
      getRoutineListLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<List<RoutineModel>> result =
        await _getAllRoutineListUseCase(
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

  Future<void> addRoutine(String title) async {
    state = state.copyWith(
      createRoutineLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<RoutineModel> result = await _addRoutineUseCase(
      userId: _supabaseClient.auth.currentUser!.id,
      routineTitle: title,
    );

    switch (result) {
      case SuccessUseCaseResult<RoutineModel>():
        state = state.copyWith(
          routineList: <RoutineModel>[
            ...state.routineList,
            result.data,
          ],
          createRoutineLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<RoutineModel>():
        state = state.copyWith(
          createRoutineLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> deleteRoutine(String id) async {
    state = state.copyWith(
      deleteRoutineLoadingStatus: LoadingStatus.loading,
    );

    final UseCaseResult<void> result = await _deleteRoutineUseCase(
      routineId: id,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          routineList: state.routineList
              .where((RoutineModel routine) => routine.id != id)
              .toList(),
          deleteRoutineLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<void>():
        state = state.copyWith(
          deleteRoutineLoadingStatus: LoadingStatus.error,
        );
    }
  }

  Future<void> toggleRoutineActive({
    required String id,
    required bool isActive,
  }) async {
    final List<RoutineModel> oldRoutineList = state.routineList;

    state = state.copyWith(
      updateRoutineActiveLoadingStatus: LoadingStatus.loading,
      routineList: oldRoutineList
          .map(
            (RoutineModel routine) => routine.id == id
                ? routine.copyWith(isActive: !routine.isActive)
                : routine,
          )
          .toList(),
    );

    final UseCaseResult<void> result = await _updateRoutineActiveUseCase(
      routineId: id,
      isActive: isActive,
    );

    switch (result) {
      case SuccessUseCaseResult<void>():
        state = state.copyWith(
          updateRoutineActiveLoadingStatus: LoadingStatus.success,
        );
      case FailureUseCaseResult<void>():
        state = state.copyWith(
          routineList: oldRoutineList,
          updateRoutineActiveLoadingStatus: LoadingStatus.error,
        );
    }
  }
}
