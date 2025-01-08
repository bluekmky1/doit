import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/common/repository/repository_result.dart';
import '../../../core/common/use_case/use_case_result.dart';
import '../../../data/fortune/fortune_repository.dart';
import '../../data/fortune/entity/fortune_entity.dart';
import 'model/fortune_model.dart';

final AutoDisposeProvider<GetFortuneUseCase> getFortuneUseCaseProvider =
    Provider.autoDispose<GetFortuneUseCase>(
  (Ref<GetFortuneUseCase> ref) => GetFortuneUseCase(
    fortuneRepository: ref.read(fortuneRepositoryProvider),
  ),
);

class GetFortuneUseCase {
  final FortuneRepository _fortuneRepository;
  GetFortuneUseCase({
    required FortuneRepository fortuneRepository,
  }) : _fortuneRepository = fortuneRepository;

  Future<UseCaseResult<FortuneModel>> call({
    required String userId,
  }) async {
    final RepositoryResult<FortuneResponseEntity> result =
        await _fortuneRepository.getFortune(
      userId: userId,
    );
    return switch (result) {
      SuccessRepositoryResult<FortuneResponseEntity>() =>
        SuccessUseCaseResult<FortuneModel>(
          data: FortuneModel.fromEntity(entity: result.data),
        ),
      FailureRepositoryResult<FortuneResponseEntity>() =>
        FailureUseCaseResult<FortuneModel>(
          message: result.messages?[0],
        )
    };
  }
}
