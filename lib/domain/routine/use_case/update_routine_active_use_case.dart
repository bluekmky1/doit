import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/routine/entity/routine_entity.dart';
import '../../../data/routine/routine_repository.dart';
import '../model/routine_model.dart';

final AutoDisposeProvider<UpdateRoutineActiveUseCase>
    updateRoutineActiveUseCaseProvider =
    Provider.autoDispose<UpdateRoutineActiveUseCase>(
  (Ref<UpdateRoutineActiveUseCase> ref) => UpdateRoutineActiveUseCase(
    routineRepository: ref.read(routineRepositoryProvider),
  ),
);

class UpdateRoutineActiveUseCase {
  final RoutineRepository _routineRepository;
  UpdateRoutineActiveUseCase({
    required RoutineRepository routineRepository,
  }) : _routineRepository = routineRepository;

  Future<UseCaseResult<RoutineModel>> call({
    required String routineId,
    required bool isActive,
  }) async {
    final RepositoryResult<RoutineEntity> result =
        await _routineRepository.updateRoutineActive(
      routineId: routineId,
      isActive: isActive,
    );
    return switch (result) {
      SuccessRepositoryResult<RoutineEntity>() =>
        SuccessUseCaseResult<RoutineModel>(
          data: RoutineModel.fromEntity(entity: result.data),
        ),
      FailureRepositoryResult<RoutineEntity>() =>
        FailureUseCaseResult<RoutineModel>(
          message: result.messages?[0],
        )
    };
  }
}
