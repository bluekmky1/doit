import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/routine/routine_repository.dart';

final AutoDisposeProvider<DeleteRoutineUseCase> deleteRoutineUseCaseProvider =
    Provider.autoDispose<DeleteRoutineUseCase>(
  (Ref<DeleteRoutineUseCase> ref) => DeleteRoutineUseCase(
    routineRepository: ref.read(routineRepositoryProvider),
  ),
);

class DeleteRoutineUseCase {
  final RoutineRepository _routineRepository;
  DeleteRoutineUseCase({
    required RoutineRepository routineRepository,
  }) : _routineRepository = routineRepository;

  Future<UseCaseResult<void>> call({
    required String routineId,
  }) async {
    final RepositoryResult<void> result =
        await _routineRepository.deleteRoutine(
      routineId: routineId,
    );
    return switch (result) {
      SuccessRepositoryResult<void>() => const SuccessUseCaseResult<void>(
          data: null,
        ),
      FailureRepositoryResult<void>() => FailureUseCaseResult<void>(
          message: result.messages?[0],
        )
    };
  }
}
