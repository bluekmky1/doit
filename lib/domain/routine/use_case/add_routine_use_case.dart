import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/routine/entity/routine_entity.dart';
import '../../../data/routine/routine_repository.dart';
import '../model/routine_model.dart';

final AutoDisposeProvider<AddRoutineUseCase> addRoutineUseCaseProvider =
    Provider.autoDispose<AddRoutineUseCase>(
  (Ref<AddRoutineUseCase> ref) => AddRoutineUseCase(
    routineRepository: ref.read(routineRepositoryProvider),
  ),
);

class AddRoutineUseCase {
  final RoutineRepository _routineRepository;
  AddRoutineUseCase({
    required RoutineRepository routineRepository,
  }) : _routineRepository = routineRepository;

  Future<UseCaseResult<RoutineModel>> call({
    required String userId,
    required String routineTitle,
  }) async {
    final RepositoryResult<RoutineEntity> result =
        await _routineRepository.addRoutine(
      userId: userId,
      routineTitle: routineTitle,
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
