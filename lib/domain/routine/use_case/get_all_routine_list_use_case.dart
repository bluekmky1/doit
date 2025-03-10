import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/routine/entity/routine_entity.dart';
import '../../../data/routine/routine_repository.dart';
import '../model/routine_model.dart';

final AutoDisposeProvider<GetAllRoutineListUseCase>
    getAllRoutineListUseCaseProvider =
    Provider.autoDispose<GetAllRoutineListUseCase>(
  (Ref<GetAllRoutineListUseCase> ref) => GetAllRoutineListUseCase(
    routineRepository: ref.read(routineRepositoryProvider),
  ),
);

class GetAllRoutineListUseCase {
  final RoutineRepository _routineRepository;
  GetAllRoutineListUseCase({
    required RoutineRepository routineRepository,
  }) : _routineRepository = routineRepository;

  Future<UseCaseResult<List<RoutineModel>>> call({
    required String userId,
  }) async {
    final RepositoryResult<List<RoutineEntity>> repositoryResult =
        await _routineRepository.getRoutineList(userId: userId);
    return switch (repositoryResult) {
      SuccessRepositoryResult<List<RoutineEntity>>() =>
        SuccessUseCaseResult<List<RoutineModel>>(
          data: List<RoutineModel>.generate(
            repositoryResult.data.length,
            (int index) => RoutineModel.fromEntity(
              entity: repositoryResult.data[index],
            ),
          ),
        ),
      FailureRepositoryResult<List<RoutineEntity>>() =>
        FailureUseCaseResult<List<RoutineModel>>(
          message: repositoryResult.messages?[0],
        )
    };
  }
}
